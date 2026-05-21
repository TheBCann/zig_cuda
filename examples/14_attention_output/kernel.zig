//! Attention output: output = weights @ V
//!
//! weights: (N, N) — softmax output, each row sums to 1
//! V:       (N, d) — value matrix
//! output:  (N, d) — final attention output per query token
//!
//! Plain tiled matmul. Contraction axis is N (sequence length), tiled
//! along K-direction in shared memory just like example 05.

const std = @import("std");

pub const Config = struct {
    T: type = f32,
    accum: type = f32,
    /// Output tile size per block. Block is (tile, tile) threads.
    tile: u32 = 16,
    /// Tile size along the contraction (N) dimension. Loaded into
    /// shared memory each iteration of the outer loop.
    tile_k: u32 = 16,

    pub fn validate(comptime self: Config) void {
        if (self.tile == 0 or self.tile > 32)
            @compileError("tile must be in (0, 32]");
        if (self.tile_k == 0 or self.tile_k > 64)
            @compileError("tile_k must be in (0, 64]");
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

inline fn outputBody(
    comptime cfg: Config,
    N: u32, // sequence length (rows of weights and V, rows of output)
    d: u32, // head dimension (cols of V and output)
    weights: [*]addrspace(.global) const cfg.T,
    v: [*]addrspace(.global) const cfg.T,
    output: [*]addrspace(.global) cfg.T,
) void {
    comptime cfg.validate();

    const T = cfg.T;
    const AccumT = cfg.accum;
    const TILE = cfg.tile;
    const TILE_K = cfg.tile_k;

    const bx: u32 = @intCast(@workGroupId(0)); // tile column = output col range
    const by: u32 = @intCast(@workGroupId(1)); // tile row    = output row range
    const tx: u32 = @intCast(@workItemId(0));
    const ty: u32 = @intCast(@workItemId(1));

    const shared = struct {
        var Ws: [TILE][TILE_K]AccumT addrspace(.shared) = undefined;
        var Vs: [TILE_K][TILE]AccumT addrspace(.shared) = undefined;
    };

    const out_row = by * TILE + ty;
    const out_col = bx * TILE + tx;

    var acc: AccumT = 0;

    // Walk along the K dimension (= N), one TILE_K-wide slab at a time.
    var k_tile: u32 = 0;
    while (k_tile < N) : (k_tile += TILE_K) {
        // Cooperative load of the weights tile: shape (TILE, TILE_K).
        // Each thread loads one element if (ty, tx) is in range.
        // Block has TILE*TILE threads; weights tile has TILE*TILE_K elements.
        // For TILE=16, TILE_K=16: 256 threads, 256 elements — exactly one each.
        // General formula handles TILE_K != TILE too.
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
                    castFloat(AccumT, weights[g_row * N + g_col])
                else
                    0;
                shared.Ws[row][col] = val;
            }
        }

        // Cooperative load of the V tile: shape (TILE_K, TILE).
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
                    castFloat(AccumT, v[g_row * d + g_col])
                else
                    0;
                shared.Vs[row][col] = val;
            }
        }

        syncBlock();

        // Compute: each thread accumulates one output element.
        //   acc += sum_k Ws[ty][k] * Vs[k][tx]
        var kk: u32 = 0;
        while (kk < TILE_K) : (kk += 1) {
            acc = @mulAdd(AccumT, shared.Ws[ty][kk], shared.Vs[kk][tx], acc);
        }

        syncBlock();
    }

    if (out_row < N and out_col < d) {
        output[out_row * d + out_col] = castFloat(T, acc);
    }
}

// ─── Named instantiation ───────────────────────────────────────────────

pub fn output_f32_16(
    N: u32,
    d: u32,
    weights: [*]addrspace(.global) const f32,
    v: [*]addrspace(.global) const f32,
    output: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    outputBody(.{ .T = f32, .accum = f32, .tile = 16, .tile_k = 16 }, N, d, weights, v, output);
}

export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&output_f32_16);
}
