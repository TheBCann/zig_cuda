//! Reduction example: sum N floats on the GPU.
//!
//! Each block reduces 256 elements to one partial sum via shared memory
//! tree reduction. The host then sums the (much smaller) partials array
//! on the CPU. Input is all 1.0s so the expected total is exactly N.

const std = @import("std");
const cuda = @import("cuda");

const BLOCK_SIZE: u32 = 256;

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;
    const io = init.io;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    // block_sum: 04, 06, 07
    const BlockSumArgs = struct {
        n: u32,
        input: cuda.bindings.CUdeviceptr,
        partials: cuda.bindings.CUdeviceptr,
    };

    const module = try cuda.Module.loadData(@embedFile("kernel_ptx"));
    defer module.unload();
    const kernel = try module.getFunction(BlockSumArgs, "kernel_$_block_sum");

    // ── Input: N ones. Sum should be exactly N. ──────────────────────
    const N: u32 = 1 << 20; // 1M elements
    const num_blocks: u32 = (N + 2 * BLOCK_SIZE - 1) / (2 * BLOCK_SIZE);

    const host_input = try a.alloc(f32, N);
    defer a.free(host_input);
    @memset(host_input, 1.0);

    const host_partials = try a.alloc(f32, num_blocks);
    defer a.free(host_partials);

    // ── CPU reference ────────────────────────────────────────────────
    const cpu_start: std.Io.Clock.Timestamp = .now(io, .awake);
    var cpu_sum: f64 = 0;
    for (host_input) |x| cpu_sum += x;
    const cpu_us = cpu_start.untilNow(io).raw.toMicroseconds();
    const cpu_ms = @as(f32, @floatFromInt(cpu_us)) / 1000.0;

    // ── GPU ──────────────────────────────────────────────────────────
    const Buf = cuda.DeviceBuffer(f32);
    const dev_input = try Buf.alloc(N);
    defer dev_input.free();
    const dev_partials = try Buf.alloc(num_blocks);
    defer dev_partials.free();

    try dev_input.copyFromHost(host_input);

    const start = try cuda.Event.create();
    defer start.deinit();
    const end = try cuda.Event.create();
    defer end.deinit();

    const runtime_n = N;
    try start.record(null);

    try kernel.launch(.{
        .grid = .{ .x = num_blocks },
        .block = .{ .x = BLOCK_SIZE },
    }, .{
        .n = runtime_n,
        .input = dev_input.ptr,
        .partials = dev_partials.ptr
    });

    try end.record(null);
    try end.synchronize();
    const kernel_ms = try cuda.Event.elapsed(start, end);

    try dev_partials.copyToHost(host_partials);

    // ── Final reduction on the CPU ───────────────────────────────────
    var gpu_sum: f64 = 0;
    for (host_partials) |p| gpu_sum += p;

    // ── Verify ───────────────────────────────────────────────────────
    const expected: f64 = @floatFromInt(N);
    const cpu_err = @abs(cpu_sum - expected);
    const gpu_err = @abs(gpu_sum - expected);

    std.debug.print("\n[v2: halve threads, double loads] N = {d} \n(all ones, expected sum = {d:.0})\n", .{ N, expected });
    std.debug.print("CPU sum: {d:.0}  (error: {d})\n", .{ cpu_sum, cpu_err });
    std.debug.print("GPU sum: {d:.0}  (error: {d})\n", .{ gpu_sum, gpu_err });
    std.debug.print("\n", .{});
    std.debug.print("CPU time:    {d:.3} ms\n", .{cpu_ms});
    std.debug.print("GPU kernel:  {d:.3} ms ({d:.1}x vs CPU)\n", .{ kernel_ms, cpu_ms / kernel_ms });
    std.debug.print("Blocks:      {d} (each covering {d} elements)\n", .{ num_blocks, 2 * BLOCK_SIZE });
}
