//! Vector add timed both ways: the kernel alone with `cuda.Bench` (a warm-up,
//! then the median of repeated launches timed with CUDA events), and the
//! same work on the CPU with the host clock.

const std = @import("std");
const cuda = @import("cuda");

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    const io = init.io;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    const VectorAddArgs = struct {
        n: u32,
        x: cuda.bindings.CUdeviceptr,
        y: cuda.bindings.CUdeviceptr,
        out: cuda.bindings.CUdeviceptr,
    };

    const module = try cuda.Module.loadPtx(@embedFile("kernel_ptx"));
    defer module.unload();
    const kernel = try module.getFunction(VectorAddArgs, "vector_add");

    const N: u32 = 1 << 20;
    const host_x = try allocator.alloc(f32, N);
    defer allocator.free(host_x);
    const host_y = try allocator.alloc(f32, N);
    defer allocator.free(host_y);
    const host_out = try allocator.alloc(f32, N);
    defer allocator.free(host_out);
    const cpu_out = try allocator.alloc(f32, N);
    defer allocator.free(cpu_out);

    for (host_x, host_y, 0..) |*x, *y, i| {
        x.* = @floatFromInt(i % 100);
        y.* = 2.0;
    }

    const cpu_start: std.Io.Clock.Timestamp = .now(io, .awake);
    for (host_x, host_y, cpu_out) |x, y, *o| {
        o.* = x + y;
    }
    const cpu_us = cpu_start.untilNow(io).raw.toMicroseconds();
    const cpu_ms = @as(f32, @floatFromInt(cpu_us)) / 1000.0;

    const Buf = cuda.DeviceBuffer(f32);
    const dx = try Buf.alloc(N);
    defer dx.free();
    const dy = try Buf.alloc(N);
    defer dy.free();
    const dout = try Buf.alloc(N);
    defer dout.free();

    const block: c_uint = 256;
    const grid: c_uint = (N + block - 1) / block;
    const runtime_n = N;

    try dx.copyFromHost(host_x);
    try dy.copyFromHost(host_y);

    var bench = try cuda.Bench.init(io, .{});
    defer bench.deinit();
    while (try bench.next()) {
        try kernel.launch(.{
            .grid = .{ .x = grid },
            .block = .{ .x = block },
        }, .{
            .n = runtime_n,
            .x = dx.ptr,
            .y = dy.ptr,
            .out = dout.ptr,
        });
    }
    const timing = bench.total();

    try dout.copyToHost(host_out);

    // ── Verify ───────────────────────────────────────────────────────
    var max_err: f32 = 0;
    for (cpu_out, host_out) |cpu, gpu| {
        if (!std.math.isFinite(gpu))
            return error.VerificationFailed;

        const e = @abs(cpu - gpu);
        if (e > max_err) max_err = e;
    }

    const speedup = cpu_ms / timing.median_ms;
    std.debug.print("\nN = {d}\n", .{N});
    std.debug.print("CPU: {d:.3} ms\n", .{cpu_ms});
    std.debug.print("GPU: {d:.3} ms ({d:.1}x speedup, kernel only)\n", .{ timing.median_ms, speedup });
    std.debug.print("GPU timing: median of {d} runs after a {d} ms warm-up (min {d:.3}, max {d:.3} ms)\n", .{ timing.runs, bench.opts.warmup_ms, timing.min_ms, timing.max_ms });
    std.debug.print("Max error: {d}\n", .{max_err});
    if (max_err > 1e-5) return error.VerificationFailed;
}
