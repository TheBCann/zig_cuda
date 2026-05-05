//! Public API for the cuda module. Consumers do `@import("cuda")` and
//! get everything below; raw FFI is available under `cuda.bindings`.

pub const bindings = @import("bindings.zig");

// Error type and helpers
const cuda = @import("cuda.zig");
pub const CudaError = cuda.CudaError;
pub const logError = cuda.logError;
pub const init = cuda.init;

/// Core types
pub const Device = cuda.Device;
pub const Context = cuda.Context;
pub const Module = cuda.Module;
pub const Function = cuda.Function;

/// Memory
pub const DeviceBuffer = cuda.DeviceBuffer;

/// Launch configuration
pub const Dim3 = cuda.Dim3;
pub const LaunchConfig = cuda.LaunchConfig;

