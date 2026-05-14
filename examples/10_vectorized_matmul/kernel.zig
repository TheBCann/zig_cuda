//! Vectorized matmul: same algorithm as example 05, but cooperative loads
//! use ld.global.v2.f32 inline PTX to load 2 f32s per instruction.
//! 16×16 output tile, K-tile width doubled to 32 to absorb the 2× load width.

const std = @import("std");

const TILE_M: u32 = 16;
const TILE_N: u32 = 16;
const TILE_K: u32 = 32; // doubled — each thread loads 2 elements per tile iteration

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

/// Vectorized v2.f32 load from global memory. `ptr` must be 8-byte aligned.
/// Returns two adjacent f32 values starting at `ptr[0]` and `ptr[1]`.
inline fn loadV2(ptr: [*]addrspace(.global) const f32) struct { f32, f32 } {
    var v0: f32 = undefined;
    var v1: f32 = undefined;
    asm volatile (
        "ld.global.v2.f32 {%[r0], %[r1]}, [%[p]];"
        : [r0] "=r" (v0),
          [r1] "=r" (v1),
        : [p] "l" (ptr),
        : .{ .memory = true });
    return .{ v0, v1 };
}

pub fn matmul_vec(
    M: u32,
    N: u32,
    K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    const shared = struct {
        var tileA: [TILE_M][TILE_K]f32 addrspace(.shared) = undefined;
        var tileB: [TILE_K][TILE_N]f32 addrspace(.shared) = undefined;
    };

    const tx: u32 = @intCast(@workItemId(0));
    const ty: u32 = @intCast(@workItemId(1));
    const bx: u32 = @intCast(@workGroupId(0));
    const by: u32 = @intCast(@workGroupId(1));

    const row = by * TILE_M + ty;
    const col = bx * TILE_N + tx;

    var acc: f32 = 0;

    const num_tiles = (K + TILE_K - 1) / TILE_K;
    var t: u32 = 0;
    while (t < num_tiles) : (t += 1) {
        const k_base = t * TILE_K;

        // ── Cooperative load of A: 16×32 region, each thread loads 2 elements ──
        // Thread (ty, tx) loads A[row][k_base + 2*tx] and A[row][k_base + 2*tx + 1]
        const a_col0 = k_base + 2 * tx;
        const a_col1 = a_col0 + 1;
        if (row < M and a_col1 < K) {
            const a_ptr: [*]addrspace(.global) const f32 = A + (row * K + a_col0);
            const a0, const a1 = loadV2(a_ptr);
            shared.tileA[ty][2 * tx] = a0;
            shared.tileA[ty][2 * tx + 1] = a1;
        } else {
            // Edge case: fall back to scalar loads with bounds checks
            shared.tileA[ty][2 * tx] = if (row < M and a_col0 < K) A[row * K + a_col0] else 0;
            shared.tileA[ty][2 * tx + 1] = if (row < M and a_col1 < K) A[row * K + a_col1] else 0;
        }

        // ── Cooperative load of B: 32×16 region, each thread loads 2 elements ──
        // Thread (ty, tx) loads B[k_base + 2*ty][col] and B[k_base + 2*ty + 1][col]
        const b_row0 = k_base + 2 * ty;
        const b_row1 = b_row0 + 1;
        if (b_row1 < K and col < N) {
            // Note: this is a strided load (column-direction in B), so v2 doesn't help.
            // We do two scalar loads here. Vectorizing B's load would require a
            // transposed layout — left as a future optimization.
            shared.tileB[2 * ty][tx] = B[b_row0 * N + col];
            shared.tileB[2 * ty + 1][tx] = B[b_row1 * N + col];
        } else {
            shared.tileB[2 * ty][tx] = if (b_row0 < K and col < N) B[b_row0 * N + col] else 0;
            shared.tileB[2 * ty + 1][tx] = if (b_row1 < K and col < N) B[b_row1 * N + col] else 0;
        }

        syncBlock();

        // ── Inner product over K=32 ──
        comptime var k: u32 = 0;
        inline while (k < TILE_K) : (k += 1) {
            acc += shared.tileA[ty][k] * shared.tileB[k][tx];
        }

        syncBlock();
    }

    if (row < M and col < N) {
        C[row * N + col] = acc;
    }
}

export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&matmul_vec);
}
