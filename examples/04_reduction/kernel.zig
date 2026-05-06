//! Block-level sum redirection
//!
//! Each block reduces BLOCK_SIZE consecutive elements of the input
//! array down to a single partial sum, written to `partials[blockIdx]`.
//!
//! The host launches enough blocks to cover N elements, then sums
//! the per-block partials on the CPU (a few thousand floats; trivial).
//!
//! Algorithm (classic tree reduction inside shared memory)
//!
//!     step 0:  load: shared[tid] = input[global_idx]
//!     Barrier
//!     Step 1:  if tid < 128: shared[tid] += shared[tid + 128]
//!     Barrier
//!     Step 2:  if tid < 64:  shared[tid] += shared[tid + 64]
//!     Barrier
//!     ... continues down to:
//!     Step 8:  if tid < 1:   shared[tid] += shared[tid + 1]
//!     Barrier
//!     Write:   if tid == 0:  partials[blockIdx] = shared[0]
//! Afer log2(BLOCK_SIZE) = 8 steps, shared[0] holds the sum of
//! all 256 elements this block was assigned
const BLOCK_SIZE: u32 = 256;

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{  .memory = true });
}

pub fn block_sum(
    n: u32,
    input: [*]addrspace(.global) const f32,
    partials: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    // Per-block scratch space. Lives in fast on-chip memory; threads
    // in the same block can read/write it. Lifetime = this kernel
    // invocation. this block only.
    const shared = struct {
        var data: [BLOCK_SIZE]f32 addrspace(.shared) = undefined;
    };

    const tid: u32 = @intCast(@workItemId(0));
    const bid: u32 = @intCast(@workGroupId(0));
    const global_idx = bid * BLOCK_SIZE + tid;

    // -- Phase 1: Load ────────────────────────────────────────────────
    // Each thread loads its element. Out-of-bounds threads load 0,
    // so partial blocks at the tail still compute a correct sum.
    shared.data[tid] = if (global_idx < n) input[global_idx] else 0.0;
    syncBlock();

    var stride: u32 = BLOCK_SIZE / 2;
    while (stride > 0) : (stride /= 2) {
        if (tid < stride) {
            shared.data[tid] += shared.data[tid + stride];
        }
        syncBlock();
    }

    if (tid == 0) {
        partials[bid] = shared.data[0];
    }
}

export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&block_sum);
}
