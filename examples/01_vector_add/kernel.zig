//! Device code, compiled to PTX by build.zig's `addKernel` (nvptx64-cuda,
//! sm_75, .fast). std's pure parts (math, comptime helpers) work here, but
//! nothing that needs an operating system does: no allocator, files or I/O.

/// Computes `out[i] = x[i] + y[i]` for `i < n`, one element per thread.
export fn vector_add(
    n: u32,
    x: [*]addrspace(.global) const f32,
    y: [*]addrspace(.global) const f32,
    out: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    const tid: u32 = @intCast(@workItemId(0));
    const bid: u32 = @intCast(@workGroupId(0));
    const bdim: u32 = @intCast(@workGroupSize(0));
    const i = bid * bdim + tid;
    if (i < n) {
        out[i] = x[i] + y[i];
    }
}
