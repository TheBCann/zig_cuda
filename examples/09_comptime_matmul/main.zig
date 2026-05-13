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

    // ── Grab all three specialized entry points ──────────────────────
    const k_8x8   = try module.getFunction("kernel_$_matmul_f32_8x8");
    const k_16x16 = try module.getFunction("kernel_$_matmul_f32_16x16");
    const k_32x32 = try module.getFunction("kernel_$_matmul_f32_32x32");

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
        func: cuda.Function,
        tile: u32, // square: tile_m == tile_n == tile_k
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
        }, .{ M, N, K, dev_a.ptr, dev_b.ptr, dev_c.ptr });
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
}
