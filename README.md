# zig_cuda

Pure-Zig bindings for the NVIDIA CUDA Driver API, plus a working vector-add
example that compiles a Zig kernel to PTX and launches it on the GPU.

No `@cImport`. No CUDA toolkit dependency at build time. Only `libcuda.so`
(which ships with the NVIDIA driver) is needed at runtime. The PTX kernel
is compiled by Zig's NVPTX backend and embedded into the host binary via
`@embedFile`, so the final executable is a single self-contained file.

## Status

Working on:

- Zig `0.17.0-dev.127+0b768cd9d` (nightly)
- Arch Linux, kernel 6.19, NVIDIA driver via `nvidia-dkms`
- GTX 1660 Ti (Turing, sm_75)

The project is small: ~160 lines of bindings, ~225 lines of idiomatic
wrappers, ~70 lines of host code, ~35 lines of device code. It exists
primarily to prove the toolchain works and to document the workarounds
needed to make it work.

## Building

```sh
zig build              # build everything (host exe + PTX kernel)
zig build run          # build and run the vector_add example
```

Expected output:

```
Device: NVIDIA GeForce GTX 1660 Ti
N=1048576  max error = 0
```

## Project layout

```
build.zig              # cross-compiles host + PTX, embeds PTX into host
src/
  bindings.zig         # raw `extern "cuda"` declarations
  cuda.zig             # idiomatic Zig wrappers (Device, Context, Module, ...)
  kernel.zig           # device code, compiled to PTX
  main.zig             # host code, runs vector_add on the GPU
```

## Workarounds

This project is bleeding-edge and currently relies on **five** distinct
workarounds for issues at the intersection of Zig nightly, LLVM 19's NVPTX
backend, and modern Linux toolchains. All five must be in place
simultaneously for the build to succeed and the kernel to run. As the
toolchain matures, each of these should become unnecessary — they are
load-bearing today, not forever.

### 1. Glibc pinned to 2.38 to bypass GCC 15's `.sframe` relocations

GCC 15 emits `.sframe` (Stack Frame Format) sections in `crt1.o` for fast
unwinding. Zig's bundled LLD doesn't yet handle `R_X86_64_PC64`
relocations inside `.sframe`, so linking the host binary against the
system's `crt1.o` panics with:

```
fatal linker error: unhandled relocation type R_X86_64_PC64 at offset 0x1c
  note: in /usr/lib/gcc/x86_64-pc-linux-gnu/15.2.1/.../crt1.o:.sframe
```

**Fix:** target an older glibc explicitly. Zig then uses its bundled,
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
*any* alias targeting a `callconv(.kernel)` function is rejected:

```
LLVM ERROR: NVPTX aliasee must be a non-kernel function definition
```

**Fix:** disable the UBSan runtime on the device-side compilation:

```zig
kernel.bundle_ubsan_rt = false;
```

### 3. Kernel function uses `pub fn`, not `export fn`

`export fn` on a `callconv(.kernel)` function creates an LLVM alias —
same NVPTX restriction as above. **Fix:** declare the kernel as `pub fn`
instead. This sidesteps the alias machinery but introduces problem #4.

### 4. A dummy export keeps the kernel from being DCE'd

A `pub fn` that nothing in the device-side compilation unit calls gets
dead-code-eliminated, producing an empty PTX file (just the header, no
`.entry`). The kernel is supposed to be called from the host via the
CUDA driver, but Zig's DCE doesn't know that.

The natural workarounds — `comptime { _ = vector_add; }`, `_ = &vector_add`,
`export const x = @ptrCast(&vector_add)`, `@export(&vector_add, ...)` —
all either still get DCE'd or hit the alias bug from #2/#3.

**Fix:** an `export fn` *with a body* that returns a pointer to the
kernel. Because it has a body, LLVM compiles it as a regular non-kernel
function and materializes the pointer-to-kernel as a normal instruction
operand (not an alias). The kernel survives DCE because the dummy
references it:

```zig
export fn __dummy_force_emit() *const anyopaque {
    return @ptrCast(&vector_add);
}
```

### 5. Host looks up the kernel by its mangled symbol name

Because `vector_add` is `pub fn` (not `export fn`), Zig mangles its
symbol in the PTX output to `kernel_$_vector_add`. The host code calls
`cuModuleGetFunction` with that exact string:

```zig
const kernel = try module.getFunction("kernel_$_vector_add");
```

To verify the name on your build, run:

```sh
zig build
grep '\.entry' zig-out/bin/kernel.ptx
```

## Architecture notes

**Hand-rolled bindings, not `@cImport`.** The bindings in `src/bindings.zig`
are written directly as `pub extern "cuda" fn ...` declarations. This
makes the project insensitive to the upcoming `@cImport`-to-build-system
migration in Zig and avoids needing the CUDA SDK headers at compile time.
Only `libcuda.so` (provided by the NVIDIA driver) is needed at link time,
and the build system finds it via `linkSystemLibrary("cuda", .{})`.

**`_v2` ABI symbols.** Driver API functions that handle 64-bit device
pointers expose `_v2` symbols at the ABI level. The C header `#define`s
hide this, but at the symbol level the `_v2` versions are what actually
exist. The bindings call them directly: `cuCtxCreate_v2`, `cuMemAlloc_v2`,
`cuMemcpyHtoD_v2`, etc.

**Kernel launch via runtime tuple reconstruction.** `cuLaunchKernel`
takes a `void**` array where each entry points to the address of an
argument. Zig anonymous-struct literals containing comptime-known values
have comptime fields, which can't have their addresses taken. The wrapper
in `src/cuda.zig` reconstructs a runtime tuple via the `@Tuple` builtin,
copies the args into stack-resident storage, and builds the pointer array
from there.

**PTX is embedded, not loaded from disk.** The host calls
`cuda.Module.loadData(@embedFile("kernel_ptx"))`, where the embed is
wired up in `build.zig` via `addAnonymousImport`. The single executable
contains the PTX bytes inline. No filesystem dependency at runtime.

## What's next

The bindings are minimal — about 15 functions, enough to launch a kernel.
Adding more is mechanical: copy the C signature from
`docs.nvidia.com/cuda/cuda-driver-api/`, write the `pub extern` declaration
matching the ABI symbol (`_v2` if present), and optionally wrap it in
`cuda.zig`.

Useful additions in roughly increasing order of effort:

- `cuEventCreate` / `cuEventRecord` / `cuEventElapsedTime` for timing.
  Three more bindings; ~20 lines of wrapper code. Lets you measure kernel
  duration and compare against a host-side reference loop.
- A reduction kernel using shared memory (`addrspace(.shared)`).
  Introduces intra-block synchronization (`@workGroupBarrier()`) and the
  hierarchical thread/block model.
- Tiled matmul. The smallest kernel where memory bandwidth, occupancy,
  and shared-memory bank conflicts start to matter.

## License

MIT or whatever you like. The bindings are mechanical translations of
NVIDIA's public CUDA Driver API; the wrapper code is original.
