//! Small GPU correctness cases, separate from the large all-ones benchmarks.
const std = @import("std");
const cuda = @import("cuda");
const verification = @import("verification.zig");

pub fn run(comptime T: type, kernel: anytype, tile_m: u32, tile_n: u32, block: cuda.Dim3) !void {
    // Aligned, smaller than a tile, and rectangular with odd strides and tails.
    for ([_][3]u32{ .{ 1, 1, 1 }, .{ 32, 32, 32 }, .{ 19, 23, 17 }, .{ 65, 67, 33 } }) |shape| {
        const m, const n, const k = shape;
        var a: [65 * 33]T = undefined;
        var b: [33 * 67]T = undefined;
        var c: [65 * 67]T = undefined;
        const host_a = a[0 .. m * k];
        const host_b = b[0 .. k * n];
        const host_c = c[0 .. m * n];
        var rng = std.Random.DefaultPrng.init(0xc0da);
        const random = rng.random();
        for (host_a) |*x| x.* = @floatCast(random.float(f32) * 2 - 1);
        for (host_b) |*x| x.* = @floatCast(random.float(f32) * 2 - 1);
        // A missing GPU write must fail verification, even if memory is reused.
        @memset(host_c, std.math.nan(T));
        const Buf = cuda.DeviceBuffer(T);
        const da = try Buf.alloc(host_a.len);
        defer da.free();
        const db = try Buf.alloc(host_b.len);
        defer db.free();
        const dc = try Buf.alloc(host_c.len);
        defer dc.free();
        try da.copyFromHost(host_a);
        try db.copyFromHost(host_b);
        try dc.copyFromHost(host_c);
        try kernel.launch(.{
            .grid = .{ .x = (n + tile_n - 1) / tile_n, .y = (m + tile_m - 1) / tile_m },
            .block = block,
        }, .{ .M = m, .N = n, .K = k, .A = da.ptr, .B = db.ptr, .C = dc.ptr });
        // This synchronous download waits for the default-stream launch.
        try dc.copyToHost(host_c);
        for (0..m) |row| for (0..n) |col| {
            var expected: f64 = 0;
            for (0..k) |inner| {
                expected += @as(f64, host_a[row * k + inner]) * @as(f64, host_b[inner * n + col]);
            }
            // Account for output rounding to f16, when applicable.
            const tolerance: f64 = if (T == f16) 2e-3 else 1e-5;
            verification.check(@floatCast(host_c[row * n + col]), expected, tolerance, tolerance) catch |err| {
                std.debug.print("Matmul verification failed: {d}x{d}x{d}, row {d}, col {d}: got {d}, expected {d}\n", .{
                    m, n, k, row, col, host_c[row * n + col], expected,
                });
                return err;
            };
        };
    }
    std.debug.print("Random rectangular {s} matmul checks passed (4 shapes)\n", .{@typeName(T)});
}
