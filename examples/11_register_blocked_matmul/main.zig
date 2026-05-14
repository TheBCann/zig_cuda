//! Register-blocked matmul example.
//!
//! Each thread computes a 4×4 tile of C in registers, accumulating across
//! all K-tiles before writing back. The block tile is 64×64; the K-direction
//! tile is 16. Threads per block: 16×16 = 256.
//!
//! Compared to example 05's 1-element-per-thread design, this version does
//! 16 FMAs per inner-loop iteration instead of 1, dramatically improving the
//! compute-to-shared-memory-load ratio (0.5 loads/FMA vs 2.0).
//!
//! Expected outcome on the 1660 Ti: 800-1100 GFLOPS, up from ~550 in the
//! simple tiled version.

const std = @import("std");
const cuda = @import("cuda");

// Block tile of C produced by one block: BM×BN.
const BM: u32 = 64;
const BN: u32 = 64;
// Per-thread output tile (held in registers).
const TM: u32 = 4;
const TN: u32 = 4;
// Threads per block: (BM/TM) × (BN/TN) = 16 × 16 = 256.
const THREADS_X: u32 = BN / TN;
const THREADS_Y: u32 = BM / TM;

const N: u32 = 1024; // M = K = N for this example.

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;
    const io = init.io;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    // Shared matmul args struct (M, N, K, A, B, C) — same shape used by
    // examples 05, 09, 10, 11.
    const MatmulArgs = struct {
        M: u32,
        N: u32,
        K: u32,
        A: cuda.bindings.CUdeviceptr,
        B: cuda.bindings.CUdeviceptr,
        C: cuda.bindings.CUdeviceptr,
    };

    const module = try cuda.Module.loadData(@embedFile("kernel_ptx"));
    defer module.unload();
    const kernel = try module.getFunction(MatmulArgs, "kernel_$_matmul_reg");

    const elements: u32 = N * N;

    // Host buffers.
    const host_a = try a.alloc(f32, elements);
    defer a.free(host_a);
    const host_b = try a.alloc(f32, elements);
    defer a.free(host_b);
    const host_c = try a.alloc(f32, elements);
    defer a.free(host_c);

    @memset(host_a, 1.0);
    @memset(host_b, 1.0);
    @memset(host_c, 0.0);

    // ── CPU baseline: naive triple-loop matmul ───────────────────────
    // O(N³) = 2^30 multiply-adds at N=1024. Slow but honest.
    const cpu_c = try a.alloc(f32, elements);
    defer a.free(cpu_c);
    @memset(cpu_c, 0.0);

    const cpu_start: std.Io.Clock.Timestamp = .now(io, .awake);
    var i: u32 = 0;
    while (i < N) : (i += 1) {
        var j: u32 = 0;
        while (j < N) : (j += 1) {
            var sum: f32 = 0;
            var k: u32 = 0;
            while (k < N) : (k += 1) {
                sum += host_a[i * N + k] * host_b[k * N + j];
            }
            cpu_c[i * N + j] = sum;
        }
    }
    const cpu_us = cpu_start.untilNow(io).raw.toMicroseconds();
    const cpu_ms = @as(f32, @floatFromInt(cpu_us)) / 1000.0;

    // ── GPU ──────────────────────────────────────────────────────────
    const Buf = cuda.DeviceBuffer(f32);
    const dev_a = try Buf.alloc(elements);
    defer dev_a.free();
    const dev_b = try Buf.alloc(elements);
    defer dev_b.free();
    const dev_c = try Buf.alloc(elements);
    defer dev_c.free();

    // Kernel-only timing: data already on GPU.
    try dev_a.copyFromHost(host_a);
    try dev_b.copyFromHost(host_b);

    const k_start = try cuda.Event.create();
    defer k_start.deinit();
    const k_end = try cuda.Event.create();
    defer k_end.deinit();

    const M: u32 = N;
    const K: u32 = N;
    const N_arg: u32 = N;

    // Grid: each block produces a 64×64 output tile, so grid is N/64 × N/64.
    // For N=1024: 16×16 = 256 blocks (vs example 05's 64×64 = 4096 blocks).
    // Same total output, but each block now does 16× more work.
    const grid_x: u32 = (N_arg + BN - 1) / BN;
    const grid_y: u32 = (M + BM - 1) / BM;

    try k_start.record(null);

    try kernel.launch(.{
        .grid = .{ .x = grid_x, .y = grid_y },
        .block = .{ .x = THREADS_X, .y = THREADS_Y },
    }, .{
        .M = M,
        .N = N_arg,
        .K = K,
        .A = dev_a.ptr,
        .B = dev_b.ptr,
        .C = dev_c.ptr,
    });

    try k_end.record(null);
    try k_end.synchronize();
    const kernel_only_ms = try cuda.Event.elapsed(k_start, k_end);

    try dev_c.copyToHost(host_c);

    // ── End-to-end timing: copy in + kernel + copy out ───────────────
    const e_start = try cuda.Event.create();
    defer e_start.deinit();
    const e_end = try cuda.Event.create();
    defer e_end.deinit();

    try e_start.record(null);
    try dev_a.copyFromHost(host_a);
    try dev_b.copyFromHost(host_b);

    try kernel.launch(.{
        .grid = .{ .x = grid_x, .y = grid_y },
        .block = .{ .x = THREADS_X, .y = THREADS_Y },
    }, .{
        .M = M,
        .N = N_arg,
        .K = K,
        .A = dev_a.ptr,
        .B = dev_b.ptr,
        .C = dev_c.ptr,
    });

    try dev_c.copyToHost(host_c);
    try e_end.record(null);
    try e_end.synchronize();
    const end_to_end_ms = try cuda.Event.elapsed(e_start, e_end);

    // ── Verify ───────────────────────────────────────────────────────
    // For all-ones matrices, every cell of C should equal K = N = 1024.
    const expected: f32 = @floatFromInt(N);
    var max_err: f32 = 0;
    var first_bad: ?usize = null;
    for (host_c, 0..) |c, idx| {
        const e = @abs(c - expected);
        if (e > max_err) max_err = e;
        if (e > 0.001 and first_bad == null) first_bad = idx;
    }

    // ── Performance ──────────────────────────────────────────────────
    const flops: f64 = 2.0 * @as(f64, N) * @as(f64, N) * @as(f64, N); // 2N³ multiply-adds
    const gpu_gflops = flops / (@as(f64, kernel_only_ms) * 1.0e6);
    const cpu_gflops = flops / (@as(f64, cpu_ms) * 1.0e6);

    std.debug.print("\nMatrix size: {d}x{d}\n", .{ N, N });
    std.debug.print("Block tile: {d}x{d}, thread tile: {d}x{d}\n", .{ BM, BN, TM, TN });
    std.debug.print("Grid: {d}x{d}, block: {d}x{d} = {d} threads/block\n", .{
        grid_x, grid_y, THREADS_X, THREADS_Y, THREADS_X * THREADS_Y,
    });
    std.debug.print("Expected cell value: {d:.0}\n", .{expected});
    std.debug.print("Max error: {d}\n", .{max_err});
    if (first_bad) |idx| {
        std.debug.print("First mismatch at index {d}: got {d}\n", .{ idx, host_c[idx] });
    }
    std.debug.print("\n", .{});
    std.debug.print("CPU naive triple loop: {d:.1} ms  ({d:.2} GFLOPS)\n", .{ cpu_ms, cpu_gflops });
    std.debug.print("GPU kernel only:       {d:.3} ms  ({d:.2} GFLOPS, {d:.0}x vs CPU)\n", .{
        kernel_only_ms, gpu_gflops, cpu_ms / kernel_only_ms,
    });
    std.debug.print("GPU end-to-end:        {d:.3} ms  ({d:.0}x vs CPU)\n", .{
        end_to_end_ms, cpu_ms / end_to_end_ms,
    });
}
