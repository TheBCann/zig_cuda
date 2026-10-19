# zig_cuda

Pure-Zig bindings for the NVIDIA CUDA Driver API, plus working examples
that compile Zig kernels to PTX and launch them on the GPU.

No CUDA SDK headers needed — the bindings are
hand-written `extern "cuda"` declarations. At link time the build
resolves `libcuda.so` through pkg-config's `cuda` package when your
system has one, otherwise against the CUDA toolkit's `lib/stubs`
directory (default `/opt/cuda`); `-Dcuda-path` overrides both. At
runtime only the real `libcuda.so` (which ships with the NVIDIA driver)
is needed.
The PTX kernels are compiled by Zig's NVPTX backend and embedded into
the host binary via `@embedFile`, so each example produces a single
self-contained executable.

## Status

Working on:

- Zig 0.17.0 or newer. Tested on the 0.17.0 release and on nightlies
  0.18.0-dev.291+13ee14043 and 0.18.0-dev.349+d924f83bf. Nightlies
  0.18.0-dev.287 through 0.18.0-dev.295 have a Zig bug (fixed in
  dev.296 by Zig commit `156ab92d9d`, 2026-10-15) that breaks using this
  package as a dependency; the examples themselves still build and run
  there.
- Arch Linux, kernel 7.2, NVIDIA driver 610.57.04 via `nvidia-open-dkms`,
  CUDA 13.3
- GTX 1660 Ti (Turing, sm_75)

## Using as a dependency

Add zig_cuda to your project:

```sh
zig fetch --save=cuda git+https://github.com/TheBCann/zig_cuda
```

In your `build.zig`:

```zig
const std = @import("std");
const cuda = @import("cuda"); // imports zig_cuda's build.zig

pub fn build(b: *std.Build) void {
    const host_target = b.standardTargetOptions(.{
        // Portable baseline x86-64 host code. Add `.cpu_model = .native` for the
        // host's SIMD, as zig_cuda's own examples do.
        .default_target = .{ .os_tag = .linux, .abi = .gnu },
    });
    const optimize = b.standardOptimizeOption(.{});
    const cuda_path = b.option([]const u8, "cuda-path", "Directory whose lib/stubs/ holds libcuda.so");

    const cuda_dep = b.dependency("cuda", .{
        .target = host_target,
        .optimize = optimize,
    });

    // Compile your Zig kernel to PTX.
    const kernel = cuda.addKernel(b, .{
        .name = "kernel",
        .source = b.path("src/kernel.zig"),
        .sm = .sm_75, // your GPU's compute capability
    });

    const exe = b.addExecutable(.{
        .name = "my_gpu_app",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = host_target,
            .optimize = optimize,
        }),
    });

    // Wire up the runtime cuda module + embedded PTX.
    exe.root_module.addImport("cuda", cuda_dep.module("cuda"));
    exe.root_module.addAnonymousImport("kernel_ptx", .{
        .root_source_file = kernel.getEmittedAsm(),
    });

    cuda.linkCuda(exe, .{ .cuda_path = cuda_path });

    b.installArtifact(exe);
}
```

Your kernel and host code follow the patterns shown in
`examples/01_vector_add/`: declare each kernel as
`export fn name(...) callconv(.kernel)` and look it up from the host
with `module.getFunction(Args, "name")`. Kernels written for older Zig
(a `pub fn` kernel kept alive by an `__dummy_force_emit` export and
looked up by its mangled name, e.g. `"kernel_$_name"`) still work.

**Note on the dual `"cuda"` name.** `@import("cuda")` at the top of `build.zig`
imports zig_cuda's build.zig as a namespace (giving you `addKernel`, `linkCuda`,
`SmArch`). The same name `"cuda"` later appears in
`cuda_dep.module("cuda")` — that's wiring up the **runtime** module
(`src/root.zig`) for your main.zig to `@import("cuda")` at runtime. Two
different things named "cuda" depending on context.

**The `cuda` module is compiled as PIC.** Its bindings are
`extern "cuda"` declarations, and Zig only lets position-independent
code depend on a dynamic library by name. `cuda_dep.module("cuda")`
already has `.pic = true`; if you build your own module from
zig_cuda's `src/root.zig`, set `.pic = true` on it too (see
[Workarounds](#workarounds)).

**CUDA path.** libcuda is found through pkg-config's `cuda` package if
your system has one, else under `/opt/cuda` (Arch Linux). Otherwise
pass the directory whose `lib/stubs/` holds `libcuda.so`, e.g.
`-Dcuda-path=/usr/local/cuda/targets/x86_64-linux` for NVIDIA's
installer layout. An explicit `-Dcuda-path` always takes precedence
over pkg-config.

**Supported SM architectures**: sm_60 through sm_90a, covering Pascal,
Volta, Turing, Ampere, Ada, and Hopper. Match the constant to your GPU.
Pascal and Volta (sm_60–sm_72) need an R580-or-older NVIDIA driver
(R580 is the CUDA 13.0 driver branch); R590+ drivers (CUDA 13.1 and
newer) only support sm_75 and newer.

## Building

```sh
zig build                                                       # build everything
zig build run-all                                               # run + verify all 15 (each exits nonzero on bad results)
zig build run-01_vector_add                                     # minimal launch
zig build run-02_timed_vector_add                               # kernel-only timing
zig build run-03_pcie_truth              -Doptimize=safe        # honest end-to-end timing
zig build run-04_reduction               -Doptimize=safe        # reduction v1 (tree)
zig build run-05_matmul                  -Doptimize=safe        # tiled matmul
zig build run-06_reduction_v2            -Doptimize=safe        # reduction v2 (halve threads)
zig build run-07_reduction_v3            -Doptimize=safe        # reduction v3 (warp shuffles)
zig build run-08_streams                 -Doptimize=safe        # pinned + async streams
zig build run-09_comptime_matmul         -Doptimize=safe        # 4 PTX kernels from one source
zig build run-10_vectorized_matmul       -Doptimize=safe        # @Vector(2, f32) cooperative loads
zig build run-11_register_blocked_matmul -Doptimize=safe        # 4x4 register tile per thread (1.5 TFLOPS)
zig build run-12_softmax                 -Doptimize=safe        # row-wise stable softmax
zig build run-13_attention_scores        -Doptimize=safe        # scores = (Q @ K^T) / sqrt(d)
zig build run-14_attention_output        -Doptimize=safe        # output = weights @ V
zig build run-15_attention_forward       -Doptimize=safe        # integrated attention forward pass
```

`run-all` runs the examples one at a time, but on a cold cache it
starts running early examples while later ones are still compiling.
For timings, run `zig build` first or use a single `run-NN` step.

Expected output for the first example:

```
Device: NVIDIA GeForce GTX 1660 Ti
N=1048576  max error = 0
```

## Project layout

```
build.zig                          # cross-compiles host + PTX, embeds PTX into host
src/
  root.zig                         # public API (re-exports from cuda.zig + bindings.zig)
  bindings.zig                     # raw `extern "cuda"` declarations
  cuda.zig                         # idiomatic Zig wrappers (Device, Context, Module, ...)
examples/
  01_vector_add/                   # minimal launch + correctness check
  02_timed_vector_add/             # kernel-only timing via CUDA events
  03_pcie_truth/                   # honest end-to-end timing (PCIe overhead exposed)
  04_reduction/                    # shared-memory tree reduction (sum) — baseline
  05_matmul/                       # tiled 2D matrix multiply (the GPU-shines example)
  06_reduction_v2/                 # halve threads, double loads at boundary (1.7× faster)
  07_reduction_v3/                 # warp-shuffle reduction (1.7× faster again, ~3× over v1)
  08_streams/                      # pinned host memory + 2-stream pipelining (1.78× speedup)
  09_comptime_matmul/              # 4 specialized kernels (f32×3, f16×1) from one source
  10_vectorized_matmul/            # @Vector(2, f32) cooperative loads (global loads weren't the bottleneck)
  11_register_blocked_matmul/      # 4×4 register tile per thread (1.5 TFLOPS, 2.7× over simple tiled)
  12_softmax/                      # row-wise numerically stable softmax (warp-shuffle reductions)
  13_attention_scores/             # scores = (Q @ K^T) / sqrt(d), K^T via shared-memory transpose
  14_attention_output/             # output = weights @ V, tiled matmul with non-square grid
  15_attention_forward/            # integrated attention forward pass — three kernels chained on device
```

## Workarounds

This project originally shipped five workarounds for issues at the
intersection of Zig nightly, LLVM's NVPTX backend, and the host
toolchain. None is needed on Zig 0.17.0 or newer (#2 never had any
effect), and all five have been removed; Zig 0.18.0-dev added one new
requirement. The history is kept below because code written against
older Zig still carries these patterns.

### Required: the `cuda` module is compiled as PIC

Since Zig PR #36532 (0.18.0-dev.131) executables no longer default to
position-independent code, and Zig only lets PIC code depend on a
dynamic library by name. Every `extern "cuda" fn` then fails with:

```
error: dependency on dynamic library 'cuda' requires enabling Position Independent Code; fixed by '-lcuda' or '-fPIC'
```

The `-lcuda` half of that hint is wrong for executables: linking
libcuda does not satisfy the check. So `build.zig` creates the module
with `.pic = true`:

```zig
const cuda_module = b.addModule("cuda", .{
    .root_source_file = b.path("src/root.zig"),
    .pic = true,
});
```

Consumers using `cuda_dep.module("cuda")` inherit this; if you build
your own module from zig_cuda's sources, set `.pic = true` yourself.

### Retired

1. **Glibc pinned to 2.38.** The host glibc's `crt1.o`, built by GCC
   15+ toolchains that emit SFrame data, has `.sframe` sections
   containing `R_X86_64_PC64` relocations, which Zig's self-hosted ELF
   linker (used for Debug x86_64 builds) could not handle: `fatal linker error: unhandled relocation type
   R_X86_64_PC64 ... crt1.o:.sframe`. Zig commit 9df02121d0
   ("link.Elf: support R_X86_64_PC64", in 0.17.0) fixed it. The default
   host target still names `linux-gnu` explicitly, which keeps linking
   hermetic (Zig-built startup files, not the host's), just without a
   glibc version pin.
2. **UBSan runtime disabled on the kernel object**
   (`bundle_ubsan_rt = false`). Zig never builds the UBSan runtime for
   NVPTX, so the setting was a no-op and the PTX is byte-identical
   without it. The same goes for `use_llvm = true`: NVPTX always goes
   through LLVM.
3. **Kernels declared `pub fn` instead of `export fn`.** Zig used to
   lower `export fn` on a `callconv(.kernel)` function to an LLVM
   alias, which NVPTX rejects (`LLVM ERROR: NVPTX aliasee must be a
   non-kernel function definition`). Since Zig 0.17.0 an export renames
   the kernel itself (commits 1b7b856a81, 2785bc3823 and 31500242f0),
   so `export fn` emits `.visible .entry vector_add` directly.
4. **A `__dummy_force_emit` export to keep kernels from being DCE'd.**
   Only needed while kernels are `pub fn`: nothing in the device code
   calls them, so dead-code elimination removed them. Exported kernels
   are roots and always survive. (`comptime { _ = vector_add; }` and
   `_ = &vector_add` still don't keep a `pub fn` kernel alive.)
5. **Host lookups by mangled name** (`"kernel_$_vector_add"`). A
   consequence of #3: a non-exported kernel gets a mangled PTX symbol,
   `<file stem>_$_<name>`. Exported kernels keep their plain names, so
   the host now calls `module.getFunction(Args, "vector_add")`.

**One export name per kernel.** On NVPTX each export renames the same
symbol, so a kernel exported under more than one name (`export fn`
plus `@export`, or several `@export`s) keeps only one of them in the
PTX. Which one survives follows the compiler's processing order, not
source order, and a host lookup by any other name fails at runtime. CI
checks that every `getFunction` name exists as a PTX `.entry`. To see
the names on your build:

```sh
zig build
grep -ao '\.entry [A-Za-z0-9_$]*' zig-out/bin/*
```

Each executable embeds its PTX, so this lists the entry points each
installed binary actually carries (`.zig-cache` keeps every PTX variant
ever built, including stale ones).

## Architecture notes

**Hand-rolled bindings.** The bindings in
`src/bindings.zig` are written directly as `pub extern "cuda" fn ...`
declarations. `@cImport` has since been removed from the language
(Zig 0.17.0; C headers now go through the build system's translate-c
step), and hand-written externs need neither translate-c nor the CUDA
SDK headers. Only `libcuda.so` is needed at link time — `linkCuda`
finds it via `linkSystemLibrary("cuda", ...)`, through pkg-config's
`cuda` package when present and the toolkit's `lib/stubs` directory
otherwise (`-Dcuda-path` overrides both). At runtime the dynamic linker
picks up the driver's real `libcuda.so.1`. Because the declarations
name a dynamic library, the module must be compiled as PIC (see
[Workarounds](#workarounds)).

**`_v2` ABI symbols.** Driver API functions that handle 64-bit device
pointers expose `_v2` symbols at the ABI level. The C header `#define`s
hide this, but at the symbol level the `_v2` versions are what actually
exist. The bindings call them directly: `cuCtxCreate_v2`,
`cuMemAlloc_v2`, `cuMemcpyHtoD_v2`, etc.

**Type-safe kernel launches.** `Module.getFunction(Args, name)` takes
a user-defined `Args` struct that names each kernel parameter, and
returns a `Function(Args)`. Its `launch` method only accepts matching
args — wrong field names, wrong types, or wrong count all fail at
compile time with descriptive errors. Named fields also document each
kernel's host ABI in code:

```zig
const VectorAddArgs = struct {
    n: u32,
    x: cuda.bindings.CUdeviceptr,
    y: cuda.bindings.CUdeviceptr,
    out: cuda.bindings.CUdeviceptr,
};

const kernel = try module.getFunction(VectorAddArgs, "vector_add");

try kernel.launch(.{
    .grid = .{ .x = grid },
    .block = .{ .x = block },
}, .{ .n = N, .x = dx.ptr, .y = dy.ptr, .out = dout.ptr });
```

The implementation is in `src/cuda.zig`. The same `Args` struct
parameterizes everything: identical kernels share a single struct
(example 09 uses one `MatmulArgs` for four distinct PTX entry points),
and different kernels keep their type-checked launches from
cross-contaminating.

**PTX is embedded, not loaded from disk.** The host calls
`cuda.Module.loadPtx(@embedFile("kernel_ptx"))`, where the embed is
wired up in `build.zig` via `addAnonymousImport`. The single executable
contains the PTX bytes inline. No filesystem dependency at runtime.
`loadPtx` takes a `[:0]const u8`, so the type guarantees the NUL
terminator the driver needs to read PTX text; `loadData` is for cubin
and fatbin images, which need none.

**Inline PTX where Zig has no builtin.** The block barrier `bar.sync`
(examples 04–07 and 09–15) and the warp shuffle `shfl.sync.down.b32`
(07, 12, 15) have no Zig builtin, so those kernels use Zig's inline asm
with NVPTX constraint letters (`r` for 32-bit integer registers, `f`
for 32-bit floats). Examples 12 and 15 also use inline
`ex2.approx.f32` for a fast exp, though `@exp2(x * log2(e))` now lowers
to the same instructions. Vectorized loads need no asm: example 10
loads through a `*const @Vector(2, f32)` pointer, which LLVM lowers to
a single `ld.global.v2`.

## Performance

Measured on a GTX 1660 Ti, i7-9700K, PCIe Gen3 x16, with
`-Doptimize=safe`. Figures come from single runs with no warm-up (the
15_forward row summarizes several): GPU numbers are CUDA-event timings
(kernel only, or copies plus kernels for the end-to-end and streams
rows), CPU numbers use the host monotonic clock. Expect 2–5×
run-to-run variation on the GPU side depending on clock state, and more
on a loaded CPU; treat the numbers as indicative, not as benchmarks.
Most were recorded on earlier Zig nightlies; the 15_forward row was
re-measured on 0.18.0-dev.

### Vector add (worst-case workload)

For vector add, N = 16M elements (64 MB per buffer):

```
CPU (AVX2 reference):       13.8 ms
GPU kernel only:            0.9 ms   (16× vs CPU)
GPU end-to-end (w/ PCIe):   25.3 ms  (0.5× vs CPU)
PCIe transfer overhead:     24.4 ms  (97% of end-to-end)
```

Vector add has arithmetic intensity 0.083 FLOPs/byte — the worst
possible case for GPU advantage. The kernel itself runs 16× faster than
the CPU, but PCIe transfers dominate the end-to-end time so heavily
that the GPU loses on a single-shot operation.

See `examples/03_pcie_truth/main.zig` for the full benchmark.

### Tiled matmul (compute-bound workload)

For 1024×1024×1024 matrix multiply (tiled, TILE=16):

```
CPU naive triple loop:  1364 ms   (1.6 GFLOPS)
GPU kernel only:        3.8 ms    (560 GFLOPS, 356× vs CPU)
GPU end-to-end:         5.8 ms    (237× vs CPU)
```

Tiled matmul has arithmetic intensity ~16 FLOPs/byte — high enough that
PCIe transfer cost stops mattering. This is the workload pattern that
makes GPUs useful: enough compute per byte loaded that the bandwidth
advantage compounds. Real ML kernels (attention, convolutions, large
matmuls) sit in this regime.

See `examples/05_matmul/main.zig` for the full benchmark.

### Reduction (three progressively-optimized kernels)

For 1M-element f32 sum reduction (N = 1 << 20), three successive
kernel rewrites:

```
CPU loop (scalar f64 sum):    0.9 ms
GPU v1 (tree reduction):      0.074 ms   (12× vs CPU)
GPU v2 (halve threads):       0.043 ms   (21× vs CPU)
GPU v3 (warp shuffles):       0.025 ms   (37× vs CPU)
```

**v1 → v2 (1.7×):** each thread loads two elements and adds at load
time, so a block covers 2× the input. Half the launch overhead, half
the wasted threads. Structural improvement, not just a tweak.

**v2 → v3 (1.7×):** the in-warp portion of the reduction (5 of 8
steps) drops all shared-memory traffic and barriers, replaced by
`shfl.sync.down.b32` warp-level register exchanges. One cycle per step
instead of ~60.

See `examples/04_reduction/`, `examples/06_reduction_v2/`, and
`examples/07_reduction_v3/` for the kernels side by side.

### Async streams (overlapping copies with compute)

For 16M-element f32 vector add (the same workload from example 03),
with async streams and pinned memory:

```
Sync baseline (pageable, default stream):   22.1 ms   ( 9.1 GB/s)
Streamed (pinned, 2 streams, 4 chunks):     12.4 ms   (16.2 GB/s)
Speedup: 1.78×
```

The kernel itself is unchanged — what changed is how transfers and
compute are scheduled. Pinned host memory bypasses the driver's hidden
staging buffer (faster per-copy throughput); two streams alternating
across four chunks let upload, kernel, and download happen concurrently
on the 1660 Ti's separate copy engines.

PCIe Gen3 x16 has ~16 GB/s theoretical bandwidth per direction. The
streamed version approaches saturation by using both directions
simultaneously — uploads on one engine, downloads on the other.

This is the technique that makes single-shot GPU operations viable for
transfer-bound workloads (ML inference activations, KV cache movement,
streaming data pipelines).

See `examples/08_streams/main.zig`.

### Comptime-specialized matmul (one source, four PTX kernels)

For 1024×1024×1024 matmul, four kernels generated from one Zig source
via comptime specialization:

```
[ f32   8×8×8  ]  →  6.94 ms   (309 GFLOPS)
[ f32  16×16×16]  →  3.88 ms   (554 GFLOPS)
[ f32  32×32×32]  →  3.71 ms   (579 GFLOPS)
[ f16  16×16×16]  →  3.53 ms   (609 GFLOPS, f32 accumulator)
```

The f16 variant uses an f32 accumulator (the standard mixed-precision
pattern). Comptime selects the entire data path — element type, shared
memory layout, accumulator type, casting at load/store boundaries —
from one Zig source. A compile-time `@compileError` rejects degenerate
combinations like "f32 inputs with f16 accumulator" before any kernel
gets emitted.

The f16 kernel matches or slightly beats the best f32 config on this
hardware despite the 1660 Ti having no tensor cores. The wins are structural: half the
shared memory per tile, half the bandwidth per load. This kernel
converts every f16 to f32 and does plain f32 multiplies and adds (no
`mma`/`wmma`), so tensor-core GPUs would not widen the f16 gap; only a
kernel rewritten around `mma.sync`/`wmma` would use those units.

Each of the four kernels is a distinct PTX `.entry` compiled from the
same source. The CUDA C++ equivalent would be a template
specialization, but C++ templates can't express this kind of
validation logic — Zig's `@compileError` runs arbitrary code at
compile time.

See `examples/09_comptime_matmul/`.

### Register-blocked matmul: the technique that actually matters

Two more matmul experiments past comptime specialization, with one
clear winner.

**Example 10 — vectorized cooperative loads.** Replace per-element
scalar loads with `@Vector(2, f32)` loads, which compile to one
`ld.global.v2` instruction per two f32s. Doubled K-direction tile
(16 → 32) to absorb the wider loads. Result: 561 GFLOPS — essentially
identical to the baseline.

Global memory was not the limit. Per K-tile each thread issues only
~3 global loads (one `ld.global.v2` for A, two scalar loads for B,
whose column-direction access can't be vectorized) against 32
multiply-adds, so widening some of them barely moved the needle. The
real ceiling at ~560 GFLOPS (about 10% of the 1660 Ti's ~5.6 TFLOPS
FP32 peak) is the inner product's 2 shared-memory loads per
multiply-add, which example 11 attacks.

**Example 11 — register-blocked matmul.** Each thread now computes a
4×4 tile of C in registers instead of one element. Inner loop: 8
shared-memory loads + 16 FMAs per K iteration (vs 2 loads + 1 FMA in
the simple version). Loads-per-FMA ratio drops from 2.0 to 0.5, which
lifts the kernel to ~1.5 TFLOPS (about a quarter of FP32 peak).

Plus: `@mulAdd(f32, ...)` forces emission of `fma.rn.f32` instead of
the compiler's default `mul.rn.f32` + `add.rn.f32` (one rounding step
instead of two, one cycle instead of two).

```
[ Simple tiled 16×16          ]  →  3.85 ms   (554 GFLOPS)
[ Comptime 32×32              ]  →  3.71 ms   (579 GFLOPS)
[ Vectorized v2 loads         ]  →  3.83 ms   (561 GFLOPS)
[ Register-blocked 4×4 + FMA  ]  →  1.43 ms   (1495 GFLOPS)
```

**2.7× speedup** from a single technique. The kernel is now within
~1.5–2× of cuBLAS on the same hardware. Remaining gap closeable with
double-buffered shared memory, vectorized cooperative loads at the
right scale, and larger thread tiles (8×8) — each closing maybe
15–20% more. Tensor cores would change the picture entirely but the
1660 Ti has none.

The progression as a whole — 554 → 579 → 561 → 1495 GFLOPS across
examples 05, 09, 10, 11 — is the real lesson. Most kernel
optimizations don't help much. One technique you understand deeply
makes a huge difference.

See `examples/10_vectorized_matmul/` and
`examples/11_register_blocked_matmul/`.

### Attention forward pass

Three kernels chained on device implement the transformer attention
primitive: `output = softmax(Q @ K^T / sqrt(d)) @ V`. Each piece is
verified individually before the integrated example chains them.

For N=512 (sequence length), d=64 (head dimension), single-head:

```
[ 12_softmax  ]  →  0.094 ms   (53.7 GB/s, max abs err 4.8e-8)
[ 13_scores   ]  →  0.167 ms   (201 GFLOPS, max abs err 7.5e-8)
[ 14_output   ]  →  0.154 ms   (218 GFLOPS, max abs err 2.2e-8)
[ 15_forward  ]  →  ~0.2 ms    (full pipeline, ~120–150× vs CPU)
```

**Softmax (example 12).** Row-wise numerically stable softmax using
the standard `exp(x - max) / sum` formulation. Each block handles one
row of the input matrix. Reductions for the max and the sum both use
warp-shuffle finalization (the technique from example 07_reduction_v3).
`@exp` has no NVPTX lowering (it fails to compile: no libcall is
available), so the kernel computes `e^x = 2^(x * log2(e))` with inline
PTX `ex2.approx.f32`; `@exp2(x * log2(e))` would now produce the same
instructions.

The `warpReduce` helper is comptime-generic over the combine function
(`max(a,b)` for max, `a+b` for sum), so one helper produces two
specialized PTX paths. This is one of the places Zig's comptime pulls
real weight — CUDA C++ would do this with templates or function
pointers, both clumsier.

**Scores (example 13).** `scores = (Q @ K^T) / sqrt(d)`. The
interesting bit is the K^T access. Instead of materializing a
transposed K in global memory, the cooperative load writes K into
shared memory with the indices swapped: `Ks[col][row] = K[row][col]`.
The compute phase then reads `Ks[k][tx]` with `tx` adjacent across the
warp — coalesced shared-memory access, no transpose required at
runtime.

**Output (example 14).** Plain tiled matmul, `output = weights @ V`,
with the contraction axis (N=512) tiled into shared memory in
TILE_K-sized slabs. Grid is non-square (`(d/TILE, N/TILE) = (4, 32)`)
because the output is `(N, d)`, not `(N, N)`.

**Integrated pipeline (example 15).** All three kernels chained on
device, no host round-trips. One PTX module, three function handles
(`scores_f32_16`, `softmax_f32_256`, `output_f32_16`). Per-kernel
timing breaks the total down:
scores (~0.09–0.14 ms) → softmax (~0.015 ms) → output (~0.06–0.08 ms).
The softmax is fast because it is a light, bandwidth-bound kernel:
three short passes (max, exp-sum, normalize) over each 2 KB row; the
matmuls are slower because they do far more work per element.

End-to-end correctness: max absolute error 7e-8 across the full
pipeline against a CPU attention reference. Errors accumulate across
three kernels with a softmax nonlinearity in between, and the answer
still lands in single-precision noise.

**The memory traffic that motivates FlashAttention.** The softmax
kernel writes a 1 MB `weights` matrix to global memory, then the
output kernel immediately reads it back. That round-trip is the
single biggest performance ceiling in this design — the intermediate
buffer exists only to be consumed by the next kernel. FlashAttention
eliminates this traffic by fusing all three kernels into one and
using online softmax (max and sum updated incrementally as tiles
stream through), so the full attention output is computed without
ever materializing the scores or weights matrices. Same operation,
dramatically less memory traffic. That's the next milestone.

See `examples/12_softmax/`, `examples/13_attention_scores/`,
`examples/14_attention_output/`, and `examples/15_attention_forward/`.

## What's next

The bindings cover 35 functions now, including async transfers,
pinned memory, streams, and events — enough for production-grade
kernel scheduling on a single GPU. Kernel launches are type-checked at
compile time via `Function(Args)` and user-defined argument structs.
Matmul sits at ~1.5 TFLOPS f32, within ~1.5-2× of cuBLAS on the same
hardware. A vanilla attention forward pass runs its three kernels in
~0.2 ms of GPU time (excluding host↔device copies) at N=512, d=64.

Coming next:

- **FlashAttention v1.** Fuse the three attention kernels into one,
  use online softmax (Dao et al. 2022, arxiv 2205.14135), tile the N
  dimension in shared memory. Same operation as example 15, but the
  scores and weights matrices never get materialized to global memory.
  Should dramatically reduce memory traffic; on larger N (where the
  intermediate buffers get bigger) the speedup becomes substantial.
- **Multi-head attention.** Vanilla attention is single-head; real
  transformers run H heads in parallel and concatenate. Straightforward
  wrapper around the existing kernels (or the eventual FlashAttention),
  with grid expanded along a head axis.
- **Closing the matmul gap to cuBLAS.** Double-buffered shared memory
  (load tile N+1 while computing on N), 8×8 thread tiles (more compute
  per memory load), and vectorized cooperative loads at the right
  scale. Each ~10-20% gain, cumulatively maybe another 1.5×.
- **Multi-GPU support** (`cuCtxSetCurrent`, peer-to-peer transfers).
  The bindings already cover `cuCtxSetCurrent`; no example exercises
  it yet.

## License

MIT. See `LICENSE`.
