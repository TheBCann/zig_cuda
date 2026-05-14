//! Register-blocked matmul: each thread computes a 4×4 tile of C in registers.
//! Block tile: 64×64. Threads per block: 16×16 = 256. Each thread does 16 FMAs
//! per inner-loop iteration instead of 1, dramatically improving the compute-
//! to-shared-memory-load ratio.

const std = @import("std");

// Output tile per block.
const BM: u32 = 64;
const BN: u32 = 64;
// K-direction tile (shared across all threads in a block).
const BK: u32 = 16;
// Output tile per thread (held in registers).
const TM: u32 = 4;
const TN: u32 = 4;

// Threads per block: (BM / TM) × (BN / TN) = 16 × 16 = 256.
const THREADS_X: u32 = BN / TN; // 16
const THREADS_Y: u32 = BM / TM; // 16

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

pub fn matmul_reg(
    M: u32,
    N: u32,
    K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    const shared = struct {
        var tileA: [BM][BK]f32 addrspace(.shared) = undefined;
        var tileB: [BK][BN]f32 addrspace(.shared) = undefined;
    };

    const tx: u32 = @intCast(@workItemId(0));
    const ty: u32 = @intCast(@workItemId(1));
    const bx: u32 = @intCast(@workGroupId(0));
    const by: u32 = @intCast(@workGroupId(1));

    // Linear thread index for the cooperative load.
    const tid: u32 = ty * THREADS_X + tx;

    // The 4×4 output region this thread owns within the block's 64×64 tile.
    const thread_row_base = ty * TM; // row offset within block tile
    const thread_col_base = tx * TN; // col offset within block tile

    // Global coordinates of this thread's output region.
    const c_row_base = by * BM + thread_row_base;
    const c_col_base = bx * BN + thread_col_base;

    // Per-thread register-resident accumulator: 4×4 = 16 f32 values.
    var acc: [TM][TN]f32 = @splat(@splat(0.0));

    const num_k_tiles = (K + BK - 1) / BK;
    var t: u32 = 0;
    while (t < num_k_tiles) : (t += 1) {
        const k_base = t * BK;

        // ── Cooperative load of A (64×16 = 1024 elements, 256 threads × 4 each) ──
        // Thread `tid` loads elements 4*tid through 4*tid + 3 (linearized).
        comptime var i: u32 = 0;
        inline while (i < 4) : (i += 1) {
            const idx = tid * 4 + i;
            const a_row = idx / BK; // 0..63
            const a_col = idx % BK; // 0..15

            const g_row = by * BM + a_row;
            const g_col = k_base + a_col;
            shared.tileA[a_row][a_col] =
                if (g_row < M and g_col < K) A[g_row * K + g_col] else 0;
        }

        // ── Cooperative load of B (16×64 = 1024 elements) ──
        comptime var j: u32 = 0;
        inline while (j < 4) : (j += 1) {
            const idx = tid * 4 + j;
            const b_row = idx / BN; // 0..15
            const b_col = idx % BN; // 0..63

            const g_row = k_base + b_row;
            const g_col = bx * BN + b_col;
            shared.tileB[b_row][b_col] =
                if (g_row < K and g_col < N) B[g_row * N + g_col] else 0;
        }

        syncBlock();

        // ── Inner product: 16 K iterations, each does 16 FMAs ──
        // For each k in 0..BK:
        //   Load 4 values of A column (one per row of this thread's tile)
        //   Load 4 values of B row (one per col of this thread's tile)
        //   Do 16 FMAs into the 4×4 accumulator
        comptime var k: u32 = 0;
        inline while (k < BK) : (k += 1) {
            // Fetch the 4 A values and 4 B values for this k.
            var a_frag: [TM]f32 = undefined;
            var b_frag: [TN]f32 = undefined;

            comptime var m: u32 = 0;
            inline while (m < TM) : (m += 1) {
                a_frag[m] = shared.tileA[thread_row_base + m][k];
            }

            comptime var n: u32 = 0;
            inline while (n < TN) : (n += 1) {
                b_frag[n] = shared.tileB[k][thread_col_base + n];
            }

            // 16 FMAs.
            comptime var mm: u32 = 0;
            inline while (mm < TM) : (mm += 1) {
                comptime var nn: u32 = 0;
                inline while (nn < TN) : (nn += 1) {
                    acc[mm][nn] = @mulAdd(f32, a_frag[mm], b_frag[nn], acc[mm][nn]);
                }
            }
        }

        syncBlock();
    }

    // ── Write the 4×4 accumulator out to C ──
    comptime var m: u32 = 0;
    inline while (m < TM) : (m += 1) {
        comptime var n: u32 = 0;
        inline while (n < TN) : (n += 1) {
            const r = c_row_base + m;
            const c = c_col_base + n;
            if (r < M and c < N) {
                C[r * N + c] = acc[m][n];
            }
        }
    }
}

export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&matmul_reg);
}
