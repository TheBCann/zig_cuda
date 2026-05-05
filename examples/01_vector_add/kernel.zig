//! Device code. Compiled to PTX with -target nvptx64-cuda-none -mcpu=sm_75.
//! Don't import std here — there's no host runtime available device-side.

pub fn vector_add(
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

// Force PTX emission of vector_add without triggering LLVM's NVPTX
// aliasee restriction.
//
// The constraint: anything that creates a *symbol pointing directly at
// vector_add* (export fn, export const, @export builtin) triggers
// "LLVM ERROR: NVPTX aliasee must be a non-kernel function definition"
// because LLVM represents these as aliases of the kernel.
//
// This works because __dummy_force_emit is a regular *non-kernel function
// with a body* that takes the kernel's address as a runtime value. LLVM
// compiles the body normally — no alias is created. The kernel survives
// DCE because the dummy references it.
//
// Side effect: vector_add is not export-named, so its PTX symbol is
// Zig-mangled to `kernel_$_vector_add`.
export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&vector_add);
}
