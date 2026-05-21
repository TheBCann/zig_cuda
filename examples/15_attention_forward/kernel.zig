//! Attention forward pass: one kernel file, three entry points.
//!
//!   scores  = (Q @ K^T) / sqrt(d)       — scores_f32_16
//!   weights = softmax(scores, axis=-1)  — softmax_f32_256
//!   output  = weights @ V               — output_f32_16
//!
//! The host loads one PTX module and grabs three function handles from it.
//! All three commit to f32 + f32 accumulator; the Config knobs from examples
//! 12-14 are dropped here for clarity. Tile sizes and block sizes are baked
//! in.

const std = @import("std");

// ════════════════════════════════════════════════════════════════════
//   SHARED HELPERS
// ════════════════════════════════════════════════════════════════════

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

/// e^x via PTX ex2.approx. ~22 bits of precision, plenty for softmax.
inline fn expf32(x: f32) f32 {
    const log2_e: f32 = 1.4426950408889634;
    const scaled = x * log2_e;
    var out: f32 = undefined;
    asm volatile (
        "ex2.approx.f32 %[r], %[v];"
        : [r] "=f" (out),
        : [v] "f" (scaled),
    );
    return out;
}

/// Warp-shuffle-down. Returns lane (current_lane + offset)'s value of `val`.
inline fn shuffleDownF32(val: f32, offset: u32) f32 {
    var out: f32 = undefined;
    asm volatile (
        "shfl.sync.down.b32 %[r], %[v], %[o], 0x1f, 0xffffffff;"
        : [r] "=f" (out),
        : [v] "f" (val),
          [o] "r" (offset),
    );
    return out;
}

fn maxF32(a: f32, b: f32) f32 {
    return if (a > b) a else b;
}

fn addF32(a: f32, b: f32) f32 {
    return a + b;
}

/// Reduce 32 lanes of a warp to one value via 5 shuffles. The `combine`
/// function is comptime-known so the inline-while unrolls into 5
/// straight-line shuffle instructions.
inline fn warpReduce(
    comptime combine: fn (f32, f32) f32,
    val: f32,
) f32 {
    var v = val;
    comptime var offset: u32 = 16;
    inline while (offset > 0) : (offset /= 2) {
        v = combine(v, shuffleDownF32(v, offset));
    }
    return v;
}

/// Reduce all threads in a block via warp-shuffle + shared-memory fanout.
/// `block_size` must be a power of 2 and a multiple of 32. `identity` is
/// the identity element of `combine` (0 for sum, -inf for max).
inline fn blockReduce(
    comptime block_size: u32,
    comptime combine: fn (f32, f32) f32,
    comptime identity: f32,
    tid: u32,
    val: f32,
) f32 {
    var v = warpReduce(combine, val);

    const num_warps = block_size / 32;
    const shared = struct {
        var partials: [num_warps]f32 addrspace(.shared) = undefined;
    };

    const warp_id = tid / 32;
    const lane_id = tid % 32;

    if (lane_id == 0) shared.partials[warp_id] = v;
    syncBlock();

    if (warp_id == 0) {
        v = if (lane_id < num_warps) shared.partials[lane_id] else identity;
        v = warpReduce(combine, v);
    }

    return v;
}

// ════════════════════════════════════════════════════════════════════
//   SCORES:  scores = (Q @ K^T) / sqrt(d)
// ════════════════════════════════════════════════════════════════════

pub fn scores_f32_16(
    N: u32,
    d: u32,
    inv_sqrt_d: f32,
    q: [*]addrspace(.global) const f32,
    k: [*]addrspace(.global) const f32,
    scores: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    const TILE: u32 = 16;
    const MAX_D: u32 = 128; // compile-time upper bound for shared-mem sizing

    const bx: u32 = @intCast(@workGroupId(0));
    const by: u32 = @intCast(@workGroupId(1));
    const tx: u32 = @intCast(@workItemId(0));
    const ty: u32 = @intCast(@workItemId(1));

    const shared = struct {
        var Qs: [TILE][MAX_D]f32 addrspace(.shared) = undefined;
        // Ks is stored TRANSPOSED: Ks[k][tx] = K[bx*TILE + tx][k]
        var Ks: [MAX_D][TILE]f32 addrspace(.shared) = undefined;
    };

    const q_row = by * TILE + ty;
    const k_row = bx * TILE + tx;

    const linear_tid = ty * TILE + tx;
    const threads_per_block = TILE * TILE;

    // Load Q tile: shape (TILE, d), natural layout
    var i: u32 = linear_tid;
    while (i < TILE * d) : (i += threads_per_block) {
        const row = i / d;
        const col = i % d;
        const global_row = by * TILE + row;
        const val = if (global_row < N and col < d)
            q[global_row * d + col]
        else
            0;
        shared.Qs[row][col] = val;
    }

    // Load K tile, TRANSPOSED into shared memory.
    var j: u32 = linear_tid;
    while (j < TILE * d) : (j += threads_per_block) {
        const row = j / d;
        const col = j % d;
        const global_row = bx * TILE + row;
        const val = if (global_row < N and col < d)
            k[global_row * d + col]
        else
            0;
        shared.Ks[col][row] = val;
    }

    syncBlock();

    var acc: f32 = 0;
    var kk: u32 = 0;
    while (kk < d) : (kk += 1) {
        acc = @mulAdd(f32, shared.Qs[ty][kk], shared.Ks[kk][tx], acc);
    }

    if (q_row < N and k_row < N) {
        scores[q_row * N + k_row] = acc * inv_sqrt_d;
    }
}

// ════════════════════════════════════════════════════════════════════
//   SOFTMAX:  weights = softmax(scores, axis=-1)
// ════════════════════════════════════════════════════════════════════

pub fn softmax_f32_256(
    N: u32,
    input: [*]addrspace(.global) const f32,
    output: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    const BLOCK: u32 = 256;

    const row: u32 = @intCast(@workGroupId(0));
    const tid: u32 = @intCast(@workItemId(0));

    const elements_per_thread = (N + BLOCK - 1) / BLOCK;
    const row_base = row * N;

    // ── Pass 1: find row max ─────────────────────────────────────────
    var local_max: f32 = -std.math.inf(f32);
    var i: u32 = 0;
    while (i < elements_per_thread) : (i += 1) {
        const col = tid + i * BLOCK;
        if (col < N) {
            const x = input[row_base + col];
            if (x > local_max) local_max = x;
        }
    }

    const row_max = blockReduce(BLOCK, maxF32, -std.math.inf(f32), tid, local_max);

    // Broadcast row_max to all threads.
    const broadcast = struct {
        var value: f32 addrspace(.shared) = undefined;
    };
    if (tid == 0) broadcast.value = row_max;
    syncBlock();
    const max_val = broadcast.value;

    // ── Pass 2: compute exp(x - max) and sum ─────────────────────────
    var local_sum: f32 = 0;
    var j: u32 = 0;
    while (j < elements_per_thread) : (j += 1) {
        const col = tid + j * BLOCK;
        if (col < N) {
            const e = expf32(input[row_base + col] - max_val);
            output[row_base + col] = e;
            local_sum += e;
        }
    }

    const row_sum = blockReduce(BLOCK, addF32, 0.0, tid, local_sum);

    if (tid == 0) broadcast.value = row_sum;
    syncBlock();
    const sum_val = broadcast.value;

    // ── Pass 3: divide each element by the sum ───────────────────────
    const inv_sum: f32 = 1.0 / sum_val;
    var k: u32 = 0;
    while (k < elements_per_thread) : (k += 1) {
        const col = tid + k * BLOCK;
        if (col < N) {
            output[row_base + col] *= inv_sum;
        }
    }
}

// ════════════════════════════════════════════════════════════════════
//   OUTPUT:  output = weights @ V
// ════════════════════════════════════════════════════════════════════

pub fn output_f32_16(
    N: u32,
    d: u32,
    weights: [*]addrspace(.global) const f32,
    v: [*]addrspace(.global) const f32,
    output: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    const TILE: u32 = 16;
    const TILE_K: u32 = 16;

    const bx: u32 = @intCast(@workGroupId(0));
    const by: u32 = @intCast(@workGroupId(1));
    const tx: u32 = @intCast(@workItemId(0));
    const ty: u32 = @intCast(@workItemId(1));

    const shared = struct {
        var Ws: [TILE][TILE_K]f32 addrspace(.shared) = undefined;
        var Vs: [TILE_K][TILE]f32 addrspace(.shared) = undefined;
    };

    const out_row = by * TILE + ty;
    const out_col = bx * TILE + tx;

    var acc: f32 = 0;

    // Walk the contraction axis (= N) in TILE_K-sized slabs.
    var k_tile: u32 = 0;
    while (k_tile < N) : (k_tile += TILE_K) {
        // Load weights tile: shape (TILE, TILE_K)
        {
            const linear_tid = ty * TILE + tx;
            const threads_per_block = TILE * TILE;
            var i: u32 = linear_tid;
            while (i < TILE * TILE_K) : (i += threads_per_block) {
                const row = i / TILE_K;
                const col = i % TILE_K;
                const g_row = by * TILE + row;
                const g_col = k_tile + col;
                const val = if (g_row < N and g_col < N)
                    weights[g_row * N + g_col]
                else
                    0;
                shared.Ws[row][col] = val;
            }
        }

        // Load V tile: shape (TILE_K, TILE)
        {
            const linear_tid = ty * TILE + tx;
            const threads_per_block = TILE * TILE;
            var i: u32 = linear_tid;
            while (i < TILE_K * TILE) : (i += threads_per_block) {
                const row = i / TILE;
                const col = i % TILE;
                const g_row = k_tile + row;
                const g_col = bx * TILE + col;
                const val = if (g_row < N and g_col < d)
                    v[g_row * d + g_col]
                else
                    0;
                shared.Vs[row][col] = val;
            }
        }

        syncBlock();

        var kk: u32 = 0;
        while (kk < TILE_K) : (kk += 1) {
            acc = @mulAdd(f32, shared.Ws[ty][kk], shared.Vs[kk][tx], acc);
        }

        syncBlock();
    }

    if (out_row < N and out_col < d) {
        output[out_row * d + out_col] = acc;
    }
}

// ════════════════════════════════════════════════════════════════════
//   Multi-kernel DCE survival
// ════════════════════════════════════════════════════════════════════

export fn __dummy_force_emit(i: usize) *const anyopaque {
    const ptrs = [_]*const anyopaque{
        @ptrCast(&scores_f32_16),
        @ptrCast(&softmax_f32_256),
        @ptrCast(&output_f32_16),
    };
    return ptrs[i % 3];
}
