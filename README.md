# zig_cuda

Pure-Zig bindings for the NVIDIA CUDA Driver API, plus working examples
that compile Zig kernels to PTX and launch them on the GPU.

No `@cImport`. No CUDA toolkit dependency at build time. Only
`libcuda.so` (which ships with the NVIDIA driver) is needed at runtime.
The PTX kernels are compiled by Zig's NVPTX backend and embedded into
the host binary via `@embedFile`, so each example produces a single
self-contained executable.

## Status

Working on:

- Zig 0.17.0-dev.304+9787df942 (nightly)
- Arch Linux, kernel 6.19, NVIDIA driver via `nvidia-dkms`
- GTX 1660 Ti (Turing, sm_75)

## Building

```sh
zig build                                                  # build everything
zig build run-01_vector_add                                # minimal launch
zig build run-02_timed_vector_add                          # kernel-only timing
zig build run-03_pcie_truth        -Doptimize=ReleaseSafe  # honest end-to-end timing
zig build run-04_reduction         -Doptimize=ReleaseSafe  # reduction v1 (tree)
zig build run-05_matmul            -Doptimize=ReleaseSafe  # tiled matmul
zig build run-06_reduction_v2      -Doptimize=ReleaseSafe  # reduction v2 (halve threads)
zig build run-07_reduction_v3      -Doptimize=ReleaseSafe  # reduction v3 (warp shuffles)
zig build run-08_streams           -Doptimize=ReleaseSafe  # pinned + async streams
zig build run-09_comptime_matmul   -Doptimize=ReleaseSafe  # 4 PTX kernels from one source
```

Expected output for the first example:

```
Device: NVIDIA GeForce GTX 1660 Ti
N=1048576  max error = 0
```

## Project layout

```
build.zig                # cross-compiles host + PTX, embeds PTX into host
src/
  root.zig               # public API (re-exports from cuda.zig + bindings.zig)
  bindings.zig           # raw `extern "cuda"` declarations
  cuda.zig               # idiomatic Zig wrappers (Device, Context, Module, ...)
examples/
  01_vector_add/         # minimal launch + correctness check
  02_timed_vector_add/   # kernel-only timing via CUDA events
  03_pcie_truth/         # honest end-to-end timing (PCIe overhead exposed)
  04_reduction/          # shared-memory tree reduction (sum) — baseline
  05_matmul/             # tiled 2D matrix multiply (the GPU-shines example)
  06_reduction_v2/       # halve threads, double loads at boundary (1.7× faster)
  07_reduction_v3/       # warp-shuffle reduction (1.7× faster again, 2.7× over v1)
  08_streams/            # pinned host memory + 2-stream pipelining (1.78× speedup)
  09_comptime_matmul/    # 4 specialized kernels (f32×3, f16×1) from one source
```

## Workarounds

This project is bleeding-edge and currently relies on five distinct
workarounds for issues at the intersection of Zig nightly, LLVM 19's
NVPTX backend, and modern Linux toolchains. All five must be in place
simultaneously for the build to succeed and the kernel to run. As the
toolchain matures, each of these should become unnecessary — they are
load-bearing today, not forever.

### 1. Glibc pinned to 2.38 to bypass GCC 15's `.sframe` relocations

GCC 15 emits `.sframe` (Stack Frame Format) sections in `crt1.o` for
fast unwinding. Zig's bundled LLD doesn't yet handle `R_X86_64_PC64`
relocations inside `.sframe`, so linking the host binary against the
system's `crt1.o` panics with:

```
fatal linker error: unhandled relocation type R_X86_64_PC64 at offset 0x1c
  note: in /usr/lib/gcc/x86_64-pc-linux-gnu/15.2.1/.../crt1.o:.sframe
```

Fix: target an older glibc explicitly. Zig then uses its bundled,
hermetic startup objects instead of the host system's:

```zig
const target = b.standardTargetOptions(.{
    .default_target = .{
        .os_tag = .linux,
        .abi = .gnu,
        .glibc_version = .{ .major = 2, .minor = 38, .patch = 0 },
    },
});
```

### 2. UBSan runtime disabled on the kernel object

Zig's UBSan runtime hooks generate LLVM aliases. On the NVPTX backend,
any alias targeting a `callconv(.kernel)` function is rejected:

```
LLVM ERROR: NVPTX aliasee must be a non-kernel function definition
```

Fix: disable the UBSan runtime on the device-side compilation:

```zig
kernel.bundle_ubsan_rt = false;
```

### 3. Kernel function uses `pub fn`, not `export fn`

`export fn` on a `callconv(.kernel)` function creates an LLVM alias —
same NVPTX restriction as above. Fix: declare the kernel as `pub fn`
instead. This sidesteps the alias machinery but introduces problem #4.

### 4. A dummy export keeps the kernel from being DCE'd

A `pub fn` that nothing in the device-side compilation unit calls gets
dead-code-eliminated, producing an empty PTX file (just the header, no
`.entry`). The kernel is supposed to be called from the host via the
CUDA driver, but Zig's DCE doesn't know that.

The natural workarounds — `comptime { _ = vector_add; }`,
`_ = &vector_add`, `export const x = @ptrCast(&vector_add)`,
`@export(&vector_add, ...)` — all either still get DCE'd or hit the
alias bug from #2/#3.

Fix: an `export fn` with a body that returns a pointer to the kernel.
Because it has a body, LLVM compiles it as a regular non-kernel
function and materializes the pointer-to-kernel as a normal instruction
operand (not an alias). The kernel survives DCE because the dummy
references it:

```zig
export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&vector_add);
}
```

For multi-kernel modules (example 09), the dummy takes a runtime
parameter to prevent the optimizer from proving any specific pointer
unused — forcing all kernels to survive:

```zig
export fn __dummy_force_emit(i: usize) *const anyopaque {
    const ptrs = [_]*const anyopaque{
        @ptrCast(&matmul_f32_8x8),
        @ptrCast(&matmul_f32_16x16),
        @ptrCast(&matmul_f32_32x32),
        @ptrCast(&matmul_f16_16x16),
    };
    return ptrs[i % 4];
}
```

### 5. Host looks up the kernel by its mangled symbol name

Because `vector_add` is `pub fn` (not `export fn`), Zig mangles its
symbol in the PTX output to `kernel_$_vector_add`. The host code calls
`cuModuleGetFunction` with that exact string:

```zig
const kernel = try module.getFunction(VectorAddArgs, "kernel_$_vector_add");
```

To verify the name on your build, run:

```sh
zig build
grep '\.entry' zig-out/bin/kernel.ptx
```

## Architecture notes

**Hand-rolled bindings, not `@cImport`.** The bindings in
`src/bindings.zig` are written directly as `pub extern "cuda" fn ...`
declarations. This makes the project insensitive to the upcoming
`@cImport`-to-build-system migration in Zig and avoids needing the CUDA
SDK headers at compile time. Only `libcuda.so` (provided by the NVIDIA
driver) is needed at link time, and the build system finds it via
`linkSystemLibrary("cuda", .{})`.

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

const kernel = try module.getFunction(VectorAddArgs, "kernel_$_vector_add");

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
`cuda.Module.loadData(@embedFile("kernel_ptx"))`, where the embed is
wired up in `build.zig` via `addAnonymousImport`. The single executable
contains the PTX bytes inline. No filesystem dependency at runtime.

## Performance

Measured on a GTX 1660 Ti, i7-9700K, PCIe Gen3 x16, with
`-Doptimize=ReleaseSafe`.

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
CPU loop (autovectorized):    0.9 ms
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

The f16 kernel beats every f32 config on this hardware despite the
1660 Ti having no tensor cores. The wins are structural: half the
shared memory per tile, half the bandwidth per load. On hardware with
tensor cores (RTX 2060+, A100, H100) the gap would be 3-8× larger
because those cards have dedicated f16 matmul units.

Each of the four kernels is a distinct PTX `.entry` compiled from the
same source. The CUDA C++ equivalent would be a template
specialization, but C++ templates can't express this kind of
validation logic — Zig's `@compileError` runs arbitrary code at
compile time.

See `examples/09_comptime_matmul/`.

## What's next

The bindings cover ~30 functions now, including async transfers,
pinned memory, streams, and events — enough for production-grade
kernel scheduling on a single GPU. Kernel launches are type-checked at
compile time via `Function(Args)` and user-defined argument structs.

Coming next:

- **Multi-GPU support** (`cuCtxSetCurrent`, peer-to-peer transfers).
  The bindings already cover `cuCtxSetCurrent`; no example exercises
  it yet.
- **A more substantive kernel: attention.** The unfused vanilla
  attention forward pass is ~50 lines of kernel code and produces a
  real LLM inference primitive. Distinct enough from matmul to
  exercise different parts of the API surface (broadcast, softmax
  along an axis, masking).
- **Vectorized loads** (`ld.global.v4.f32`). Loading 4 floats per
  instruction rather than 1 should push matmul toward ~1 TFLOPS on the
  1660 Ti.

## License

MIT. See `LICENSE`.
