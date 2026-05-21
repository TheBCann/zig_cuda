//! Attention scores kernel test: scores = (Q @ K^T) / sqrt(d)
//!
//! Verifies against a CPU reference, then benchmarks. First of three
//! kernels in the unfused attention forward pass (scores → softmax → output).

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

    const ScoresArgs = struct {
        n: u32,
        d: u32,
        inv_sqrt_d: f32,
        q: cuda.bindings.CUdeviceptr,
        k: cuda.bindings.CUdeviceptr,
        scores: cuda.bindings.CUdeviceptr,
    };

    const module = try cuda.Module.loadData(@embedFile("kernel_ptx"));
    defer module.unload();
    const kernel = try module.getFunction(ScoresArgs, "kernel_$_scores_f32_16");

    const qk_elements: u32 = N * D;
    const scores_elements: u32 = N * N;

    // ── Host buffers ─────────────────────────────────────────────────
    const host_q = try a.alloc(f32, qk_elements);
    defer a.free(host_q);
    const host_k = try a.alloc(f32, qk_elements);
    defer a.free(host_k);
    const host_scores = try a.alloc(f32, scores_elements);
    defer a.free(host_scores);
    const cpu_scores = try a.alloc(f32, scores_elements);
    defer a.free(cpu_scores);

    // Fill Q and K with uniform random in [-0.5, 0.5]. With d=64, raw
    // dot products have std ~2.3; after /sqrt(64) scores have std ~0.29.
    // Realistic magnitude range for verification.
    var rng = std.Random.DefaultPrng.init(0xC0FFEE42);
    const rand = rng.random();
    for (host_q) |*v| v.* = rand.float(f32) - 0.5;
    for (host_k) |*v| v.* = rand.float(f32) - 0.5;

    const inv_sqrt_d: f32 = 1.0 / std.math.sqrt(@as(f32, @floatFromInt(D)));

    // ── CPU reference ────────────────────────────────────────────────
    const cpu_start: std.Io.Clock.Timestamp = .now(io, .awake);
    cpuScores(host_q, host_k, cpu_scores, N, D, inv_sqrt_d);
    const cpu_us = cpu_start.untilNow(io).raw.toMicroseconds();
    const cpu_ms = @as(f32, @floatFromInt(cpu_us)) / 1000.0;

    // ── GPU ──────────────────────────────────────────────────────────
    const Buf = cuda.DeviceBuffer(f32);
    const dev_q = try Buf.alloc(qk_elements);
    defer dev_q.free();
    const dev_k = try Buf.alloc(qk_elements);
    defer dev_k.free();
    const dev_scores = try Buf.alloc(scores_elements);
    defer dev_scores.free();

    try dev_q.copyFromHost(host_q);
    try dev_k.copyFromHost(host_k);

    const k_start = try cuda.Event.create();
    defer k_start.deinit();
    const k_end = try cuda.Event.create();
    defer k_end.deinit();

    const grid_dim: c_uint = N / TILE;

    try k_start.record(null);
    try kernel.launch(.{
        .grid = .{ .x = grid_dim, .y = grid_dim },
        .block = .{ .x = TILE, .y = TILE },
    }, .{
        .n = N,
        .d = D,
        .inv_sqrt_d = inv_sqrt_d,
        .q = dev_q.ptr,
        .k = dev_k.ptr,
        .scores = dev_scores.ptr,
    });
    try k_end.record(null);
    try k_end.synchronize();
    const kernel_ms = try cuda.Event.elapsed(k_start, k_end);

    try dev_scores.copyToHost(host_scores);

    // ── Verify ───────────────────────────────────────────────────────
    var max_abs_err: f32 = 0;
    var max_rel_err: f32 = 0;
    var first_bad: ?usize = null;

    for (host_scores, cpu_scores, 0..) |gpu, cpu, idx| {
        const abs_err = @abs(gpu - cpu);
        if (abs_err > max_abs_err) max_abs_err = abs_err;

        if (@abs(cpu) > 1e-4) {
            const rel = abs_err / @abs(cpu);
            if (rel > max_rel_err) max_rel_err = rel;
        }

        if (abs_err > 1e-3 and first_bad == null) first_bad = idx;
    }

    // ── Performance ──────────────────────────────────────────────────
    // FLOPs ≈ 2 * N * N * D (one multiply + one add per inner-loop step)
    const flops: f64 = @as(f64, @floatFromInt(N)) *
        @as(f64, @floatFromInt(N)) *
        @as(f64, @floatFromInt(2 * D));
    const gpu_gflops = flops / (@as(f64, kernel_ms) * 1.0e6);

    std.debug.print("\n", .{});
    std.debug.print("Q: {d}x{d}, K: {d}x{d}, scores: {d}x{d}\n", .{ N, D, N, D, N, N });
    std.debug.print("Grid: {d}x{d}, Block: {d}x{d} ({d} threads/block)\n", .{
        grid_dim, grid_dim, TILE, TILE, TILE * TILE,
    });
    std.debug.print("inv_sqrt_d: {d:.6}\n", .{inv_sqrt_d});
    std.debug.print("\n", .{});
    std.debug.print("Correctness vs CPU reference:\n", .{});
    std.debug.print("  Max absolute error: {e:.3}\n", .{max_abs_err});
    std.debug.print("  Max relative error: {e:.3}\n", .{max_rel_err});
    if (first_bad) |idx| {
        const r = idx / N;
        const c = idx % N;
        std.debug.print("  First large mismatch: row {d} col {d} — gpu={d}, cpu={d}\n", .{
            r, c, host_scores[idx], cpu_scores[idx],
        });
    } else {
        std.debug.print("  No mismatches above 1e-3 threshold.\n", .{});
    }

    // Sanity print: show the corner 3x3 of the scores matrix.
    std.debug.print("\nSample scores[0..3, 0..3]:\n", .{});
    var r: u32 = 0;
    while (r < 3) : (r += 1) {
        var c: u32 = 0;
        while (c < 3) : (c += 1) {
            std.debug.print("  {d:>9.5}", .{host_scores[r * N + c]});
        }
        std.debug.print("\n", .{});
    }

    std.debug.print("\n", .{});
    std.debug.print("CPU scores:  {d:.3} ms\n", .{cpu_ms});
    std.debug.print("GPU scores:  {d:.3} ms  ({d:.1}x vs CPU, {d:.1} GFLOPS)\n", .{
        kernel_ms, cpu_ms / kernel_ms, gpu_gflops,
    });
}

/// CPU reference: scores[i][j] = (Q[i] · K[j]) / sqrt(d)
fn cpuScores(
    q: []const f32,
    k: []const f32,
    scores: []f32,
    n: u32,
    d: u32,
    inv_sqrt_d: f32,
) void {
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
}
