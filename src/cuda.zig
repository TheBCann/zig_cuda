//! Idiomatic Zig wrapper over the raw bindings in bindings.zig.
//!
//! - Every driver call is checked: a non-success `CUresult` becomes a
//!   `CudaError`, and `logError` prints the driver's name and description.
//! - Each resource is a small struct with an explicit `deinit`/`free`/
//!   `unload`. Release resources in reverse order of creation, with the
//!   `Context` last.
//! - `DeviceBuffer(T)` and `PinnedBuffer(T)` type memory by element.
//!   `Function(Args)` types a kernel launch by a struct of its parameters.
//!
//! Synchronous vs asynchronous: `copyFromHost`/`copyToHost` block until
//! they finish. `Function.launch`, the `*Async` copies and `Event.record`
//! only queue work. Call `Context.synchronize`, `Stream.synchronize` or
//! `Event.synchronize` before reading results on the host.

const std = @import("std");
const c = @import("bindings.zig");

/// Errors returned by the wrappers, mapped from the driver's `CUresult`.
/// Codes without a dedicated tag map to `error.Unknown`; use `logError` on
/// the raw result for details.
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
    Unknown,
};

fn toErr(r: c.CUresult) CudaError!void {
    return switch (r) {
        .success => {},
        .invalid_value => error.InvalidValue,
        .out_of_memory => error.OutOfMemory,
        .not_initialized => error.NotInitialized,
        .deinitialized => error.Deinitialized,
        .no_device => error.NoDevice,
        .invalid_device => error.InvalidDevice,
        .invalid_context => error.InvalidContext,
        .invalid_image => error.InvalidImage,
        .invalid_ptx => error.InvalidPtx,
        .invalid_source => error.InvalidSource,
        .file_not_found => error.FileNotFound,
        .no_binary_for_gpu => error.NoBinaryForGpu,
        .invalid_handle => error.InvalidHandle,
        .not_found => error.NotFound,
        .not_ready => error.NotReady,
        .illegal_address => error.IllegalAddress,
        .launch_out_of_resources => error.LaunchOutOfResources,
        .launch_timeout => error.LaunchTimeout,
        .unsupported_ptx_version => error.UnsupportedPtxVersion,
        else => error.Unknown,
    };
}

/// Print `r`'s numeric code, name and description to stderr.
pub fn logError(r: c.CUresult) void {
    var name: [*:0]const u8 = "?";
    var desc: [*:0]const u8 = "?";
    // For a code it doesn't recognize, the driver returns
    // CUDA_ERROR_INVALID_VALUE and writes NULL; only trust the out-params
    // when the call succeeded.
    if (c.cuGetErrorName(r, &name) != .success) name = "?";
    if (c.cuGetErrorString(r, &desc) != .success) desc = "unrecognized error code";
    std.debug.print("CUDA error {d}: {s}: {s}\n", .{ @backingInt(r), name, desc });
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

        /// Allocates device memory for `n` elements.
        pub fn alloc(n: usize) CudaError!Self {
            var p: c.CUdeviceptr = 0;
            try toErr(c.cuMemAlloc_v2(&p, n * @sizeOf(T)));
            return .{ .ptr = p, .len = n };
        }

        /// Frees the device memory.
        pub fn free(self: Self) void {
            _ = c.cuMemFree_v2(self.ptr);
        }

        /// Copies `host` to the start of the buffer; blocks until done.
        pub fn copyFromHost(self: Self, host: []const T) CudaError!void {
            std.debug.assert(host.len <= self.len);
            try toErr(c.cuMemcpyHtoD_v2(
                self.ptr,
                host.ptr,
                host.len * @sizeOf(T),
            ));
        }

        /// Copies the first `host.len` elements into `host`; blocks until done.
        pub fn copyToHost(self: Self, host: []T) CudaError!void {
            std.debug.assert(host.len <= self.len);
            try toErr(c.cuMemcpyDtoH_v2(
                host.ptr,
                self.ptr,
                host.len * @sizeOf(T),
            ));
        }

        /// Queues a copy of `host` to the buffer on `stream` and returns at
        /// once. `host` must stay valid until the stream reaches the copy;
        /// use a `PinnedBuffer` for truly asynchronous transfers.
        pub fn copyFromHostAsync(self: Self, host: []const T, stream: Stream) CudaError!void {
            std.debug.assert(host.len <= self.len);
            try toErr(c.cuMemcpyHtoDAsync_v2(
                self.ptr,
                host.ptr,
                host.len * @sizeOf(T),
                stream.handle,
            ));
        }

        /// Queues a copy into `host` on `stream` and returns at once. Read
        /// `host` only after synchronizing the stream.
        pub fn copyToHostAsync(self: Self, host: []T, stream: Stream) CudaError!void {
            std.debug.assert(host.len <= self.len);
            try toErr(c.cuMemcpyDtoHAsync_v2(
                host.ptr,
                self.ptr,
                host.len * @sizeOf(T),
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

        /// Allocates pinned host memory for `n` elements.
        pub fn alloc(n: usize) CudaError!Self {
            var raw: ?*anyopaque = null;
            try toErr(c.cuMemHostAlloc(&raw, n * @sizeOf(T), 0));
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
/// launch and call `elapsed` to get milliseconds between them.
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
