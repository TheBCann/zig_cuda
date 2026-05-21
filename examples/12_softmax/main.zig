//! Row-wise softmax example.
//!
//! Computes softmax along axis=1 of an (N, N) input matrix using the
//! numerically stable formulation (subtract row max before exp).
//!
//! Verifies against a CPU reference, then benchmarks. This kernel is
//! the building block for the softmax step inside the attention forward
//! pass (next example).

const std = @import("std");
const cuda = @import("cuda");

const N: u32 = 512; // rows AND cols — input is (N, N)
const BLOCK_SIZE: u32 = 256; // must match the named kernel below

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;
    const io = init.io;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    const SoftmaxArgs = struct {
        n: u32,
        input: cuda.bindings.CUdeviceptr,
        output: cuda.bindings.CUdeviceptr,
    };

    const module = cuda.Module.loadData(@embedFile("kernel_ptx")) catch |err| {
        std.log.err("loadData failed: {}\n", .{err});
        // Manually retry to get the raw CUresult for logging
        var m: cuda.bindings.CUmodule = null;
        const r = cuda.bindings.cuModuleLoadData(&m, @embedFile("kernel_ptx").ptr);
        cuda.logError(r);
        return err;
    };

    defer module.unload();
    const kernel = try module.getFunction(SoftmaxArgs, "kernel_$_softmax_f32_256");

    const elements: u32 = N * N;

    // ── Host buffers ─────────────────────────────────────────────────
    const host_input = try a.alloc(f32, elements);
    defer a.free(host_input);
    const host_output = try a.alloc(f32, elements);
    defer a.free(host_output);
    const cpu_output = try a.alloc(f32, elements);
    defer a.free(cpu_output);

    // Fill input with values that exercise numerical stability: range
    // [-10, 10] is small enough to stay distinguishable but large enough
    // that exp() without max-subtraction would overflow.
    var rng = std.Random.DefaultPrng.init(0xCAFEBABE);
    const rand = rng.random();
    for (host_input) |*v| {
        v.* = rand.float(f32) * 20.0 - 10.0;
    }

    // ── CPU reference ────────────────────────────────────────────────
    const cpu_start: std.Io.Clock.Timestamp = .now(io, .awake);
    cpuSoftmax(host_input, cpu_output, N);
    const cpu_us = cpu_start.untilNow(io).raw.toMicroseconds();
    const cpu_ms = @as(f32, @floatFromInt(cpu_us)) / 1000.0;

    // ── GPU ──────────────────────────────────────────────────────────
    const Buf = cuda.DeviceBuffer(f32);
    const dev_in = try Buf.alloc(elements);
    defer dev_in.free();
    const dev_out = try Buf.alloc(elements);
    defer dev_out.free();

    try dev_in.copyFromHost(host_input);

    const k_start = try cuda.Event.create();
    defer k_start.deinit();
    const k_end = try cuda.Event.create();
    defer k_end.deinit();

    // One block per row of the (N, N) matrix.
    try k_start.record(null);
    try kernel.launch(.{
        .grid = .{ .x = N },
        .block = .{ .x = BLOCK_SIZE },
    }, .{
        .n = N,
        .input = dev_in.ptr,
        .output = dev_out.ptr,
    });
    try k_end.record(null);
    try k_end.synchronize();
    const kernel_ms = try cuda.Event.elapsed(k_start, k_end);

    try dev_out.copyToHost(host_output);

    // ── Verify ───────────────────────────────────────────────────────
    var max_abs_err: f32 = 0;
    var max_rel_err: f32 = 0;
    var first_bad: ?usize = null;
    var sum_check_max_err: f32 = 0;

    for (host_output, cpu_output, 0..) |gpu, cpu, idx| {
        const abs_err = @abs(gpu - cpu);
        if (abs_err > max_abs_err) max_abs_err = abs_err;

        if (@abs(cpu) > 1e-6) {
            const rel = abs_err / @abs(cpu);
            if (rel > max_rel_err) max_rel_err = rel;
        }

        if (abs_err > 1e-5 and first_bad == null) first_bad = idx;
    }

    // Each output row should sum to ~1.0 (softmax invariant).
    var row: u32 = 0;
    while (row < N) : (row += 1) {
        var s: f32 = 0;
        var col: u32 = 0;
        while (col < N) : (col += 1) {
            s += host_output[row * N + col];
        }
        const err = @abs(s - 1.0);
        if (err > sum_check_max_err) sum_check_max_err = err;
    }

    // ── Performance ──────────────────────────────────────────────────
    // Softmax is memory-bound: each element read 3× and written 2× over
    // the three passes. Useful metric is effective GB/s.
    const bytes_moved: f64 = @as(f64, @floatFromInt(elements)) * @sizeOf(f32) * 5.0;
    const gpu_gbs = bytes_moved / (@as(f64, kernel_ms) * 1.0e6);

    std.debug.print("\nMatrix size: {d}x{d} ({d:.1} MB f32)\n", .{
        N, N, @as(f32, @floatFromInt(elements * @sizeOf(f32))) / (1024.0 * 1024.0),
    });
    std.debug.print("Block size:  {d} threads ({d} elements/thread)\n", .{
        BLOCK_SIZE, (N + BLOCK_SIZE - 1) / BLOCK_SIZE,
    });
    std.debug.print("\n", .{});
    std.debug.print("Correctness vs CPU reference:\n", .{});
    std.debug.print("  Max absolute error:   {e:.3}\n", .{max_abs_err});
    std.debug.print("  Max relative error:   {e:.3}\n", .{max_rel_err});
    std.debug.print("  Row-sum max deviation from 1.0: {e:.3}\n", .{sum_check_max_err});
    if (first_bad) |idx| {
        const r = idx / N;
        const c = idx % N;
        std.debug.print("  First large mismatch: row {d} col {d} — gpu={d}, cpu={d}\n", .{
            r, c, host_output[idx], cpu_output[idx],
        });
    } else {
        std.debug.print("  No mismatches above 1e-5 threshold.\n", .{});
    }
    std.debug.print("\n", .{});
    std.debug.print("CPU softmax:  {d:.3} ms\n", .{cpu_ms});
    std.debug.print("GPU softmax:  {d:.3} ms  ({d:.1}x vs CPU, {d:.1} GB/s effective)\n", .{
        kernel_ms, cpu_ms / kernel_ms, gpu_gbs,
    });
}

/// Numerically stable row-wise softmax, for verification.
fn cpuSoftmax(input: []const f32, output: []f32, n: u32) void {
    var row: u32 = 0;
    while (row < n) : (row += 1) {
        const base = row * n;

        // Pass 1: find max
        var row_max: f32 = -std.math.inf(f32);
        var col: u32 = 0;
        while (col < n) : (col += 1) {
            const v = input[base + col];
            if (v > row_max) row_max = v;
        }

        // Pass 2: compute exp(x - max) and sum
        var row_sum: f32 = 0;
        col = 0;
        while (col < n) : (col += 1) {
            const e = @exp(input[base + col] - row_max);
            output[base + col] = e;
            row_sum += e;
        }

        // Pass 3: divide by sum
        const inv_sum: f32 = 1.0 / row_sum;
        col = 0;
        while (col < n) : (col += 1) {
            output[base + col] *= inv_sum;
        }
    }
}
