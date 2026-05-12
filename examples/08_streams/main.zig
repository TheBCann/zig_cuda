//! Demonstrates pipelined async transfers using CUDA streams.
//!
//! Same vector_add workload as example 03 (the "PCIe truth" example),
//! run two ways back-to-back:
//!
//!   1. Synchronous baseline: pageable host memory, default stream.
//!      Identical to example 03 — upload everything, run kernel,
//!      download everything. PCIe transfers serialize against compute.
//!
//!   2. Pipelined streamed: pinned host memory, work split into K chunks
//!      across 2 alternating streams. While stream A's kernel runs,
//!      stream B uploads the next chunk, and a copy engine downloads
//!      the previous chunk's result. The 1660 Ti has separate HtoD and
//!      DtoH copy engines, so upload, compute, and download can run
//!      concurrently.
//!
//! Pinned memory is REQUIRED for async copies to be truly async. If you
//! pass pageable memory to cuMemcpyHtoDAsync, the driver internally does
//! a synchronous staging copy first, defeating the optimization. This is
//! the most common "why isn't my streamed code faster?" trap.

const std = @import("std");
const cuda = @import("cuda");

const N: u32 = 1 << 24;        // 16M elements, 64 MB per buffer
const K: u32 = 4;              // number of chunks for the streamed version
const CHUNK: u32 = N / K;       // elements per chunk
const NUM_STREAMS: u32 = 2;

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
    const kernel = try module.getFunction("kernel_$_vector_add");

    // ── Synchronous baseline (pageable memory, default stream) ───────
    // Reuses the same approach as example 03. This is the number we're
    // trying to beat.

    const host_x = try a.alloc(f32, N);
    defer a.free(host_x);
    const host_y = try a.alloc(f32, N);
    defer a.free(host_y);
    const host_out_sync = try a.alloc(f32, N);
    defer a.free(host_out_sync);

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

    const sync_start = try cuda.Event.create();
    defer sync_start.deinit();
    const sync_end = try cuda.Event.create();
    defer sync_end.deinit();

    const runtime_n = N;
    const block: c_uint = 256;
    const grid: c_uint = (N + block - 1) / block;

    try sync_start.record(null);
    try dx.copyFromHost(host_x);
    try dy.copyFromHost(host_y);
    try kernel.launch(.{
        .grid = .{ .x = grid },
        .block = .{ .x = block },
    }, .{ runtime_n, dx.ptr, dy.ptr, dout.ptr });
    try dout.copyToHost(host_out_sync);
    try sync_end.record(null);
    try sync_end.synchronize();
    const sync_ms = try cuda.Event.elapsed(sync_start, sync_end);

    // Verify correctness on the sync result.
    var sync_max_err: f32 = 0;
    for (host_x, host_y, host_out_sync) |x, y, o| {
        const e = @abs(o - (x + y));
        if (e > sync_max_err) sync_max_err = e;
    }

    // ── Pipelined streamed version ───────────────────────────────────
    // Pinned host buffers — required for async copies to actually be async.
    const Pinned = cuda.PinnedBuffer(f32);
    const pin_x = try Pinned.alloc(N);
    defer pin_x.free();
    const pin_y = try Pinned.alloc(N);
    defer pin_y.free();
    const pin_out = try Pinned.alloc(N);
    defer pin_out.free();

    // Copy input data into pinned buffers (one-time cost; in real apps the
    // application would generate data directly into pinned memory).
    @memcpy(pin_x.slice(), host_x);
    @memcpy(pin_y.slice(), host_y);

    var streams: [NUM_STREAMS]cuda.Stream = undefined;
    for (&streams) |*s| s.* = try cuda.Stream.create();
    defer for (streams) |s| s.deinit();

    const stream_start = try cuda.Event.create();
    defer stream_start.deinit();
    const stream_end = try cuda.Event.create();
    defer stream_end.deinit();

    // Pipeline: each chunk runs entirely on one stream, but consecutive
    // chunks alternate streams. While chunk i's kernel is running on
    // stream A, chunk i+1 can upload on stream B, and chunk i-1 can
    // download on stream B's download engine — all in parallel.
    try stream_start.record(null);

    var chunk_idx: u32 = 0;
    while (chunk_idx < K) : (chunk_idx += 1) {
        const stream = streams[chunk_idx % NUM_STREAMS];
        const offset = chunk_idx * CHUNK;
        const chunk_grid: c_uint = (CHUNK + block - 1) / block;
        const chunk_n = CHUNK;

        // Async upload of this chunk's slice of x and y.
        const x_slice = pin_x.slice()[offset .. offset + CHUNK];
        const y_slice = pin_y.slice()[offset .. offset + CHUNK];
        const out_slice = pin_out.slice()[offset .. offset + CHUNK];

        const dx_off: cuda.bindings.CUdeviceptr = dx.ptr + offset * @sizeOf(f32);
        const dy_off: cuda.bindings.CUdeviceptr = dy.ptr + offset * @sizeOf(f32);
        const dout_off: cuda.bindings.CUdeviceptr = dout.ptr + offset * @sizeOf(f32);

        // Manually issue async copies and the launch with this stream.
        // The library's typed wrappers always operate on the full buffer;
        // for sub-buffer ops we drop down to the raw bindings.
        try toErr(cuda.bindings.cuMemcpyHtoDAsync_v2(
            dx_off,
            x_slice.ptr,
            CHUNK * @sizeOf(f32),
            stream.handle,
        ));
        try toErr(cuda.bindings.cuMemcpyHtoDAsync_v2(
            dy_off,
            y_slice.ptr,
            CHUNK * @sizeOf(f32),
            stream.handle,
        ));
        try kernel.launch(.{
            .grid = .{ .x = chunk_grid },
            .block = .{ .x = block },
            .stream = stream.handle,
        }, .{ chunk_n, dx_off, dy_off, dout_off });
        try toErr(cuda.bindings.cuMemcpyDtoHAsync_v2(
            out_slice.ptr,
            dout_off,
            CHUNK * @sizeOf(f32),
            stream.handle,
        ));
    }

    // Wait for all streams to drain before stopping the timer.
    for (streams) |s| try s.synchronize();
    try stream_end.record(null);
    try stream_end.synchronize();
    const stream_ms = try cuda.Event.elapsed(stream_start, stream_end);

    // Verify the streamed result matches.
    var stream_max_err: f32 = 0;
    for (host_x, host_y, pin_out.slice()) |x, y, o| {
        const e = @abs(o - (x + y));
        if (e > stream_max_err) stream_max_err = e;
    }

    // ── Report ───────────────────────────────────────────────────────
    const speedup = sync_ms / stream_ms;
    const bytes_per_op: f64 = @as(f64, @floatFromInt(N)) * @as(f64, @sizeOf(f32)) * 3.0;
    const sync_gbps = bytes_per_op / (@as(f64, sync_ms) * 1.0e6);
    const stream_gbps = bytes_per_op / (@as(f64, stream_ms) * 1.0e6);

    std.debug.print("\nN = {d} ({d} MB per buffer, 3 buffers)\n", .{
        N,
        (N * @sizeOf(f32)) / (1024 * 1024),
    });
    std.debug.print("Chunks: {d}, streams: {d}\n", .{ K, NUM_STREAMS });
    std.debug.print("Max error: sync = {d}, streamed = {d}\n\n", .{ sync_max_err, stream_max_err });

    std.debug.print("Sync baseline (pageable, default stream):  {d:.3} ms ({d:.1} GB/s effective)\n", .{ sync_ms, sync_gbps });
    std.debug.print("Streamed (pinned, {d} streams, {d} chunks): {d:.3} ms ({d:.1} GB/s effective)\n", .{ NUM_STREAMS, K, stream_ms, stream_gbps });
    std.debug.print("Speedup: {d:.2}x\n", .{speedup});
}

// Small helper to call raw bindings without importing the whole error mapping.
fn toErr(r: cuda.bindings.CUresult) cuda.CudaError!void {
    if (r == .success) return;
    cuda.logError(r);
    return error.Unknown;
}
