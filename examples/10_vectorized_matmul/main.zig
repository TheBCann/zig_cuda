//! Tiled matmul example.
//!
//! Multiplies two N×N matrices of all-ones. Expected output: every
//! cell of C equals K (= N for square). Easy correctness check, and
//! the structure exercises every part of the kernel: 2D indexing,
//! shared memory, barriers, the K-dimension tile loop.
//!
//! This is the example where GPU compute decisively wins, even with
//! PCIe transfers included. Vector_add was 0.083 FLOPs/byte; tiled
//! matmul is ~16 FLOPs/byte (per tile load, a thread does TILE
//! multiply-adds). High enough arithmetic intensity that PCIe stops
//! being the bottleneck.

const std = @import("std");
const cuda = @import("cuda");

const TILE: u32 = 16;
const N: u32 = 1024; // M = K = N for this example

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;
    const io = init.io;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    // matmul: 05, 09
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
    const kernel = try module.getFunction(MatmulArgs, "kernel_$_matmul_vec");

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

    const grid_dim: u32 = N / TILE; // 64 for N=1024
    const M: u32 = N;
    const K: u32 = N;
    const N_arg: u32 = N;

    try k_start.record(null);

    try kernel.launch(.{
        .grid = .{ .x = N / 16, .y = M / 16 },
        .block = .{ .x = 16, .y = 16 },
    }, .{ 
        .M = M,
        .N = N,
        .K = K,
        .A = dev_a.ptr,
        .B = dev_b.ptr,
        .C = dev_c.ptr
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
        .grid = .{ .x = grid_dim, .y = grid_dim },
        .block = .{ .x = TILE, .y = TILE },
    }, .{ 
        .M = M,
        .N = N_arg,
        .K = K,
        .A = dev_a.ptr,
        .B = dev_b.ptr,
        .C = dev_c.ptr
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

    std.debug.print("\nMatrix size: {d}x{d}, tile size: {d}\n", .{ N, N, TILE });
    std.debug.print("Expected cell value: {d:.0}\n", .{expected});
    std.debug.print("Max error: {d}\n", .{max_err});
    if (first_bad) |idx| {
        std.debug.print("First mismatch at index {d}: got {d}\n", .{ idx, host_c[idx] });
    }
    std.debug.print("\n", .{});
    std.debug.print("CPU naive triple loop: {d:.1} ms  ({d:.2} GFLOPS)\n", .{ cpu_ms, cpu_gflops });
    std.debug.print("GPU kernel only:       {d:.3} ms  ({d:.2} GFLOPS, {d:.0}x vs CPU)\n", .{ kernel_only_ms, gpu_gflops, cpu_ms / kernel_only_ms });
    std.debug.print("GPU end-to-end:        {d:.3} ms  ({d:.0}x vs CPU)\n", .{ end_to_end_ms, cpu_ms / end_to_end_ms });
}
