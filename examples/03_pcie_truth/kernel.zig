//! Device code. Compiled to PTX with -target nvptx64-cuda-none -mcpu=sm_75.
//! Don't import std here — there's no host runtime available device-side.

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
