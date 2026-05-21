//! Attention scores: scores = (Q @ K^T) / sqrt(d)
//!
//! Q: (N, d) — row-major, each row is a query vector
//! K: (N, d) — row-major, each row is a key vector
//! scores: (N, N) — row-major, scores[i][j] = (Q[i] · K[j]) / sqrt(d)
//!
//! K is accessed via transposed shared-memory layout, never materialized
//! as a transposed buffer in global memory.

const std = @import("std");

pub const Config = struct {
    /// Element type for Q, K, and scores.
    T: type = f32,
    /// Accumulator type for the inner-product dot products.
    accum: type = f32,
    /// Output tile size per block. Block is (tile, tile) threads.
    /// Each thread computes one output element. Default 16 = 256 threads/block.
    tile: u32 = 16,

    pub fn validate(comptime self: Config) void {
        if (self.tile == 0 or self.tile > 32)
            @compileError("tile must be in (0, 32]");
        if (self.T != f32 and self.T != f16)
            @compileError("only f32 and f16 supported for T");
        if (self.accum != f32)
            @compileError("only f32 accumulation is supported");
    }
};

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

inline fn castFloat(comptime To: type, val: anytype) To {
    if (@TypeOf(val) == To) return val;
    return @floatCast(val);
}

inline fn scoresBody(
    comptime cfg: Config,
    N: u32, // sequence length (rows of Q, K, and scores)
    d: u32, // head dimension (cols of Q and K)
    inv_sqrt_d: cfg.accum, // 1 / sqrt(d), precomputed on host
    q: [*]addrspace(.global) const cfg.T,
    k: [*]addrspace(.global) const cfg.T,
    scores: [*]addrspace(.global) cfg.T,
) void {
    comptime cfg.validate();

    const T = cfg.T;
    const AccumT = cfg.accum;
    const TILE = cfg.tile;
    const MAX_D = 128; // max supported head dim (compile-time shared mem sizing)

    const bx: u32 = @intCast(@workGroupId(0)); // tile column = key index range
    const by: u32 = @intCast(@workGroupId(1)); // tile row    = query index range
    const tx: u32 = @intCast(@workItemId(0));
    const ty: u32 = @intCast(@workItemId(1));

    // Shared memory:
    //   tile_Q[ty][k] = Q row (by*TILE + ty), element k
    //   tile_K[k][tx] = K row (bx*TILE + tx), element k  (TRANSPOSED)
    const shared = struct {
        var Qs: [TILE][MAX_D]AccumT addrspace(.shared) = undefined;
        var Ks: [MAX_D][TILE]AccumT addrspace(.shared) = undefined;
    };

    const q_row = by * TILE + ty;
    const k_row = bx * TILE + tx;

    // ── Cooperative load: each thread loads (d / TILE) elements ─────
    // Block has TILE×TILE threads. The d-dimension has `d` elements.
    // Each row of Q and K is loaded cooperatively across the TILE threads
    // sharing that row. With TILE=16 and d=64, each thread loads 4 elements.
    const linear_tid = ty * TILE + tx;
    const threads_per_block = TILE * TILE;

    // Load Q tile: TILE rows × d cols = TILE*d elements total
    var i: u32 = linear_tid;
    while (i < TILE * d) : (i += threads_per_block) {
        const row = i / d; // 0 .. TILE-1
        const col = i % d; // 0 .. d-1
        const global_row = by * TILE + row;
        const val = if (global_row < N and col < d)
            castFloat(AccumT, q[global_row * d + col])
        else
            0;
        shared.Qs[row][col] = val;
    }

    // Load K tile, TRANSPOSED into shared memory:
    //   shared.Ks[col][row] = K[bx*TILE + row][col]
    var j: u32 = linear_tid;
    while (j < TILE * d) : (j += threads_per_block) {
        const row = j / d; // 0 .. TILE-1, which K row in this tile
        const col = j % d; // 0 .. d-1,  which element of that K row
        const global_row = bx * TILE + row;
        const val = if (global_row < N and col < d)
            castFloat(AccumT, k[global_row * d + col])
        else
            0;
        shared.Ks[col][row] = val; // <-- transpose happens here
    }

    syncBlock();

    // ── Compute: each thread computes one output element ────────────
    // acc = sum over k of Q[q_row][k] * K[k_row][k]
    //     = sum over k of Qs[ty][k] * Ks[k][tx]   (Ks is transposed)
    var acc: AccumT = 0;
    var kk: u32 = 0;
    while (kk < d) : (kk += 1) {
        acc = @mulAdd(AccumT, shared.Qs[ty][kk], shared.Ks[kk][tx], acc);
    }

    // Scale by 1/sqrt(d) and write out.
    if (q_row < N and k_row < N) {
        scores[q_row * N + k_row] = castFloat(T, acc * inv_sqrt_d);
    }
}

// ─── Named instantiation ───────────────────────────────────────────────

pub fn scores_f32_16(
    N: u32,
    d: u32,
    inv_sqrt_d: f32,
    q: [*]addrspace(.global) const f32,
    k: [*]addrspace(.global) const f32,
    scores: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    scoresBody(
        .{
        .T = f32,
        .accum = f32,
        .tile = 16 
        }, N, d, inv_sqrt_d, q, k, scores);
}

export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&scores_f32_16);
}
