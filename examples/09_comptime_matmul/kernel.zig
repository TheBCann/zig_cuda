//! Comptime-parameterized tiled matmul.
//!
//! Demonstrates Zig's `comptime` generating multiple specialized PTX
//! entry points from one source. Each named kernel below is a distinct
//! .entry, with tile dimensions, element type, and accumulator type
//! baked in as immediates.
//!
//! Comptime advantages over CUDA C++ templates:
//!   - Tile dimensions, element type, and accumulator type all validated
//!     at compile time via @compileError with descriptive messages.
//!     Invalid configs (e.g. f32 inputs with f16 accumulator) are
//!     rejected at build time.
//!   - The validation logic is arbitrary Zig, not a constrained
//!     template-metaprogramming sub-language.
//!   - No separate template instantiation phase. Everything is just Zig.

const std = @import("std");

pub const Config = struct {
    /// Input and output element type.
    T: type,
    /// Accumulator type. f32 is the standard choice even with f16 inputs -
    /// summing many f16 products in f16 quickly loses precision.
    accum: type = f32,
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
            @compileError("only f32 and f16 supported for accum (passed " ++ @typeName(self.accum) ++ ")");

        if (self.accum != f32 and self.accum != f16)
            @compileError("only f32 and f16 supported for T (passed " ++ @typeName(self.T) ++ ")");

        if (self.T == f32 and self.accum == f16)
            @compileError("accumulating to f16 with f32 inputs loses precision; use accum = f32");
    }
};

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

/// Identity-or-cast float helper. Zig's @floatCast doesn't accept same-type
/// casts in all versions, so we branch at comptime.
inline fn castFloat(comptime To: type, val: anytype) To {
    if (@TypeOf(val) == To) return val;
    return @floatCast(val);
}

/// Generic tiled matmul. `inline fn` so each caller inherits a fully
/// specialized copy, with all tile sizes and types baked as immediates.
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
    const AccumT = cfg.accum;
    const TILE = cfg.tile_m;

    // Shared memory uses T (the smaller type when inputs are f16),
    // saving on-chip memory and matching the actual data type loaded.
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

    var acc: AccumT = 0;

    const num_tiles = (K + TILE - 1) / TILE;
    var t: u32 = 0;
    while (t < num_tiles) : (t += 1) {
        const a_col = t * TILE + tx;
        const b_row = t * TILE + ty;

        shared.tileA[ty][tx] = if (row < M and a_col < K) A[row * K + a_col] else 0;
        shared.tileB[ty][tx] = if (b_row < K and col < N) B[b_row * N + col] else 0;

        syncBlock();

        // Mixed-precision multiply-accumulate: cast operands up to
        // AccumT before multiplying. For f32->f32 the cast is a no-op
        // (handled by castFloat); for f16->f32 it widens.
        comptime var k: u32 = 0;
        inline while (k < TILE) : (k += 1) {
            const a_val = castFloat(AccumT, shared.tileA[ty][k]);
            const b_val = castFloat(AccumT, shared.tileB[k][tx]);
            acc += a_val * b_val;
        }

        syncBlock();
    }

    if (row < M and col < N) {
        // Cast accumulator back down to T for the output store.
        C[row * N + col] = castFloat(T, acc);
    }
}

// ─── Named instantiations ────────────────────────────────────────────────

pub fn matmul_f32_8x8(
    M: u32, N: u32, K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    matmulBody(.{
        .T = f32,
        .tile_m = 8,
        .tile_n = 8,
        .tile_k = 8 },
        M, N, K, A, B, C
    );
}

pub fn matmul_f32_16x16(
    M: u32, N: u32, K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    matmulBody(.{
        .T = f32,
        .tile_m = 16,
        .tile_n = 16,
        .tile_k = 16 },
        M, N, K, A, B, C
    );
}

pub fn matmul_f32_32x32(
    M: u32, N: u32, K: u32,
    A: [*]addrspace(.global) const f32,
    B: [*]addrspace(.global) const f32,
    C: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    matmulBody(.{
        .T = f32,
        .tile_m = 32,
        .tile_n = 32,
        .tile_k = 32 },
        M, N, K, A, B, C
    );
}

/// f16 inputs/outputs with f32 accumulator — the standard mixed-precision
/// pattern used by cuBLAS, CUTLASS, and PyTorch. The accumulator type is
/// chosen at compile time; the @compileError in Config.validate prevents
/// degenerate combinations like f32 inputs + f16 accumulator.
pub fn matmul_f16_16x16(
    M: u32, N: u32, K: u32,
    A: [*]addrspace(.global) const f16,
    B: [*]addrspace(.global) const f16,
    C: [*]addrspace(.global) f16,
) callconv(.kernel) void {
    matmulBody(.{
        .T = f16,
        .tile_m = 16,
        .tile_n = 16,
        .tile_k = 16 },
        M, N, K, A, B, C
    );
}

// Runtime-parameterized to keep the optimizer from proving any pointer
// unused. Forces all four kernels to survive DCE.
export fn __dummy_force_emit(i: usize) *const anyopaque {
    const ptrs = [_]*const anyopaque{
        @ptrCast(&matmul_f32_8x8),
        @ptrCast(&matmul_f32_16x16),
        @ptrCast(&matmul_f32_32x32),
        @ptrCast(&matmul_f16_16x16),
    };
    return ptrs[i % 4];
}
