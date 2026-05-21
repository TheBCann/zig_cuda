//! Attention forward pass: integrated end-to-end pipeline.
//!
//!   scores  = (Q @ K^T) / sqrt(d)        — kernel 1
//!   weights = softmax(scores, axis=-1)   — kernel 2
//!   output  = weights @ V                — kernel 3
//!
//! All three kernels run on device, no host round-trips between them.
//! Verifies the final output against a CPU attention reference.

const std = @import("std");
const cuda = @import("cuda");

const N: u32 = 512; // sequence length
const D: u32 = 64; // head dimension
const TILE: u32 = 16; // tile size for the matmul kernels
const SOFTMAX_BLOCK: u32 = 256;

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;
    const io = init.io;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});
    std.debug.print("N={d}, d={d}\n", .{ N, D });

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    // Per-kernel argument structs.
    const ScoresArgs = struct {
        n: u32,
        d: u32,
        inv_sqrt_d: f32,
        q: cuda.bindings.CUdeviceptr,
        k: cuda.bindings.CUdeviceptr,
        scores: cuda.bindings.CUdeviceptr,
    };
    const SoftmaxArgs = struct {
        n: u32,
        input: cuda.bindings.CUdeviceptr,
        output: cuda.bindings.CUdeviceptr,
    };
    const OutputArgs = struct {
        n: u32,
        d: u32,
        weights: cuda.bindings.CUdeviceptr,
        v: cuda.bindings.CUdeviceptr,
        output: cuda.bindings.CUdeviceptr,
    };

    // One PTX module, three function handles.
    const module = try cuda.Module.loadData(@embedFile("kernel_ptx"));
    defer module.unload();
    const scores_kernel = try module.getFunction(ScoresArgs, "kernel_$_scores_f32_16");
    const softmax_kernel = try module.getFunction(SoftmaxArgs, "kernel_$_softmax_f32_256");
    const output_kernel = try module.getFunction(OutputArgs, "kernel_$_output_f32_16");

    const qkv_elements: u32 = N * D;
    const scores_elements: u32 = N * N;

    // ── Host buffers ─────────────────────────────────────────────────
    const host_q = try a.alloc(f32, qkv_elements);
    defer a.free(host_q);
    const host_k = try a.alloc(f32, qkv_elements);
    defer a.free(host_k);
    const host_v = try a.alloc(f32, qkv_elements);
    defer a.free(host_v);
    const host_output = try a.alloc(f32, qkv_elements);
    defer a.free(host_output);
    const cpu_output = try a.alloc(f32, qkv_elements);
    defer a.free(cpu_output);

    var rng = std.Random.DefaultPrng.init(0xA11E7A10);
    const rand = rng.random();
    for (host_q) |*x| x.* = rand.float(f32) - 0.5;
    for (host_k) |*x| x.* = rand.float(f32) - 0.5;
    for (host_v) |*x| x.* = rand.float(f32) - 0.5;

    const inv_sqrt_d: f32 = 1.0 / std.math.sqrt(@as(f32, @floatFromInt(D)));

    // ── CPU reference: full attention ────────────────────────────────
    const cpu_start: std.Io.Clock.Timestamp = .now(io, .awake);
    try cpuAttention(a, host_q, host_k, host_v, cpu_output, N, D, inv_sqrt_d);
    const cpu_us = cpu_start.untilNow(io).raw.toMicroseconds();
    const cpu_ms = @as(f32, @floatFromInt(cpu_us)) / 1000.0;

    // ── GPU: allocate device buffers ─────────────────────────────────
    const Buf = cuda.DeviceBuffer(f32);
    const dev_q = try Buf.alloc(qkv_elements);
    defer dev_q.free();
    const dev_k = try Buf.alloc(qkv_elements);
    defer dev_k.free();
    const dev_v = try Buf.alloc(qkv_elements);
    defer dev_v.free();
    const dev_scores = try Buf.alloc(scores_elements);
    defer dev_scores.free();
    const dev_weights = try Buf.alloc(scores_elements);
    defer dev_weights.free();
    const dev_output = try Buf.alloc(qkv_elements);
    defer dev_output.free();

    try dev_q.copyFromHost(host_q);
    try dev_k.copyFromHost(host_k);
    try dev_v.copyFromHost(host_v);

    // ── GPU: three kernels back-to-back, per-kernel timing ───────────
    const e_pre = try cuda.Event.create();
    defer e_pre.deinit();
    const e_after_scores = try cuda.Event.create();
    defer e_after_scores.deinit();
    const e_after_softmax = try cuda.Event.create();
    defer e_after_softmax.deinit();
    const e_after_output = try cuda.Event.create();
    defer e_after_output.deinit();

    const scores_grid: c_uint = N / TILE;
    const output_grid_x: c_uint = D / TILE;
    const output_grid_y: c_uint = N / TILE;

    try e_pre.record(null);

    // 1. scores = (Q @ K^T) / sqrt(d)
    try scores_kernel.launch(.{
        .grid = .{ .x = scores_grid, .y = scores_grid },
        .block = .{ .x = TILE, .y = TILE },
    }, .{
        .n = N,
        .d = D,
        .inv_sqrt_d = inv_sqrt_d,
        .q = dev_q.ptr,
        .k = dev_k.ptr,
        .scores = dev_scores.ptr,
    });
    try e_after_scores.record(null);

    // 2. weights = softmax(scores)
    try softmax_kernel.launch(.{
        .grid = .{ .x = N },
        .block = .{ .x = SOFTMAX_BLOCK },
    }, .{
        .n = N,
        .input = dev_scores.ptr,
        .output = dev_weights.ptr,
    });
    try e_after_softmax.record(null);

    // 3. output = weights @ V
    try output_kernel.launch(.{
        .grid = .{ .x = output_grid_x, .y = output_grid_y },
        .block = .{ .x = TILE, .y = TILE },
    }, .{
        .n = N,
        .d = D,
        .weights = dev_weights.ptr,
        .v = dev_v.ptr,
        .output = dev_output.ptr,
    });
    try e_after_output.record(null);

    try e_after_output.synchronize();

    const scores_ms = try cuda.Event.elapsed(e_pre, e_after_scores);
    const softmax_ms = try cuda.Event.elapsed(e_after_scores, e_after_softmax);
    const output_ms = try cuda.Event.elapsed(e_after_softmax, e_after_output);
    const total_ms = try cuda.Event.elapsed(e_pre, e_after_output);

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

    // ── Report ───────────────────────────────────────────────────────
    std.debug.print("\nPipeline timing (GPU, kernel-only):\n", .{});
    std.debug.print("  scores  : {d:.3} ms\n", .{scores_ms});
    std.debug.print("  softmax : {d:.3} ms\n", .{softmax_ms});
    std.debug.print("  output  : {d:.3} ms\n", .{output_ms});
    std.debug.print("  ─────────\n", .{});
    std.debug.print("  total   : {d:.3} ms\n", .{total_ms});

    std.debug.print("\nCorrectness vs CPU reference (full forward pass):\n", .{});
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

    std.debug.print("\nSample output[0..3, 0..3]:\n", .{});
    var r: u32 = 0;
    while (r < 3) : (r += 1) {
        var c: u32 = 0;
        while (c < 3) : (c += 1) {
            std.debug.print("  {d:>9.5}", .{host_output[r * D + c]});
        }
        std.debug.print("\n", .{});
    }

    std.debug.print("\nCPU attention:  {d:.3} ms\n", .{cpu_ms});
    std.debug.print("GPU attention:  {d:.3} ms  ({d:.1}x vs CPU)\n", .{
        total_ms, cpu_ms / total_ms,
    });
}

/// CPU reference: full attention forward pass.
/// Computes scores, softmax, output through scratch buffers.
fn cpuAttention(
    allocator: std.mem.Allocator,
    q: []const f32,
    k: []const f32,
    v: []const f32,
    output: []f32,
    n: u32,
    d: u32,
    inv_sqrt_d: f32,
) !void {
    const scores = try allocator.alloc(f32, n * n);
    defer allocator.free(scores);
    const weights = try allocator.alloc(f32, n * n);
    defer allocator.free(weights);

    // scores = (Q @ K^T) / sqrt(d)
    var i: u32 = 0;
    while (i < n) : (i += 1) {
        var j: u32 = 0;
        while (j < n) : (j += 1) {
            var acc: f32 = 0;
            var kk: u32 = 0;
            while (kk < d) : (kk += 1) {
                acc += q[i * d + kk] * k[j * d + kk];
            }
            scores[i * n + j] = acc * inv_sqrt_d;
        }
    }

    // weights = softmax(scores, axis=-1)  -- numerically stable
    var row: u32 = 0;
    while (row < n) : (row += 1) {
        const base = row * n;

        var row_max: f32 = -std.math.inf(f32);
        var col: u32 = 0;
        while (col < n) : (col += 1) {
            const x = scores[base + col];
            if (x > row_max) row_max = x;
        }

        var row_sum: f32 = 0;
        col = 0;
        while (col < n) : (col += 1) {
            const e = @exp(scores[base + col] - row_max);
            weights[base + col] = e;
            row_sum += e;
        }

        const inv_sum: f32 = 1.0 / row_sum;
        col = 0;
        while (col < n) : (col += 1) {
            weights[base + col] *= inv_sum;
        }
    }

    // output = weights @ V
    i = 0;
    while (i < n) : (i += 1) {
        var kk: u32 = 0;
        while (kk < d) : (kk += 1) {
            var acc: f32 = 0;
            var j: u32 = 0;
            while (j < n) : (j += 1) {
                acc += weights[i * n + j] * v[j * d + kk];
            }
            output[i * d + kk] = acc;
        }
    }
}
