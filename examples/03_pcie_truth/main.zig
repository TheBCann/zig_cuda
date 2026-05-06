//! Demonstrates why GPU benchmarks need to be honest about transfers.
//!
//! Vector_add is the most arithmetically-trivial workload imaginable:
//! one FLOP (an add) per 12 bytes of memory traffic. That's an arithmetic
//! intensity of 0.083 FLOPs/byte. The GPU's GDDR6 memory is ~7x faster
//! than your DDR4 (288 GB/s vs ~40 GB/s), so the *kernel itself* finishes
//! in a fraction of the CPU's time. But to *get the data to GDDR6* you
//! have to cross PCIe Gen3 x16, which is ~3.5x slower than DDR4 (12 GB/s
//! vs 40 GB/s). For a single op, the PCIe penalty wipes out the bandwidth
//! advantage entirely.
//!
//! This example prints both numbers so the contrast is unavoidable.
//! Real workloads (matrix multiply, convolutions, attention) win because
//! their arithmetic intensity is 1000x higher — each byte of input gets
//! used in many FLOPs, so the kernel does enough work to amortize the
//! PCIe cost. Vector_add is the worst case for showing GPU advantage.

const std = @import("std");
const cuda = @import("cuda");

pub fn main(init: std.process.Init) !void {
    const a = init.gpa;
    const io = init.io;

    try cuda.init();
    const dev = try cuda.Device.get(0);
    var name_buf: [256]u8 = undefined;
    std.debug.print("Device: {s}\n", .{try dev.name(&name_buf)});

    const ctx = try cuda.Context.create(dev);
    defer ctx.deinit();

    const module = try cuda.Module.loadData(@embedFile("kernel_ptx"));
    defer module.unload();
    const kernel = try module.getFunction("kernel_$_vector_add");

    const N: u32 = 1 << 24; // 16M elements; 64 MB per buffer
    const host_x = try a.alloc(f32, N);
    defer a.free(host_x);
    const host_y = try a.alloc(f32, N);
    defer a.free(host_y);
    const host_out = try a.alloc(f32, N);
    defer a.free(host_out);
    const cpu_out = try a.alloc(f32, N);
    defer a.free(cpu_out);

    for (host_x, host_y, 0..) |*x, *y, i| {
        x.* = @floatFromInt(i % 100);
        y.* = 2.0;
    }

    // ── CPU baseline ─────────────────────────────────────────────────
    const cpu_start: std.Io.Clock.Timestamp = .now(io, .awake);
    for (host_x, host_y, cpu_out) |x, y, *o| {
        o.* = x + y;
    }
    const cpu_ms = @as(f32, @floatFromInt(
        cpu_start.untilNow(io).raw.toMicroseconds(),
    )) / 1000.0;

    // ── GPU setup (allocations + initial copy, untimed) ──────────────
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

    // ── Pre-load device buffers, then time kernel-only ───────────────
    try dx.copyFromHost(host_x);
    try dy.copyFromHost(host_y);

    const k_start = try cuda.Event.create();
    defer k_start.deinit();
    const k_end = try cuda.Event.create();
    defer k_end.deinit();

    try k_start.record(null);
    try kernel.launch(.{
        .grid = .{ .x = grid },
        .block = .{ .x = block },
    }, .{ runtime_n, dx.ptr, dy.ptr, dout.ptr });
    try k_end.record(null);

    try k_end.synchronize();
    const kernel_only_ms = try cuda.Event.elapsed(k_start, k_end);

    try dout.copyToHost(host_out);

    // ── Verify correctness before benchmarking again ─────────────────
    var max_err: f32 = 0;
    for (cpu_out, host_out) |c, g| {
        const e = @abs(c - g);
        if (e > max_err) max_err = e;
    }

    // ── End-to-end: copy in + kernel + copy out, all timed ───────────
    const e_start = try cuda.Event.create();
    defer e_start.deinit();
    const e_end = try cuda.Event.create();
    defer e_end.deinit();

    try e_start.record(null);
    try dx.copyFromHost(host_x);
    try dy.copyFromHost(host_y);
    try kernel.launch(.{
        .grid = .{ .x = grid },
        .block = .{ .x = block },
    }, .{ runtime_n, dx.ptr, dy.ptr, dout.ptr });
    try dout.copyToHost(host_out);
    try e_end.record(null);

    try e_end.synchronize();
    const end_to_end_ms = try cuda.Event.elapsed(e_start, e_end);

    // ── Report ───────────────────────────────────────────────────────
    const k_speedup = cpu_ms / kernel_only_ms;
    const e_speedup = cpu_ms / end_to_end_ms;
    const transfer_ms = end_to_end_ms - kernel_only_ms;

    std.debug.print("\nN = {d} ({d} MB per buffer)\n", .{ N, (N * 4) / (1024 * 1024) });
    std.debug.print("Max error: {d}\n\n", .{max_err});

    std.debug.print("CPU (AVX2 reference):       {d:.3} ms\n", .{cpu_ms});
    std.debug.print("GPU kernel only:            {d:.3} ms  ({d:.1}x vs CPU)\n", .{ kernel_only_ms, k_speedup });
    std.debug.print("GPU end-to-end (w/ PCIe):   {d:.3} ms  ({d:.1}x vs CPU)\n", .{ end_to_end_ms, e_speedup });
    std.debug.print("PCIe transfer overhead:     {d:.3} ms  ({d:.0}% of end-to-end)\n", .{
        transfer_ms,
        100.0 * transfer_ms / end_to_end_ms,
    });
}
