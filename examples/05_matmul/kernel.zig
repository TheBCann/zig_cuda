//! Tiled matrix multiplication: C = A × B
//!
//! Shapes: A (M×K), B (K×N), C (M×N). For this example M=K=N=1024.
//! All matrices are stored row-major in global memory.
//!
//! Why tiling: a naive kernel reads 2K floats from global memory per
//! output cell, so M·N·2K = 2N³ global loads for square matmul. At
//! N=1024 that's 2 billion reads — memory-bound. With tiling, threads
//! in a block cooperatively load TILE×TILE chunks into shared memory
//! and reuse each loaded value TILE times, cutting global reads by a
//! factor of TILE.
//!
//! Algorithm:
//!   For each output tile (one per block):
//!     accumulator = 0
//!     For each step along K, in TILE-sized chunks:
//!       Each thread cooperatively loads one A element + one B element
//!         into shared memory
//!       Barrier (so all loads are visible to all threads)
//!       Each thread accumulates TILE multiply-adds from shared memory
//!       Barrier (so no thread overwrites tiles still being read)
//!     Write accumulator to global C

const TILE: u32 = 16;

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

pub fn matmul(
    M: u32,
    N: u32,
    K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    const shared = struct {
        var tileA: [TILE][TILE]f32 addrspace(.shared) = undefined;
        var tileB: [TILE][TILE]f32 addrspace(.shared) = undefined;
    };

    const tx: u32 = @intCast(@workItemId(0)); // column within tile
    const ty: u32 = @intCast(@workItemId(1)); // row within tile
    const bx: u32 = @intCast(@workGroupId(0));
    const by: u32 = @intCast(@workGroupId(1));

    // Output cell this thread is responsible for.
    const row = by * TILE + ty;
    const col = bx * TILE + tx;

    var acc: f32 = 0.0;

    // Walk the K dimension TILE elements at a time.
    const num_tiles = (K + TILE - 1) / TILE;
    var t: u32 = 0;
    while (t < num_tiles) : (t += 1) {
        // ── Cooperative load of one A tile and one B tile ────────────
        // Each thread loads exactly one element of each.
        // A's tile spans rows [by*TILE .. by*TILE+TILE), cols [t*TILE .. t*TILE+TILE)
        // B's tile spans rows [t*TILE .. t*TILE+TILE),  cols [bx*TILE .. bx*TILE+TILE)
        const a_col = t * TILE + tx;
        const b_row = t * TILE + ty;

        shared.tileA[ty][tx] = if (row < M and a_col < K) A[row * K + a_col] else 0.0;
        shared.tileB[ty][tx] = if (b_row < K and col < N) B[b_row * N + col] else 0.0;

        syncBlock();

        // ── Compute TILE multiply-adds using only shared memory ──────
        // Inside this loop, all data lives in fast on-chip memory.
        var k: u32 = 0;
        while (k < TILE) : (k += 1) {
            acc += shared.tileA[ty][k] * shared.tileB[k][tx];
        }

        syncBlock();
    }

    // Write result. Guard for non-divisible cases (irrelevant when
    // M, N, K are multiples of TILE, but cheap insurance).
    if (row < M and col < N) {
        C[row * N + col] = acc;
    }
}

// See examples/01_vector_add/kernel.zig for why this dummy export is needed.
export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&matmul);
}
