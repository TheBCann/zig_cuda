//! Reduction v3: warp-shuffle reduction (Mark Harris pass 4, modernized).
//!
//! Builds on v2 (halve threads, double loads). The tree reduction in v2
//! used shared memory for every step: write → barrier → read → add. Each
//! step took ~60 cycles for the shared-memory round-trip plus the barrier.
//!
//! v3 replaces the in-warp portion of the reduction with `shfl.sync.down.b32`,
//! a warp-level register-to-register exchange. Single cycle per step, no
//! barriers, no shared memory.
//!
//! Two phases:
//!   A. Within each warp: 5 shfl.down rounds collapse 32 values to 1.
//!   B. Across warps: each warp's thread 0 writes to shared memory, then
//!      warp 0 does another shuffle reduction on those (BLOCK_SIZE/32) values.
//!
//! Result: shared memory traffic drops from BLOCK_SIZE per step × log2(BLOCK_SIZE)
//! steps to just BLOCK_SIZE/32 values written and read once. Barriers drop
//! from 8 per block to 1.

const BLOCK_SIZE: u32 = 256;
const WARP_SIZE: u32 = 32;
const NUM_WARPS: u32 = BLOCK_SIZE / WARP_SIZE; // 8

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

/// Warp-level shuffle: each thread `t` receives the value held by thread
/// `t + offset` within its warp. Threads with `t + offset >= 32` keep
/// their original value (the "down" boundary behavior).
///
/// PTX: shfl.sync.down.b32 — single cycle, no shared memory, no barriers.
/// The mask 0xffffffff means all 32 threads in the warp participate.
inline fn shflDown(val: f32, offset: u32) f32 {
    const in_bits: u32 = @bitCast(val);
    var out_bits: u32 = undefined;
    asm volatile (
        \\shfl.sync.down.b32 %[out], %[in], %[off], 31, 0xffffffff;
        : [out] "=r" (out_bits),
        : [in] "r" (in_bits),
          [off] "r" (offset),
    );
    return @bitCast(out_bits);
}

/// Reduce a single warp's 32 thread-local values to one (held by thread
/// 0 of the warp). All 32 threads must call this.
inline fn warpReduceSum(initial: f32) f32 {
    var v = initial;
    v += shflDown(v, 16);
    v += shflDown(v, 8);
    v += shflDown(v, 4);
    v += shflDown(v, 2);
    v += shflDown(v, 1);
    return v;
}

pub fn block_sum(
    n: u32,
    input: [*]addrspace(.global) const f32,
    partials: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    // Tiny shared array: one slot per warp. Used only to pass warp
    // partial sums to warp 0 for the final cross-warp reduction.
    const shared = struct {
        var warp_sums: [NUM_WARPS]f32 addrspace(.shared) = undefined;
    };

    const tid: u32 = @intCast(@workItemId(0));
    const bid: u32 = @intCast(@workGroupId(0));
    const lane: u32 = tid % WARP_SIZE;   // position within warp
    const warp: u32 = tid / WARP_SIZE;   // which warp this thread is in

    // ── Load two elements per thread (Pass 3 boundary trick) ─────────
    const base = bid * BLOCK_SIZE * 2;
    const a_idx = base + tid;
    const b_idx = base + tid + BLOCK_SIZE;
    const a: f32 = if (a_idx < n) input[a_idx] else 0.0;
    const b: f32 = if (b_idx < n) input[b_idx] else 0.0;
    var v: f32 = a + b;

    // ── Phase A: reduce within each warp using shuffles ──────────────
    v = warpReduceSum(v);

    // After warpReduceSum, only `lane == 0` of each warp holds the
    // warp's total. Write those to shared memory.
    if (lane == 0) {
        shared.warp_sums[warp] = v;
    }
    syncBlock();

    // ── Phase B: warp 0 reduces the per-warp sums ────────────────────
    // NUM_WARPS = 8 here, so this fits in a single warp.
    // Threads in warp 0 with lane < NUM_WARPS load a partial; others 0.
    if (warp == 0) {
        const warp_val: f32 = if (lane < NUM_WARPS) shared.warp_sums[lane] else 0.0;
        const block_total = warpReduceSum(warp_val);

        if (lane == 0) {
            partials[bid] = block_total;
        }
    }
}

export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&block_sum);
}
