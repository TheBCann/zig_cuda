const std = @import("std");
const cuda = @import("cuda");

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;

    try cuda.init();

    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    const ptx_data = @embedFile("kernel_ptx");
    const module = try cuda.Module.loadData(ptx_data);
    defer module.unload();

    // Host-side argument layout for the vector_add kernel.
    // Each field corresponds to one kernel parameter in declaration order.
    const VectorAddArgs = struct {
        n: u32,
        x: cuda.bindings.CUdeviceptr,
        y: cuda.bindings.CUdeviceptr,
        out: cuda.bindings.CUdeviceptr,
    };

    const kernel = try module.getFunction(VectorAddArgs, "kernel_$_vector_add");

    const N: u32 = 1 << 20;
    const host_x = try a.alloc(f32, N);
    defer a.free(host_x);
    const host_y = try a.alloc(f32, N);
    defer a.free(host_y);
    const host_out = try a.alloc(f32, N);
    defer a.free(host_out);

    for (host_x, host_y, 0..) |*x, *y, i| {
        x.* = @floatFromInt(i % 100);
        y.* = 2.0;
    }

    const Buf = cuda.DeviceBuffer(f32);
    const dx = try Buf.alloc(N);
    defer dx.free();
    const dy = try Buf.alloc(N);
    defer dy.free();
    const dout = try Buf.alloc(N);
    defer dout.free();

    try dx.copyFromHost(host_x);
    try dy.copyFromHost(host_y);

    const block: c_uint = 256;
    const grid: c_uint = (N + block - 1) / block;

    try kernel.launch(.{
        .grid = .{ .x = grid },
        .block = .{ .x = block },
    }, .{
        .n = N,
        .x = dx.ptr,
        .y = dy.ptr,
        .out = dout.ptr,
    });

    try ctx.synchronize();

    try dout.copyToHost(host_out);

    var max_err: f32 = 0;
    for (host_x, host_y, host_out) |x, y, o| {
        const e = @abs(o - (x + y));
        if (e > max_err) max_err = e;
    }
    std.debug.print("N={d}  max error = {d}\n", .{ N, max_err });
}
