//! Idiomatic Zig wrapper over the raw bindings in bindings.zig.
//!
//! - Every driver call is checked: a non-success `CUresult` becomes a
//!   `CudaError`, and `logError` prints the driver's name and description.
//! - Each resource is a small struct with an explicit `deinit`/`free`/
//!   `unload`. Release resources in reverse order of creation, with the
//!   `Context` last.
//! - `DeviceBuffer(T)` and `PinnedBuffer(T)` type memory by element.
//!   `Function(Args)` types a kernel launch by a struct of its parameters.
//! - `Bench` times GPU work for benchmarks: a warm-up, then the median of
//!   repeated runs. `Event` is the raw timer underneath it.
//!
//! Synchronous vs asynchronous: `copyFromHost`/`copyToHost` block until
//! they finish. `Function.launch`, the `*Async` copies and `Event.record`
//! only queue work. Call `Context.synchronize`, `Stream.synchronize` or
//! `Event.synchronize` before reading results on the host.

const std = @import("std");
const c = @import("bindings.zig");
const memory_checks = @import("memory_checks.zig");

/// Errors returned by the wrappers, mapped from the driver's `CUresult`.
/// Codes without a dedicated tag map to `error.Unknown`; use `logError` on
/// the raw result for details. `SizeOverflow` is the one error the wrappers
/// raise themselves: a requested byte size does not fit in `usize`.
pub const CudaError = error{
    InvalidValue,
    OutOfMemory,
    NotInitialized,
    Deinitialized,
    NoDevice,
    InvalidDevice,
    InvalidContext,
    InvalidImage,
    InvalidPtx,
    InvalidSource,
    FileNotFound,
    NoBinaryForGpu,
    InvalidHandle,
    NotFound,
    NotReady,
    IllegalAddress,
    LaunchOutOfResources,
    LaunchTimeout,
    UnsupportedPtxVersion,
    SizeOverflow,
    Unknown,
};

fn toErr(r: c.CUresult) CudaError!void {
    return switch (r) {
        c.CUDA_SUCCESS => {},
        c.CUDA_ERROR_INVALID_VALUE => error.InvalidValue,
        c.CUDA_ERROR_OUT_OF_MEMORY => error.OutOfMemory,
        c.CUDA_ERROR_NOT_INITIALIZED => error.NotInitialized,
        c.CUDA_ERROR_DEINITIALIZED => error.Deinitialized,
        c.CUDA_ERROR_NO_DEVICE => error.NoDevice,
        c.CUDA_ERROR_INVALID_DEVICE => error.InvalidDevice,
        c.CUDA_ERROR_INVALID_CONTEXT => error.InvalidContext,
        c.CUDA_ERROR_INVALID_IMAGE => error.InvalidImage,
        c.CUDA_ERROR_INVALID_PTX => error.InvalidPtx,
        c.CUDA_ERROR_INVALID_SOURCE => error.InvalidSource,
        c.CUDA_ERROR_FILE_NOT_FOUND => error.FileNotFound,
        c.CUDA_ERROR_NO_BINARY_FOR_GPU => error.NoBinaryForGpu,
        c.CUDA_ERROR_INVALID_HANDLE => error.InvalidHandle,
        c.CUDA_ERROR_NOT_FOUND => error.NotFound,
        c.CUDA_ERROR_NOT_READY => error.NotReady,
        c.CUDA_ERROR_ILLEGAL_ADDRESS => error.IllegalAddress,
        c.CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES => error.LaunchOutOfResources,
        c.CUDA_ERROR_LAUNCH_TIMEOUT => error.LaunchTimeout,
        c.CUDA_ERROR_UNSUPPORTED_PTX_VERSION => error.UnsupportedPtxVersion,
        else => error.Unknown,
    };
}

/// Print `r`'s numeric code, name and description to stderr.
pub fn logError(r: c.CUresult) void {
    var name: [*c]const u8 = null;
    var desc: [*c]const u8 = null;
    const name_ok = c.cuGetErrorName(r, &name) == c.CUDA_SUCCESS;
    const desc_ok = c.cuGetErrorString(r, &desc) == c.CUDA_SUCCESS;
    const name_text = if (name_ok and name != null) std.mem.span(name) else "?";
    const desc_text = if (desc_ok and desc != null) std.mem.span(desc) else "unrecognized error code";
    std.debug.print("CUDA error {d}: {s}: {s}\n", .{ r, name_text, desc_text });
}

/// Initializes the CUDA driver. Call once before any other function.
pub fn init() CudaError!void {
    try toErr(c.cuInit(0));
}

/// A CUDA-capable GPU, identified by its ordinal.
pub const Device = struct {
    handle: c.CUdevice,

    /// Returns the device with the given ordinal (0 is the first GPU).
    pub fn get(ordinal: c_int) CudaError!Device {
        var d: c.CUdevice = undefined;
        try toErr(c.cuDeviceGet(&d, ordinal));
        return .{ .handle = d };
    }

    /// Returns the number of CUDA-capable devices.
    pub fn count() CudaError!c_int {
        var n: c_int = 0;
        try toErr(c.cuDeviceGetCount(&n));
        return n;
    }

    /// Writes the device's name into `buf` and returns the written part.
    pub fn name(self: Device, buf: []u8) CudaError![]const u8 {
        try toErr(c.cuDeviceGetName(buf.ptr, @intCast(buf.len), self.handle));
        const len = std.mem.findScalar(u8, buf, 0) orelse buf.len;
        return buf[0..len];
    }
};

/// A CUDA context on one device; owns its allocations and modules.
pub const Context = struct {
    handle: c.CUcontext,

    /// Creates a context on `dev` and makes it current for this thread.
    pub fn create(dev: Device) CudaError!Context {
        var ctx: c.CUcontext = null;
        try toErr(c.cuCtxCreate_v2(&ctx, 0, dev.handle));
        return .{ .handle = ctx };
    }

    /// Destroys the context, releasing everything allocated in it.
    pub fn deinit(self: Context) void {
        _ = c.cuCtxDestroy_v2(self.handle);
    }

    /// Blocks until all work queued in the current context has completed.
    pub fn synchronize(_: Context) CudaError!void {
        try toErr(c.cuCtxSynchronize());
    }
};

/// A loaded GPU code module (PTX, cubin or fatbin) whose kernels can be
/// looked up with `getFunction`.
pub const Module = struct {
    handle: c.CUmodule,

    /// Loads a module from the file at `path`.
    pub fn loadFile(path: [*:0]const u8) CudaError!Module {
        var m: c.CUmodule = null;
        try toErr(c.cuModuleLoad(&m, path));
        return .{ .handle = m };
    }

    /// Load NUL-terminated PTX text, e.g. `@embedFile("kernel_ptx")`. The
    /// slice type enforces the terminator the driver needs to read PTX.
    ///
    /// The driver JIT-compiles the PTX here, which took about 25-30 ms for
    /// example 11's kernel on a GTX 1660 Ti (driver 610.57). The result is
    /// cached on disk, so later loads take about 0.1-0.2 ms. The JIT produced
    /// bit-identical machine code to nvcc's offline `ptxas`, so shipping PTX
    /// costs nothing at run time.
    pub fn loadPtx(ptx: [:0]const u8) CudaError!Module {
        var m: c.CUmodule = null;
        try toErr(c.cuModuleLoadData(&m, ptx.ptr));
        return .{ .handle = m };
    }

    /// Load a cubin or fatbin image, which needs no terminator. For PTX
    /// text use `loadPtx`: the driver reads PTX up to a NUL byte that this
    /// signature cannot guarantee.
    pub fn loadData(image: []const u8) CudaError!Module {
        var m: c.CUmodule = null;
        try toErr(c.cuModuleLoadData(&m, image.ptr));
        return .{ .handle = m };
    }

    /// Unloads the module; its `Function` handles become invalid.
    pub fn unload(self: Module) void {
        _ = c.cuModuleUnload(self.handle);
    }

    /// Looks up the kernel exported as `name` and returns a launch handle
    /// typed by `Args`, a struct with one field per kernel parameter.
    ///
    /// `name` must match the PTX `.entry` exactly: for
    /// `export fn vector_add(...) callconv(.kernel)` it is "vector_add". A
    /// wrong name only fails here, at run time, with `error.NotFound`. CI
    /// checks every literal name against the built PTX for that reason.
    pub fn getFunction(
        self: Module,
        comptime Args: type,
        name: [*:0]const u8,
    ) CudaError!Function(Args) {
        var f: c.CUfunction = null;
        try toErr(c.cuModuleGetFunction(&f, self.handle, name));
        return .{ .handle = f };
    }
};

/// Typed device-side buffer. `T` must be a plain-old-data type.
pub fn DeviceBuffer(comptime T: type) type {
    return struct {
        ptr: c.CUdeviceptr,
        len: usize,

        const Self = @This();

        /// Allocates device memory for `n` elements. Returns
        /// `error.SizeOverflow` if `n * @sizeOf(T)` overflows `usize`.
        pub fn alloc(n: usize) CudaError!Self {
            const bytes = try memory_checks.allocationBytes(T, n);

            var p: c.CUdeviceptr = 0;
            try toErr(c.cuMemAlloc_v2(&p, bytes));
            return .{ .ptr = p, .len = n };
        }

        /// Frees the device memory.
        pub fn free(self: Self) void {
            _ = c.cuMemFree_v2(self.ptr);
        }

        /// Copy methods return InvalidValue if the host slice exceeds the buffer.
        /// Copies `host` to the start of the buffer; blocks until done.
        pub fn copyFromHost(self: Self, host: []const T) CudaError!void {
            const bytes = try memory_checks.copyBytes(T, self.len, host.len);
            try toErr(c.cuMemcpyHtoD_v2(
                self.ptr,
                host.ptr,
                bytes,
            ));
        }

        /// Copies the first `host.len` elements into `host`; blocks until done.
        pub fn copyToHost(self: Self, host: []T) CudaError!void {
            const bytes = try memory_checks.copyBytes(T, self.len, host.len);
            try toErr(c.cuMemcpyDtoH_v2(
                host.ptr,
                self.ptr,
                bytes,
            ));
        }

        /// Queues a copy of `host` to the buffer on `stream` and returns at
        /// once. `host` must stay valid until the stream reaches the copy;
        /// use a `PinnedBuffer` for truly asynchronous transfers.
        pub fn copyFromHostAsync(self: Self, host: []const T, stream: Stream) CudaError!void {
            const bytes = try memory_checks.copyBytes(T, self.len, host.len);
            try toErr(c.cuMemcpyHtoDAsync_v2(
                self.ptr,
                host.ptr,
                bytes,
                stream.handle,
            ));
        }

        /// Queues a copy into `host` on `stream` and returns at once. Read
        /// `host` only after synchronizing the stream.
        pub fn copyToHostAsync(self: Self, host: []T, stream: Stream) CudaError!void {
            const bytes = try memory_checks.copyBytes(T, self.len, host.len);
            try toErr(c.cuMemcpyDtoHAsync_v2(
                host.ptr,
                self.ptr,
                bytes,
                stream.handle,
            ));
        }
    };
}

/// CUDA stream: an ordered queue of operations. Operations within a stream
/// are sequential; operations in different streams may execute concurrently.
/// Use streams to pipeline copies with kernel execution.
pub const Stream = struct {
    handle: c.CUstream,

    /// Creates a new stream.
    pub fn create() CudaError!Stream {
        var s: c.CUstream = null;
        try toErr(c.cuStreamCreate(&s, 0));
        return .{ .handle = s };
    }

    /// Destroys the stream once its queued work has finished.
    pub fn deinit(self: Stream) void {
        _ = c.cuStreamDestroy_v2(self.handle);
    }

    /// Blocks the host until all queued operations on this stream complete.
    pub fn synchronize(self: Stream) CudaError!void {
        try toErr(c.cuStreamSynchronize(self.handle));
    }
};

/// Page-locked host buffer. DMA transfers between this memory and the GPU
/// bypass the driver's hidden staging step, yielding ~2x faster PCIe copies.
/// Pinned memory is a limited OS resource; allocate sparingly.
pub fn PinnedBuffer(comptime T: type) type {
    return struct {
        ptr: [*]T,
        len: usize,

        const Self = @This();

        /// Allocates pinned host memory for `n` elements. Returns
        /// `error.SizeOverflow` if `n * @sizeOf(T)` overflows `usize`.
        pub fn alloc(n: usize) CudaError!Self {
            const bytes = try memory_checks.allocationBytes(T, n);

            var raw: ?*anyopaque = null;
            try toErr(c.cuMemHostAlloc(&raw, bytes, 0));
            return .{
                .ptr = @ptrCast(@alignCast(raw.?)),
                .len = n,
            };
        }

        /// Frees the pinned memory.
        pub fn free(self: Self) void {
            _ = c.cuMemFreeHost(self.ptr);
        }

        /// Returns a regular Zig slice view of the pinned memory.
        /// Use this to read/write the buffer from the host like normal memory.
        pub fn slice(self: Self) []T {
            return self.ptr[0..self.len];
        }
    };
}

/// Grid or block dimensions for a kernel launch; unset axes default to 1.
pub const Dim3 = struct { x: c_uint = 1, y: c_uint = 1, z: c_uint = 1 };

/// How to launch a kernel: grid and block sizes, dynamic shared memory in
/// bytes, and the stream (null is the default stream).
pub const LaunchConfig = struct {
    grid: Dim3,
    block: Dim3,
    shared_mem: c_uint = 0,
    stream: c.CUstream = null,
};

/// A handle to a CUDA kernel, typed by its expected argument struct.
/// `Args` names and types each kernel parameter in declaration order, and
/// `launch` type-checks the passed args at compile time.
///
/// `Args` must mirror the kernel's parameters field for field: the driver
/// receives one pointer per field, so a missing, extra or reordered field
/// compiles fine but passes garbage to the GPU.
///
/// Example (examples/01_vector_add):
///   const VectorAddArgs = struct { n: u32, x: CUdeviceptr, y: CUdeviceptr, out: CUdeviceptr };
///   const kernel = try module.getFunction(VectorAddArgs, "vector_add");
///   try kernel.launch(.{ .grid = .{ .x = grid }, .block = .{ .x = 256 } },
///       .{ .n = n, .x = dx.ptr, .y = dy.ptr, .out = dout.ptr });
///   try ctx.synchronize(); // launch only queues the kernel
pub fn Function(comptime Args: type) type {
    const ti = @typeInfo(Args);
    if (ti != .@"struct")
        @compileError("Function Args must be a struct type, got " ++ @typeName(Args));

    return struct {
        handle: c.CUfunction,

        const Self = @This();

        /// Queues the kernel on `cfg.stream` with `args` and returns at once;
        /// launch errors such as an illegal address surface at the next
        /// synchronizing call.
        pub fn launch(
            self: Self,
            cfg: LaunchConfig,
            args: Args,
        ) CudaError!void {
            const field_names = @typeInfo(Args).@"struct".field_names;

            // Materialize args in a mutable local so we can take field
            // addresses for cuLaunchKernel's pointer-array calling convention.
            var storage = args;

            var ptrs: [field_names.len]?*anyopaque = undefined;
            inline for (field_names, 0..) |name, i| {
                ptrs[i] = @ptrCast(&@field(storage, name));
            }

            try toErr(c.cuLaunchKernel(
                self.handle,
                cfg.grid.x,
                cfg.grid.y,
                cfg.grid.z,
                cfg.block.x,
                cfg.block.y,
                cfg.block.z,
                cfg.shared_mem,
                cfg.stream,
                &ptrs,
                null,
            ));
        }
    };
}

/// CUDA event for timing GPU work. Pair two of them around a kernel
/// launch and call `elapsed` to get milliseconds between them. One such
/// measurement on an idle GPU is not representative; use `Bench` for
/// numbers worth quoting.
pub const Event = struct {
    handle: c.CUevent,

    /// Creates an event with timing enabled.
    pub fn create() CudaError!Event {
        var e: c.CUevent = null;
        try toErr(c.cuEventCreate(&e, 0));
        return .{ .handle = e };
    }

    /// Destroys the event.
    pub fn deinit(self: Event) void {
        _ = c.cuEventDestroy_v2(self.handle);
    }

    /// Records this event on `stream` (null is the default stream).
    pub fn record(self: Event, stream: c.CUstream) CudaError!void {
        try toErr(c.cuEventRecord(self.handle, stream));
    }

    /// Blocks the host until the event has been reached.
    pub fn synchronize(self: Event) CudaError!void {
        try toErr(c.cuEventSynchronize(self.handle));
    }

    /// Returns milliseconds elapsed between `start` and `end`.
    /// Both events must have been recorded; the caller is responsible
    /// for synchronizing on `end` first.
    pub fn elapsed(start: Event, end: Event) CudaError!f32 {
        var ms: f32 = 0;
        try toErr(c.cuEventElapsedTime(&ms, start.handle, end.handle));
        return ms;
    }
};

/// Summary of repeated timings, in milliseconds.
pub const Timing = struct {
    /// Median of the timed runs.
    median_ms: f32,
    /// Fastest timed run.
    min_ms: f32,
    /// Slowest timed run.
    max_ms: f32,
    /// How many timed runs the figures above cover.
    runs: u32,

    /// Summarizes `samples`, sorting them in place. Asserts there is at
    /// least one.
    pub fn fromSamples(samples: []f32) Timing {
        std.debug.assert(samples.len > 0);
        std.mem.sort(f32, samples, {}, std.sort.asc(f32));
        const mid = samples.len / 2;
        return .{
            .median_ms = if (samples.len % 2 == 1)
                samples[mid]
            else
                (samples[mid - 1] + samples[mid]) / 2,
            .min_ms = samples[0],
            .max_ms = samples[samples.len - 1],
            .runs = @intCast(samples.len),
        };
    }
};

/// Benchmarks a piece of GPU work: repeats it untimed until the GPU has left
/// its idle clock state, then times more repetitions with CUDA events and
/// reports their median.
///
/// A single launch from idle under-reports a compute-bound kernel. On a GTX
/// 1660 Ti (driver 615.78) a 1024x1024 matmul took 1.35 ms per launch for
/// the first ~300 ms of sustained load and 1.03 ms from then on, and the
/// GPU was back in the slow state after 3 s without work. A memory-bound
/// kernel (vector add) measured the same in both states.
///
/// The body of the `while` loop is the work being timed. It may queue
/// kernels and copies on the default stream; work it puts on other streams
/// must be synchronized before the body ends, because each repetition is
/// closed by an event on the default stream. The body must give the same
/// result every time it runs, since it runs many times.
///
/// Example:
///   var bench = try cuda.Bench.init(io, .{});
///   defer bench.deinit();
///   while (try bench.next()) try kernel.launch(cfg, args);
///   const t = bench.total(); // t.median_ms, t.min_ms, t.max_ms, t.runs
pub const Bench = struct {
    /// Supplies the host clock that bounds the warm-up and the timed phase.
    io: std.Io,
    /// The options this benchmark was created with.
    opts: Options,
    /// `marks[0]` opens a repetition, `lap` records the next ones, and the
    /// last one recorded closes it.
    marks: [max_segments + 1]Event,
    /// Marks recorded so far in the current repetition.
    n_marks: usize = 0,
    /// Where the benchmark is in its life cycle.
    phase: enum { idle, warmup, timed, done } = .idle,
    /// Host time at which the current phase began.
    phase_start: std.Io.Clock.Timestamp = undefined,
    /// Timed repetitions stored so far.
    count: u32 = 0,
    /// Segments per repetition, fixed by the first timed one.
    segments: usize = 0,
    /// Milliseconds each timed repetition took.
    totals: [max_runs]f32 = undefined,
    /// Milliseconds each segment of each timed repetition took.
    laps: [max_segments][max_runs]f32 = undefined,

    /// Most timed repetitions a `Bench` can store.
    pub const max_runs = 64;
    /// Most segments a repetition can be split into with `lap`.
    pub const max_segments = 4;

    /// How long to warm up and how many repetitions to time.
    pub const Options = struct {
        /// Repeat the work untimed until this much host time has passed,
        /// and always at least once. The default leaves a margin over the
        /// ~300 ms a GTX 1660 Ti needed to reach its full clocks.
        warmup_ms: u32 = 400,
        /// Timed repetitions to collect, from 1 to `max_runs`.
        runs: u32 = 20,
        /// Stop collecting early once the timed repetitions have taken this
        /// much host time; at least one is always collected. This bounds
        /// the cost of slow work, for example on a simulated GPU.
        budget_ms: u32 = 2000,
    };

    /// Creates the events a benchmark needs. `io` supplies the host clock
    /// that bounds the warm-up and the timed phase.
    pub fn init(io: std.Io, opts: Options) CudaError!Bench {
        std.debug.assert(opts.runs >= 1 and opts.runs <= max_runs);
        var marks: [max_segments + 1]Event = undefined;
        var created: usize = 0;
        errdefer for (marks[0..created]) |e| e.deinit();
        while (created < marks.len) : (created += 1) {
            marks[created] = try Event.create();
        }
        return .{ .io = io, .opts = opts, .marks = marks };
    }

    /// Destroys the benchmark's events.
    pub fn deinit(self: *Bench) void {
        for (self.marks) |e| e.deinit();
    }

    /// Closes the previous repetition, waiting for its work to finish, and
    /// opens the next one. Returns false once the timed repetitions are
    /// complete; use it as the condition of a `while` loop whose body is
    /// the work.
    pub fn next(self: *Bench) CudaError!bool {
        switch (self.phase) {
            .idle => {
                self.phase = .warmup;
                self.phase_start = .now(self.io, .awake);
            },
            .warmup => {
                try self.close();
                if (self.phaseMs() >= @as(f64, @floatFromInt(self.opts.warmup_ms))) {
                    self.phase = .timed;
                    self.phase_start = .now(self.io, .awake);
                }
            },
            .timed => {
                try self.close();
                try self.store();
                if (self.count == self.opts.runs or
                    self.phaseMs() >= @as(f64, @floatFromInt(self.opts.budget_ms)))
                {
                    self.phase = .done;
                    return false;
                }
            },
            .done => return false,
        }
        self.n_marks = 0;
        try self.mark();
        return true;
    }

    /// Ends the current segment of the repetition and starts the next, so
    /// stages of a pipeline can be timed separately with `segment`. Every
    /// repetition must call it the same number of times, at most
    /// `max_segments - 1`.
    pub fn lap(self: *Bench) CudaError!void {
        std.debug.assert(self.n_marks >= 1 and self.n_marks < max_segments);
        try self.mark();
    }

    /// Timing of whole repetitions. Call after `next` has returned false.
    pub fn total(self: *Bench) Timing {
        std.debug.assert(self.phase == .done);
        return .fromSamples(self.totals[0..self.count]);
    }

    /// Timing of segment `index` (0 is the work before the first `lap`).
    /// Call after `next` has returned false.
    pub fn segment(self: *Bench, index: usize) Timing {
        std.debug.assert(self.phase == .done and index < self.segments);
        return .fromSamples(self.laps[index][0..self.count]);
    }

    fn mark(self: *Bench) CudaError!void {
        try self.marks[self.n_marks].record(null);
        self.n_marks += 1;
    }

    /// Records the closing mark and waits for it, and so for all the work
    /// queued before it.
    fn close(self: *Bench) CudaError!void {
        try self.mark();
        try self.marks[self.n_marks - 1].synchronize();
    }

    fn store(self: *Bench) CudaError!void {
        const segs = self.n_marks - 1;
        if (self.count == 0) self.segments = segs;
        std.debug.assert(segs == self.segments);
        self.totals[self.count] = try Event.elapsed(self.marks[0], self.marks[segs]);
        for (0..segs) |i| {
            self.laps[i][self.count] = try Event.elapsed(self.marks[i], self.marks[i + 1]);
        }
        self.count += 1;
    }

    /// Host milliseconds since the current phase began.
    fn phaseMs(self: *const Bench) f64 {
        const us = self.phase_start.untilNow(self.io).raw.toMicroseconds();
        return @as(f64, @floatFromInt(us)) / 1000.0;
    }
};

test "generated CUDA result constants map to wrapper errors" {
    try toErr(c.CUDA_SUCCESS);
    try std.testing.expectError(error.InvalidValue, toErr(c.CUDA_ERROR_INVALID_VALUE));
    try std.testing.expectError(error.OutOfMemory, toErr(c.CUDA_ERROR_OUT_OF_MEMORY));
    try std.testing.expectError(error.InvalidPtx, toErr(c.CUDA_ERROR_INVALID_PTX));
    try std.testing.expectError(error.NotReady, toErr(c.CUDA_ERROR_NOT_READY));
    try std.testing.expectError(error.Unknown, toErr(123456));
}
