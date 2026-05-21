//! Row-wise numerically stable softmax.
//!
//! For an (N, N) input matrix, computes softmax along axis=1 (per row):
//!   row_max  = max(row)
//!   row_exp  = exp(row - row_max)
//!   row_sum  = sum(row_exp)
//!   output   = row_exp / row_sum
//!
//! The max-subtraction prevents overflow in exp() for large inputs.

const std = @import("std");

pub const Config = struct {
    /// Element type for input/output.
    T: type = f32,
    /// Accumulator type for the reductions. f32 is the standard choice
    /// even for f16 inputs; reductions over many elements lose precision
    /// rapidly without higher-precision accumulation.
    accum: type = f32,
    /// Threads per block. Must be a power of 2 and ≤ 1024.
    /// Each thread handles row_width / block_size elements.
    block_size: u32 = 256,

    pub fn validate(comptime self: Config) void {
        if (self.block_size == 0 or self.block_size > 1024)
            @compileError("block_size must be in (0, 1024]");
        if (!std.math.isPowerOfTwo(self.block_size))
            @compileError("block_size must be a power of 2 (warp-shuffle reduction depends on it)");
        if (self.T != f32 and self.T != f16)
            @compileError("only f32 and f16 supported for T");
        if (self.accum != f32 and self.accum != f16)
            @compileError("only f32 and f16 supported for accum");
        if (self.T == f32 and self.accum == f16)
            @compileError("accumulating to f16 with f32 inputs loses precision");
    }
};

inline fn syncBlock() void {
    asm volatile ("bar.sync 0;" ::: .{ .memory = true });
}

/// Identity-or-cast float helper.
inline fn castFloat(comptime To: type, val: anytype) To {
    if (@TypeOf(val) == To) return val;
    return @floatCast(val);
}

/// e^x via hardware ex2 instruction. ~22 bits mantissa precision,
/// sufficient for softmax probability normalization.
inline fn expf32(x: f32) f32 {
    const log2_e: f32 = 1.4426950408889634; // log2(e)
    var out: f32 = undefined;
    asm volatile (
        "ex2.approx.f32 %[r], %[v];"
        : [r] "=f" (out),
        : [v] "f" (x * log2_e),
    );
    return out;
}

/// Warp-level reduction using shuffle. Reduces 32 lanes down to lane 0.
/// `combine` is the binary op: `fn(a, b) -> result`.
inline fn warpReduce(
    comptime AccumT: type,
    comptime combine: fn (AccumT, AccumT) AccumT,
    val: AccumT,
) AccumT {
    var v = val;
    comptime var offset: u32 = 16;
    inline while (offset > 0) : (offset /= 2) {
        // shfl.sync.down.b32 with full warp mask
        const peer = shuffleDown(AccumT, v, offset);
        v = combine(v, peer);
    }
    return v;
}

/// Shuffle-down primitive. For f32: ld/st via inline PTX.
inline fn shuffleDown(comptime T: type, val: T, offset: u32) T {
    if (T == f32) {
        var out: f32 = undefined;
        asm volatile (
            "shfl.sync.down.b32 %[r], %[v], %[o], 0x1f, 0xffffffff;"
            : [r] "=f" (out),
            : [v] "f" (val),
              [o] "r" (offset),
        );
        return out;
    }
    @compileError("shuffleDown not implemented for " ++ @typeName(T));
}

/// Block-level reduction. Uses shared memory between warps, then warp-shuffle
/// within each warp. `combine` is the binary op and `identity` is its
/// identity element (0 for sum, -inf for max).
inline fn blockReduce(
    comptime AccumT: type,
    comptime block_size: u32,
    comptime combine: fn (AccumT, AccumT) AccumT,
    comptime identity: AccumT,
    tid: u32,
    val: AccumT,
) AccumT {
    // First: warp-level reduction
    var v = warpReduce(AccumT, combine, val);

    // Now lane 0 of each warp has the partial result.
    // Stash partials into shared memory, then have warp 0 do the final reduce.
    const num_warps = block_size / 32;
    const shared = struct {
        var partials: [num_warps]AccumT addrspace(.shared) = undefined;
    };

    const warp_id = tid / 32;
    const lane_id = tid % 32;

    if (lane_id == 0) {
        shared.partials[warp_id] = v;
    }
    syncBlock();

    // Warp 0 loads all partials and reduces them
    if (warp_id == 0) {
        v = if (lane_id < num_warps) shared.partials[lane_id] else identity;
        v = warpReduce(AccumT, combine, v);
    }

    return v;
}

// ─── The kernel body, generic over Config ──────────────────────────────

inline fn softmaxBody(
    comptime cfg: Config,
    N: u32, // row width (= number of cols in the (rows × N) matrix)
    input: [*]addrspace(.global) const cfg.T,
    output: [*]addrspace(.global) cfg.T,
) void {
    comptime cfg.validate();

    const T = cfg.T;
    const AccumT = cfg.accum;
    const BLOCK = cfg.block_size;

    const row: u32 = @intCast(@workGroupId(0));
    const tid: u32 = @intCast(@workItemId(0));

    // Each thread handles ceil(N / BLOCK) elements of this row.
    const elements_per_thread = (N + BLOCK - 1) / BLOCK;

    const row_base = row * N;

    // ── Pass 1: find the max ────────────────────────────────────────
    var local_max: AccumT = -std.math.inf(AccumT);
    comptime var i: u32 = 0;
    inline while (i < @import("std").math.maxInt(u8)) : (i += 1) {
        if (i >= elements_per_thread) break;
        const col = tid + i * BLOCK;
        if (col < N) {
            const x = castFloat(AccumT, input[row_base + col]);
            if (x > local_max) local_max = x;
        }
    }

    const row_max = blockReduce(
        AccumT,
        BLOCK,
        struct {
            fn f(a: AccumT, b: AccumT) AccumT {
                return if (a > b) a else b;
            }
        }.f,
        -std.math.inf(AccumT),
        tid,
        local_max,
    );

    // Broadcast row_max to all threads via shared memory.
    const broadcast = struct {
        var value: AccumT addrspace(.shared) = undefined;
    };
    if (tid == 0) broadcast.value = row_max;
    syncBlock();
    const max_val = broadcast.value;

    // ── Pass 2: compute exp(x - max) and sum ────────────────────────
    var local_sum: AccumT = 0;
    var j: u32 = 0;
    while (j < elements_per_thread) : (j += 1) {
        const col = tid + j * BLOCK;
        if (col < N) {
            const x = castFloat(AccumT, input[row_base + col]);
            const e = expf32(x - max_val);
            // Stash the exp value back into output for pass 3
            output[row_base + col] = castFloat(T, e);
            local_sum += e;
        }
    }

    const row_sum = blockReduce(
        AccumT,
        BLOCK,
        struct {
            fn f(a: AccumT, b: AccumT) AccumT {
                return a + b;
            }
        }.f,
        0,
        tid,
        local_sum,
    );

    if (tid == 0) broadcast.value = row_sum;
    syncBlock();
    const sum_val = broadcast.value;

    // ── Pass 3: divide each element by the sum ──────────────────────
    const inv_sum: AccumT = 1.0 / sum_val;
    var k: u32 = 0;
    while (k < elements_per_thread) : (k += 1) {
        const col = tid + k * BLOCK;
        if (col < N) {
            const e = castFloat(AccumT, output[row_base + col]);
            output[row_base + col] = castFloat(T, e * inv_sum);
        }
    }
}

// ─── Named instantiations ──────────────────────────────────────────────

pub fn softmax_f32_256(
    N: u32,
    input: [*]addrspace(.global) const f32,
    output: [*]addrspace(.global) f32,
) callconv(.kernel) void {
    softmaxBody(.{ .T = f32, .accum = f32, .block_size = 256 }, N, input, output);
}

pub fn softmax_f16_256(
    N: u32,
    input: [*]addrspace(.global) const f16,
    output: [*]addrspace(.global) f16,
) callconv(.kernel) void {
    softmaxBody(.{ .T = f16, .accum = f32, .block_size = 256 }, N, input, output);
}

export fn __dummy_force_emit(i: usize) *const anyopaque {
    const ptrs = [_]*const anyopaque{
        @ptrCast(&softmax_f32_256),
        @ptrCast(&softmax_f16_256),
    };
    return ptrs[i % 2];
}
