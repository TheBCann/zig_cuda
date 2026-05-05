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

    pub fn getFunction(self: Module, name: [*:0]const u8) CudaError!Function {
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
    };
}

pub const Dim3 = struct { x: c_uint = 1, y: c_uint = 1, z: c_uint = 1 };

pub const LaunchConfig = struct {
    grid: Dim3,
    block: Dim3,
    shared_mem: c_uint = 0,
    stream: c.CUstream = null,
};

pub const Function = struct {
    handle: c.CUfunction,

    /// Launch the kernel with `args` as a tuple. Each argument is
    /// materialized on the stack and a pointer-array is built so cuLaunchKernel
    /// can read each parameter by address (its calling convention).
    pub fn launch(
        self: Function,
        cfg: LaunchConfig,
        args: anytype,
    ) CudaError!void {
        const Args = @TypeOf(args);
        const fields = @typeInfo(Args).@"struct".fields;

        // 1. Construct a new purely runtime tuple using the new @Tuple builtin
        comptime var runtime_types: [fields.len]type = undefined;
        inline for (fields, 0..) |f, i| {
            runtime_types[i] = f.type;
        }
        const RuntimeArgs = @Tuple(&runtime_types);

        // 2. Copy the arguments into our guaranteed-runtime storage
        var storage: RuntimeArgs = undefined;
        inline for (fields) |f| {
            @field(storage, f.name) = @field(args, f.name);
        }

        // 3. Take addresses safely
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

    /// Rreturn milliseconds elapsed betweeen `start` and `end`.
    /// Both events must have been recorded; the caller is responsible
    /// for synchronizing on `end` first.
    pub fn elapsed(start: Event, end: Event) CudaError!f32 {
        var ms: f32 = 0;
        try toErr(c.cuEventElapsedTime(&ms, start.handle, end.handle));
        return ms;
    }
};
