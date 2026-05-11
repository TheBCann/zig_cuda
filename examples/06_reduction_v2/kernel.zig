//! Reduction v2: halve threads, double loads at boundary.
//!
//! In v1, each block had 256 threads, each loading one element of input.
//! After the first reduction step (stride=128), threads 128-255 were
//! idle for the rest of the kernel — half the launched threads doing
//! nothing.
//!
//! v2 launches half as many threads per "unit of work": each thread
//! loads TWO elements from global memory and adds them together at load
//! time. A block of 256 threads now consumes 512 input elements (instead
//! of 256), so we launch num_blocks/2 blocks overall.
//!
//! Effects:
//!   - Half the kernel launches → less launch overhead
//!   - First reduction step folded into the load → one less syncBlock
//!     and one less shared-memory pass
//!   - Higher arithmetic intensity per thread (more work per launch)
//!
//! Same tree reduction afterward. Same shared memory size. Same
//! correctness check (sum == N).

const BLOCK_SIZE: u32 = 256;

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

pub fn block_sum(
    n: u32,
    input: [*]addrspace(.global) const f32,
    partials: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    const shared = struct {
        var data: [BLOCK_SIZE]f32 addrspace(.shared) = undefined;
    };

    const tid: u32 = @intCast(@workItemId(0));
    const bid: u32 = @intCast(@workGroupId(0));

    // Each block covers 2 * BLOCK_SIZE elements now.
    // Each thread loads TWO elements (one from the first half of the
    // block's range, one from the second half) and adds them.
    const base = bid * BLOCK_SIZE * 2;
    const idx_a = base + tid;
    const idx_b = base + tid + BLOCK_SIZE;

    const a: f32 = if (idx_a < n) input[idx_a] else 0.0;
    const b: f32 = if (idx_b < n) input[idx_b] else 0.0;
    shared.data[tid] = a + b;
    syncBlock();

    // Tree reduction. Same pattern as v1 (sequential addressing, no
    // bank conflicts), just operating on already-half-reduced data.
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
