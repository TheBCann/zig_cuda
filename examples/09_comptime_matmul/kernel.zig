//! Comptime-parameterized tiled matmul.
//!
//! Demonstrates Zig's `comptime` generating multiple specialized PTX
//! entry points from one source. Each named kernel below is a distinct
//! .entry, with tile dimensions and element type baked in as immediates.
//!
//! Comptime advantages over CUDA C++ templates:
//!   - Tile dimensions and types validated at compile time via @compileError
//!     with descriptive messages. Invalid configs never produce a kernel.
//!   - The validation logic is arbitrary Zig, not a constrained
//!     template-metaprogramming sub-language.
//!   - No separate template instantiation phase. Everything is just Zig.

const std = @import("std");

pub const Config = struct {
    T: type,
    tile_m: u32,
    tile_n: u32,
    tile_k: u32,

    pub fn validate(comptime self: Config) void {
        if (self.tile_m == 0 or self.tile_n == 0 or self.tile_k == 0)
            @compileError("tile dimensions must be > 0");
        if (self.tile_m * self.tile_n > 1024)
            @compileError("tile_m * tile_n exceeds 1024 threads/block limit");
        if (self.tile_m != self.tile_n or self.tile_n != self.tile_k)
            @compileError("this implementation requires tile_m == tile_n == tile_k " ++
                "(asymmetric tiles need a different cooperative-load pattern)");
        if (self.T != f32 and self.T != f16)
            @compileError("only f32 and f16 supported (passed " ++ @typeName(self.T) ++ ")");
    }
};

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

/// Generic tiled matmul. `inline fn` so each caller inherits a fully
/// specialized copy, with all tile sizes baked as immediates.
inline fn matmulBody(
    comptime cfg: Config,
    M: u32,
    N: u32,
    K: u32,
    A: [*]addrspace(.global) const cfg.T,
    B: [*]addrspace(.global) const cfg.T,
    C: [*]addrspace(.global) cfg.T,
) void {
    comptime cfg.validate();

    const T = cfg.T;
    const TILE = cfg.tile_m;

    const shared = struct {
        var tileA: [TILE][TILE]T addrspace(.shared) = undefined;
        var tileB: [TILE][TILE]T addrspace(.shared) = undefined;
    };

    const tx: u32 = @intCast(@workItemId(0));
    const ty: u32 = @intCast(@workItemId(1));
    const bx: u32 = @intCast(@workGroupId(0));
    const by: u32 = @intCast(@workGroupId(1));

    const row = by * TILE + ty;
    const col = bx * TILE + tx;

    var acc: T = 0;

    const num_tiles = (K + TILE - 1) / TILE;
    var t: u32 = 0;
    while (t < num_tiles) : (t += 1) {
        const a_col = t * TILE + tx;
        const b_row = t * TILE + ty;

        shared.tileA[ty][tx] = if (row < M and a_col < K) A[row * K + a_col] else 0;
        shared.tileB[ty][tx] = if (b_row < K and col < N) B[b_row * N + col] else 0;

        syncBlock();

        comptime var k: u32 = 0;
        inline while (k < TILE) : (k += 1) {
            acc += shared.tileA[ty][k] * shared.tileB[k][tx];
        }

        syncBlock();
    }

    if (row < M and col < N) {
        C[row * N + col] = acc;
    }
}

// ─── Named instantiations (square tiles only) ────────────────────────────

/// 8×8×8 — 64 threads per block, small but high-occupancy.
pub fn matmul_f32_8x8(
    M: u32, N: u32, K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    matmulBody(.{ .T = f32, .tile_m = 8, .tile_n = 8, .tile_k = 8 }, M, N, K, A, B, C);
}

/// 16×16×16 — the canonical good-tradeoff size; 256 threads/block.
pub fn matmul_f32_16x16(
    M: u32, N: u32, K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    matmulBody(.{ .T = f32, .tile_m = 16, .tile_n = 16, .tile_k = 16 }, M, N, K, A, B, C);
}

/// 32×32×32 — max threads/block; more shared memory, lower occupancy.
pub fn matmul_f32_32x32(
    M: u32, N: u32, K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    matmulBody(.{ .T = f32, .tile_m = 32, .tile_n = 32, .tile_k = 32 }, M, N, K, A, B, C);
}

// Gemini's trick: the runtime parameter prevents the optimizer from
// proving any pointer unused, forcing all three kernels to survive DCE.
export fn __dummy_force_emit(i: usize) *const anyopaque {
    const ptrs = [_]*const anyopaque{
        @ptrCast(&matmul_f32_8x8),
        @ptrCast(&matmul_f32_16x16),
        @ptrCast(&matmul_f32_32x32),
    };
    return ptrs[i % 3];
}
