//! Attention output kernel test: output = weights @ V
//!
//! Verifies against a CPU reference, then benchmarks. Second tiled
//! matmul in the unfused attention pipeline; the contraction axis is N
//! (sequence length) and gets tiled in shared memory.

const std = @import("std");
const cuda = @import("cuda");

const N: u32 = 512; // sequence length
const D: u32 = 64; // head dimension
const TILE: u32 = 16; // must match the named kernel

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;
    const io = init.io;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    const OutputArgs = struct {
        n: u32,
        d: u32,
        weights: cuda.bindings.CUdeviceptr,
        v: cuda.bindings.CUdeviceptr,
        output: cuda.bindings.CUdeviceptr,
    };

    const module = try cuda.Module.loadData(@embedFile("kernel_ptx"));
    defer module.unload();
    const kernel = try module.getFunction(OutputArgs, "kernel_$_output_f32_16");

    const weights_elements: u32 = N * N;
    const v_elements: u32 = N * D;
    const output_elements: u32 = N * D;

    // ── Host buffers ─────────────────────────────────────────────────
    const host_weights = try a.alloc(f32, weights_elements);
    defer a.free(host_weights);
    const host_v = try a.alloc(f32, v_elements);
    defer a.free(host_v);
    const host_output = try a.alloc(f32, output_elements);
    defer a.free(host_output);
    const cpu_output = try a.alloc(f32, output_elements);
    defer a.free(cpu_output);

    // ── Synthesize row-stochastic weights ────────────────────────────
    // Fill with uniform random [0, 1], then normalize each row to sum 1.
    // This produces something shaped like a softmax output without going
    // through the full pipeline yet.
    var rng = std.Random.DefaultPrng.init(0xBEEFCAFE);
    const rand = rng.random();
    for (host_weights) |*v| v.* = rand.float(f32);

    var row: u32 = 0;
    while (row < N) : (row += 1) {
        var sum: f32 = 0;
        var col: u32 = 0;
        while (col < N) : (col += 1) {
            sum += host_weights[row * N + col];
        }
        const inv_sum: f32 = 1.0 / sum;
        col = 0;
        while (col < N) : (col += 1) {
            host_weights[row * N + col] *= inv_sum;
        }
    }

    // V values in [-0.5, 0.5].
    for (host_v) |*x| x.* = rand.float(f32) - 0.5;

    // ── CPU reference ────────────────────────────────────────────────
    const cpu_start: std.Io.Clock.Timestamp = .now(io, .awake);
    cpuOutput(host_weights, host_v, cpu_output, N, D);
    const cpu_us = cpu_start.untilNow(io).raw.toMicroseconds();
    const cpu_ms = @as(f32, @floatFromInt(cpu_us)) / 1000.0;

    // ── GPU ──────────────────────────────────────────────────────────
    const Buf = cuda.DeviceBuffer(f32);
    const dev_weights = try Buf.alloc(weights_elements);
    defer dev_weights.free();
    const dev_v = try Buf.alloc(v_elements);
    defer dev_v.free();
    const dev_output = try Buf.alloc(output_elements);
    defer dev_output.free();

    try dev_weights.copyFromHost(host_weights);
    try dev_v.copyFromHost(host_v);

    const k_start = try cuda.Event.create();
    defer k_start.deinit();
    const k_end = try cuda.Event.create();
    defer k_end.deinit();

    const grid_x: c_uint = D / TILE; // 4
    const grid_y: c_uint = N / TILE; // 32

    try k_start.record(null);
    try kernel.launch(.{
        .grid = .{ .x = grid_x, .y = grid_y },
        .block = .{ .x = TILE, .y = TILE },
    }, .{
        .n = N,
        .d = D,
        .weights = dev_weights.ptr,
        .v = dev_v.ptr,
        .output = dev_output.ptr,
    });
    try k_end.record(null);
    try k_end.synchronize();
    const kernel_ms = try cuda.Event.elapsed(k_start, k_end);

    try dev_output.copyToHost(host_output);

    // ── Verify ───────────────────────────────────────────────────────
    var max_abs_err: f32 = 0;
    var max_rel_err: f32 = 0;
    var first_bad: ?usize = null;

    for (host_output, cpu_output, 0..) |gpu, cpu, idx| {
        const abs_err = @abs(gpu - cpu);
        if (abs_err > max_abs_err) max_abs_err = abs_err;

        if (@abs(cpu) > 1e-4) {
            const rel = abs_err / @abs(cpu);
            if (rel > max_rel_err) max_rel_err = rel;
        }

        if (abs_err > 1e-3 and first_bad == null) first_bad = idx;
    }

    // ── Performance ──────────────────────────────────────────────────
    // FLOPs ≈ 2 * N * N * d (one multiply + one add per inner-loop step;
    // inner loop runs N times across N*d output elements)
    const flops: f64 = @as(f64, @floatFromInt(2)) *
        @as(f64, @floatFromInt(N)) *
        @as(f64, @floatFromInt(N)) *
        @as(f64, @floatFromInt(D));
    const gpu_gflops = flops / (@as(f64, kernel_ms) * 1.0e6);

    std.debug.print("\n", .{});
    std.debug.print("weights: {d}x{d}, V: {d}x{d}, output: {d}x{d}\n", .{
        N, N, N, D, N, D,
    });
    std.debug.print("Grid: {d}x{d}, Block: {d}x{d} ({d} threads/block)\n", .{
        grid_x, grid_y, TILE, TILE, TILE * TILE,
    });
    std.debug.print("\n", .{});
    std.debug.print("Correctness vs CPU reference:\n", .{});
    std.debug.print("  Max absolute error: {e:.3}\n", .{max_abs_err});
    std.debug.print("  Max relative error: {e:.3}\n", .{max_rel_err});
    if (first_bad) |idx| {
        const r = idx / D;
        const c = idx % D;
        std.debug.print("  First large mismatch: row {d} col {d} — gpu={d}, cpu={d}\n", .{
            r, c, host_output[idx], cpu_output[idx],
        });
    } else {
        std.debug.print("  No mismatches above 1e-3 threshold.\n", .{});
    }
    if (first_bad != null) return error.VerificationFailed;

    // Sanity print: show the corner 3x3 of the output.
    std.debug.print("\nSample output[0..3, 0..3]:\n", .{});
    var r: u32 = 0;
    while (r < 3) : (r += 1) {
        var c: u32 = 0;
        while (c < 3) : (c += 1) {
            std.debug.print("  {d:>9.5}", .{host_output[r * D + c]});
        }
        std.debug.print("\n", .{});
    }

    std.debug.print("\n", .{});
    std.debug.print("CPU output:  {d:.3} ms\n", .{cpu_ms});
    std.debug.print("GPU output:  {d:.3} ms  ({d:.1}x vs CPU, {d:.1} GFLOPS)\n", .{
        kernel_ms, cpu_ms / kernel_ms, gpu_gflops,
    });
}

/// CPU reference: output[i][k] = sum_j weights[i][j] * V[j][k]
fn cpuOutput(
    weights: []const f32,
    v: []const f32,
    output: []f32,
    n: u32,
    d: u32,
) void {
    var i: u32 = 0;
    while (i < n) : (i += 1) {
        var k: u32 = 0;
        while (k < d) : (k += 1) {
            var acc: f32 = 0;
            var j: u32 = 0;
            while (j < n) : (j += 1) {
                acc += weights[i * n + j] * v[j * d + k];
            }
            output[i * d + k] = acc;
        }
    }
}
