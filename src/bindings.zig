//! Raw FFI bindings to libcuda.so (CUDA Driver API).
//! Hand-written, no @cImport. Only the symbols needed for basic
//! kernel launch are declared here. Add more as needed.
//!
//! Reference: https://docs.nvidia.com/cuda/cuda-driver-api/

const std = @import("std");

// ── Opaque handle types ──────────────────────────────────────────────────
pub const CUdevice = c_int;
pub const CUcontext = ?*opaque {};
pub const CUmodule = ?*opaque {};
pub const CUfunction = ?*opaque {};
pub const CUstream = ?*opaque {};
pub const CUevent = ?*opaque {};
pub const CUdeviceptr = u64; // 64-bit on all supported platforms

// ── Result codes (subset; expand from cuda.h as needed) ──────────────────
pub const CUresult = enum(c_int) {
    success = 0,
    invalid_value = 1,
    out_of_memory = 2,
    not_initialized = 3,
    deinitialized = 4,
    profiler_disabled = 5,
    stub_library = 34,
    no_device = 100,
    invalid_device = 101,
    invalid_image = 200,
    invalid_context = 201,
    map_failed = 205,
    unmap_failed = 206,
    array_is_mapped = 207,
    already_mapped = 208,
    no_binary_for_gpu = 209,
    already_acquired = 210,
    not_mapped = 211,
    ecc_uncorrectable = 214,
    unsupported_limit = 215,
    invalid_source = 300,
    file_not_found = 301,
    shared_object_symbol_not_found = 302,
    shared_object_init_failed = 303,
    operating_system = 304,
    invalid_handle = 400,
    illegal_state = 401,
    not_found = 500,
    not_ready = 600,
    illegal_address = 700,
    launch_out_of_resources = 701,
    launch_timeout = 702,
    launch_incompatible_texturing = 703,
    context_already_in_use = 708,
    invalid_ptx = 718,
    invalid_graphics_context = 719,
    nvlink_uncorrectable = 720,
    jit_compiler_not_found = 721,
    invalid_source_kind = 722,
    unsupported_ptx_version = 723,
    unknown = 999,
    _, // open enum — driver may return codes we haven't mapped
};

/// ── Initialization ───────────────────────────────────────────────────────
pub extern "cuda" fn cuInit(flags: c_uint) CUresult;
pub extern "cuda" fn cuDriverGetVersion(driver_version: *c_int) CUresult;

/// ── Device management ────────────────────────────────────────────────────
pub extern "cuda" fn cuDeviceGet(device: *CUdevice, ordinal: c_int) CUresult;
pub extern "cuda" fn cuDeviceGetCount(count: *c_int) CUresult;
pub extern "cuda" fn cuDeviceGetName(
    name: [*]u8,
    len: c_int,
    dev: CUdevice,
) CUresult;
pub extern "cuda" fn cuDeviceTotalMem_v2(
    bytes: *usize,
    dev: CUdevice,
) CUresult;

/// ── Context management ──────────────────────────────────────────────────
// NOTE: _v2 versions are the canonical ABI symbols. Without _v2 you
// link against legacy 32-bit-pointer stubs. Always use _v2.
pub extern "cuda" fn cuCtxCreate_v2(
    pctx: *CUcontext,
    flags: c_uint,
    dev: CUdevice,
) CUresult;
pub extern "cuda" fn cuCtxDestroy_v2(ctx: CUcontext) CUresult;
pub extern "cuda" fn cuCtxSynchronize() CUresult;
pub extern "cuda" fn cuCtxSetCurrent(ctx: CUcontext) CUresult;

// ── Module management (load PTX) ─────────────────────────────────────────
pub extern "cuda" fn cuModuleLoad(
    module: *CUmodule,
    fname: [*:0]const u8,
) CUresult;
pub extern "cuda" fn cuModuleLoadData(
    module: *CUmodule,
    image: *const anyopaque,
) CUresult;
pub extern "cuda" fn cuModuleUnload(hmod: CUmodule) CUresult;
pub extern "cuda" fn cuModuleGetFunction(
    hfunc: *CUfunction,
    hmod: CUmodule,
    name: [*:0]const u8,
) CUresult;

// ── Memory management ───────────────────────────────────────────────────
pub extern "cuda" fn cuMemAlloc_v2(
    dptr: *CUdeviceptr,
    bytesize: usize,
) CUresult;
pub extern "cuda" fn cuMemFree_v2(dptr: CUdeviceptr) CUresult;
pub extern "cuda" fn cuMemcpyHtoD_v2(
    dst: CUdeviceptr,
    src: *const anyopaque,
    bytes: usize,
) CUresult;
pub extern "cuda" fn cuMemcpyDtoH_v2(
    dst: *anyopaque,
    src: CUdeviceptr,
    bytes: usize,
) CUresult;
pub extern "cuda" fn cuMemsetD8_v2(
    dst: CUdeviceptr,
    value: u8,
    n: usize,
) CUresult;

pub extern "cuda" fn cuMemsetD32_v2(
    dst: CUdeviceptr,
    value: c_uint,
    n: usize,
) CUresult;

// ── Kernel launch ───────────────────────────────────────────────────────
pub extern "cuda" fn cuLaunchKernel(
    f: CUfunction,
    grid_dim_x: c_uint,
    grid_dim_y: c_uint,
    grid_dim_z: c_uint,
    block_dim_x: c_uint,
    block_dim_y: c_uint,
    block_dim_z: c_uint,
    shared_mem_bytes: c_uint,
    h_stream: CUstream,
    kernel_params: ?[*]?*anyopaque,
    extra: ?[*]?*anyopaque,
) CUresult;

// ── Streams (for async work; not used in vector_add but useful) ─────────
pub extern "cuda" fn cuStreamCreate(
    stream: *CUstream,
    flags: c_uint,
) CUresult;
pub extern "cuda" fn cuStreamSynchronize(stream: CUstream) CUresult;
pub extern "cuda" fn cuStreamDestroy_v2(stream: CUstream) CUresult;

/// Events
/// CU_EVENT_DEFAULT = 0,
/// CU_EVENT_BLOCKING_SYNC = 1,
/// CU_EVENT_DISABLE_TIMING = 2
pub extern "cuda" fn cuEventCreate(
    event: *CUevent,
    flags: c_uint,
) CUresult;
pub extern "cuda" fn cuEventDestroy_v2(event: CUevent) CUresult;
pub extern "cuda" fn cuEventRecord(
    event: CUevent,
    stream: CUstream,
) CUresult;

pub extern "cuda" fn cuEventSynchronize(event: CUevent) CUresult;
pub extern "cuda" fn cuEventElapsedTime(
    ms: *f32,
    start: CUevent,
    end: CUevent,
) CUresult;

// ── Error string lookup (handy for debugging) ───────────────────────────
pub extern "cuda" fn cuGetErrorName(
    err: CUresult,
    str: *[*:0]const u8,
) CUresult;
pub extern "cuda" fn cuGetErrorString(
    err: CUresult,
    str: *[*:0]const u8,
) CUresult;
