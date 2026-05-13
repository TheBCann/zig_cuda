//! Idiomatic Zig wrapper over the raw bindings.
//! Returns CudaError unions, RAII-style deinit, comptime-typed memory.

const std = @import("std");
const c = @import("bindings.zig");

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

/// Print a human-readable description of the last error to stderr.
pub fn logError(r: c.CUresult) void {
    var name: [*:0]const u8 = "?";
    var desc: [*:0]const u8 = "?";
    _ = c.cuGetErrorName(r, &name);
    _ = c.cuGetErrorString(r, &desc);
    std.debug.print("CUDA error: {s}: {s}\n", .{ name, desc });
}

pub fn init() CudaError!void {
    try toErr(c.cuInit(0));
}

pub const Device = struct {
    handle: c.CUdevice,

    pub fn get(ordinal: c_int) CudaError!Device {
        var d: c.CUdevice = undefined;
        try toErr(c.cuDeviceGet(&d, ordinal));
        return .{ .handle = d };
    }

    pub fn count() CudaError!c_int {
        var n: c_int = 0;
        try toErr(c.cuDeviceGetCount(&n));
        return n;
    }

    pub fn name(self: Device, buf: []u8) CudaError![]const u8 {
        try toErr(c.cuDeviceGetName(buf.ptr, @intCast(buf.len), self.handle));
        const len = std.mem.indexOfScalar(u8, buf, 0) orelse buf.len;
        return buf[0..len];
    }
};

pub const Context = struct {
    handle: c.CUcontext,

    pub fn create(dev: Device) CudaError!Context {
        var ctx: c.CUcontext = null;
        try toErr(c.cuCtxCreate_v2(&ctx, 0, dev.handle));
        return .{ .handle = ctx };
    }

    pub fn deinit(self: Context) void {
        _ = c.cuCtxDestroy_v2(self.handle);
    }

    pub fn synchronize(_: Context) CudaError!void {
        try toErr(c.cuCtxSynchronize());
    }
};

pub const Module = struct {
    handle: c.CUmodule,

    pub fn loadFile(path: [*:0]const u8) CudaError!Module {
        var m: c.CUmodule = null;
        try toErr(c.cuModuleLoad(&m, path));
        return .{ .handle = m };
    }

    pub fn loadData(image: []const u8) CudaError!Module {
        var m: c.CUmodule = null;
        try toErr(c.cuModuleLoadData(&m, image.ptr));
        return .{ .handle = m };
    }

    pub fn unload(self: Module) void {
        _ = c.cuModuleUnload(self.handle);
    }

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

/// Typed device-side buffer. T must be a pod type.
pub fn DeviceBuffer(comptime T: type) type {
    return struct {
        ptr: c.CUdeviceptr,
        len: usize,

        const Self = @This();

        pub fn alloc(n: usize) CudaError!Self {
            var p: c.CUdeviceptr = 0;
            try toErr(c.cuMemAlloc_v2(&p, n * @sizeOf(T)));
            return .{ .ptr = p, .len = n };
        }

        pub fn free(self: Self) void {
            _ = c.cuMemFree_v2(self.ptr);
        }

        pub fn copyFromHost(self: Self, host: []const T) CudaError!void {
            std.debug.assert(host.len <= self.len);
            try toErr(c.cuMemcpyHtoD_v2(
                self.ptr,
                host.ptr,
                host.len * @sizeOf(T),
            ));
        }

        pub fn copyToHost(self: Self, host: []T) CudaError!void {
            std.debug.assert(host.len <= self.len);
            try toErr(c.cuMemcpyDtoH_v2(
                host.ptr,
                self.ptr,
                host.len * @sizeOf(T),
            ));
        }

        pub fn copyFromHostAsync(self: Self, host: []const T, stream: Stream) CudaError!void {
            std.debug.assert(host.len <= self.len);
            try toErr(c.cuMemcpyHtoDAsync_v2(
                self.ptr,
                host.ptr,
                host.len * @sizeOf(T),
                stream.handle,
            ));
        }

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

    pub fn create() CudaError!Stream {
        var s: c.CUstream = null;
        try toErr(c.cuStreamCreate(&s, 0));
        return .{ .handle = s };
    }

    pub fn deinit(self: Stream) void {
        _ = c.cuStreamDestroy_v2(self.handle);
    }

    /// block the host until all queued operations on this stream complete.
    pub fn synchronize(self: Stream) CudaError!void {
        try toErr(c.cuStreamSynchronize(self.handle));
    }
};

/// Page-locked host buffer. DMA transfers between this memory and the GPU
/// bypass the driver's hidden staging step, yielding ~2x faster PCIe copies.
/// Pinned memory is a limited OS resource - allocate sparingly.
pub fn PinnedBuffer(comptime T: type) type {
    return struct {
        ptr: [*]T,
        len: usize,

        const Self = @This();

        pub fn alloc(n: usize) CudaError!Self {
            var raw: ?*anyopaque = null;
            try toErr(c.cuMemHostAlloc(&raw, n * @sizeOf(T), 0));
            return .{
                .ptr = @ptrCast(@alignCast(raw.?)),
                .len = n,
            };
        }

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

pub const Dim3 = struct { x: c_uint = 1, y: c_uint = 1, z: c_uint = 1 };

pub const LaunchConfig = struct {
    grid: Dim3,
    block: Dim3,
    shared_mem: c_uint = 0,
    stream: c.CUstream = null,
};

/// A handle to a CUDA kernel, typed by its expected argument struct.
/// The Args struct names and types each kernel parameter; `launch`
/// type-checks the passed args at compile time.
pub fn Function(comptime Args: type) type {
    const ti = @typeInfo(Args);
    if (ti != .@"struct")
        @compileError("Function Args must be a struct type, got " ++ @typeName(Args));

    return struct {
        handle: c.CUfunction,

        const Self = @This();

        pub fn launch(
            self: Self,
            cfg: LaunchConfig,
            args: Args,
        ) CudaError!void {
            const fields = @typeInfo(Args).@"struct".fields;

            // Materialize args in a mutable local so we can take field
            // addresses for cuLuanchKernel's pointer-array calling convention.
            var storage = args;

            var ptrs: [fields.len]?*anyopaque = undefined;
            inline for (fields, 0..) |f, i| {
                ptrs[i] = @ptrCast(&@field(storage, f.name));
            }

            try toErr(c.cuLaunchKernel(
                    self.handle,
                    cfg.grid.x, cfg.grid.y, cfg.grid.z,
                    cfg.block.x, cfg.block.y, cfg.block.z,
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

    pub fn create() CudaError!Event {
        var e: c.CUevent = null;
        try toErr(c.cuEventCreate(&e, 0));
        return .{ .handle = e };
    }

    pub fn deinit(self: Event) void {
        _ = c.cuEventDestroy_v2(self.handle);
    }

    /// Record this event on the given stream (null = default stream)
    pub fn record(self: Event, stream: c.CUstream) CudaError!void {
        try toErr(c.cuEventRecord(self.handle, stream));
    }

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
