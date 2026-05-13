//! Comptime-parameterized tiled matmul host code.
//!
//! Loads three distinct PTX entry points generated from one Zig source
//! by comptime specialization. Launches each with the appropriate block
//! and grid dimensions, verifies correctness, reports performance.

const std = @import("std");
const cuda = @import("cuda");

const MATRIX_SIZE: u32 = 1024; // M = K = N = 1024

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    const module = try cuda.Module.loadData(@embedFile("kernel_ptx"));
    defer module.unload();

    const MatmulArgs = struct {
        M: u32,
        N: u32,
        K: u32,
        A: cuda.bindings.CUdeviceptr,
        B: cuda.bindings.CUdeviceptr,
        C: cuda.bindings.CUdeviceptr,
    };

    // ── Grab all four specialized entry points ──────────────────────
    const k_8x8   = try module.getFunction(MatmulArgs, "kernel_$_matmul_f32_8x8");
    const k_16x16 = try module.getFunction(MatmulArgs, "kernel_$_matmul_f32_16x16");
    const k_32x32 = try module.getFunction(MatmulArgs, "kernel_$_matmul_f32_32x32");
    const k_f16   = try module.getFunction(MatmulArgs, "kernel_$_matmul_f16_16x16");

    const elements = MATRIX_SIZE * MATRIX_SIZE;

    // ── Host buffers ─────────────────────────────────────────────────
    const host_a = try a.alloc(f32, elements);
    defer a.free(host_a);
    const host_b = try a.alloc(f32, elements);
    defer a.free(host_b);
    const host_c = try a.alloc(f32, elements);
    defer a.free(host_c);

    @memset(host_a, 1.0);
    @memset(host_b, 1.0);

    // ── Device buffers ───────────────────────────────────────────────
    const Buf = cuda.DeviceBuffer(f32);
    const dev_a = try Buf.alloc(elements);
    defer dev_a.free();
    const dev_b = try Buf.alloc(elements);
    defer dev_b.free();
    const dev_c = try Buf.alloc(elements);
    defer dev_c.free();

    try dev_a.copyFromHost(host_a);
    try dev_b.copyFromHost(host_b);

    const k_start = try cuda.Event.create();
    defer k_start.deinit();
    const k_end = try cuda.Event.create();
    defer k_end.deinit();

    // ── Benchmarking configurations ──────────────────────────────────
    const KernelConfig = struct {
        name: []const u8,
        func: cuda.Function(MatmulArgs),
        tile: u32,
    };

    const configs = [_]KernelConfig{
        .{ .name = "8x8x8",    .func = k_8x8,   .tile = 8 },
        .{ .name = "16x16x16", .func = k_16x16, .tile = 16 },
        .{ .name = "32x32x32", .func = k_32x32, .tile = 32 },
    };

    const M = MATRIX_SIZE;
    const N = MATRIX_SIZE;
    const K = MATRIX_SIZE;
    const expected: f32 = @floatFromInt(K);

    std.debug.print("\nMatrix size: {d}x{d}\n", .{ M, N });
    std.debug.print("Expected cell value: {d:.0}\n\n", .{expected});

    for (configs) |cfg| {
        // Zero out C between runs so we don't read previous results.
        @memset(host_c, 0.0);
        try dev_c.copyFromHost(host_c);

        const grid_dim: u32 = (N + cfg.tile - 1) / cfg.tile;

        try k_start.record(null);
        try cfg.func.launch(.{
            .grid = .{ .x = grid_dim, .y = grid_dim },
            .block = .{ .x = cfg.tile, .y = cfg.tile },
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
        const ms = try cuda.Event.elapsed(k_start, k_end);

        try dev_c.copyToHost(host_c);

        var max_err: f32 = 0;
        for (host_c) |c| {
            const e = @abs(c - expected);
            if (e > max_err) max_err = e;
        }

        const flops: f64 = 2.0 * @as(f64, M) * @as(f64, N) * @as(f64, K);
        const gflops = flops / (@as(f64, ms) * 1.0e6);

        std.debug.print("[{s}]\n", .{cfg.name});
        std.debug.print("  Grid: {d}x{d}, Block: {d}x{d}\n", .{ grid_dim, grid_dim, cfg.tile, cfg.tile });
        std.debug.print("  Error:  {d}\n", .{max_err});
        std.debug.print("  Time:   {d:.3} ms\n", .{ms});
        std.debug.print("  Speed:  {d:.2} GFLOPS\n\n", .{gflops});
    }

    // ── Bonus: f16 16x16 (mixed precision, f32 accumulator) ───────────
    // Same algorithm; comptime selects the f16 LLVM lowering. The 1660 Ti
    // has FP16 ALU paths but no tensor cores, so expect ~similar (not 2x)
    // throughput to f32. The win is in halved memory footprint and bandwidth.

    const host_a_f16 = try a.alloc(f16, elements);
    defer a.free(host_a_f16);
    const host_b_f16 = try a.alloc(f16, elements);
    defer a.free(host_b_f16);
    const host_c_f16 = try a.alloc(f16, elements);
    defer a.free(host_c_f16);

    @memset(host_a_f16, 1.0);
    @memset(host_b_f16, 1.0);
    @memset(host_c_f16, 0.0);

    const FBuf = cuda.DeviceBuffer(f16);
    const dev_a_f16 = try FBuf.alloc(elements);
    defer dev_a_f16.free();
    const dev_b_f16 = try FBuf.alloc(elements);
    defer dev_b_f16.free();
    const dev_c_f16 = try FBuf.alloc(elements);
    defer dev_c_f16.free();

    try dev_a_f16.copyFromHost(host_a_f16);
    try dev_b_f16.copyFromHost(host_b_f16);
    try dev_c_f16.copyFromHost(host_c_f16);

    const f16_tile: u32 = 16;
    const f16_grid: u32 = (N + f16_tile - 1) / f16_tile;

    try k_start.record(null);
    try k_f16.launch(.{
        .grid = .{ .x = f16_grid, .y = f16_grid },
        .block = .{ .x = f16_tile, .y = f16_tile },
    }, .{ 
        .M = M,
        .N = N,
        .K = K,
        .A = dev_a_f16.ptr,
        .B = dev_b_f16.ptr,
        .C = dev_c_f16.ptr
    });
    try k_end.record(null);
    try k_end.synchronize();
    const f16_ms = try cuda.Event.elapsed(k_start, k_end);

    try dev_c_f16.copyToHost(host_c_f16);

    const expected_f16: f16 = @floatCast(expected);
    var f16_max_err: f32 = 0;
    for (host_c_f16) |c| {
        const e: f32 = @abs(@as(f32, c) - @as(f32, expected_f16));
        if (e > f16_max_err) f16_max_err = e;
    }

    const f16_flops: f64 = 2.0 * @as(f64, M) * @as(f64, N) * @as(f64, K);
    const f16_gflops = f16_flops / (@as(f64, f16_ms) * 1.0e6);

    std.debug.print("[f16 16x16x16 (acc=f32)]\n", .{});
    std.debug.print("  Grid: {d}x{d}, Block: {d}x{d}\n", .{ f16_grid, f16_grid, f16_tile, f16_tile });
    std.debug.print("  Error:  {d}\n", .{f16_max_err});
    std.debug.print("  Time:   {d:.3} ms\n", .{f16_ms});
    std.debug.print("  Speed:  {d:.2} GFLOPS\n\n", .{f16_gflops});
}
