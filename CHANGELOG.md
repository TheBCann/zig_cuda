# Changelog

## 0.3.0

### Breaking changes

- Raw `cuda.bindings` now comes from CUDA 13.4 headers through TranslateC.
  `CUresult` is a C integer: compare against `CUDA_SUCCESS` and `CUDA_ERROR_*`
  constants instead of enum tags such as `.success`. C pointer types and API
  aliases follow the generated declarations.
- The typed wrapper interface remains intact. `Context.create` retains the
  existing `cuCtxCreate_v2` ABI through a compatibility declaration.

### Changes

- Check in generated bindings so normal builds require no CUDA headers.
  Regenerate explicitly with `zig build bindings`; select a toolkit root with
  `-Dcuda-headers=...`.
- Enforce typed buffer copy bounds and checked byte sizes in every build mode.
- Share attention head-dimension validation between hosts and kernels.
- Verify all seven matmul variants against deterministic random inputs on four
  shapes, including rectangular dimensions, partial tiles, and odd row strides.
- Use scalar loads when vectorized matmul addresses are misaligned.
- Add CPU-only validation tests and adapt CI for generated declarations.
- Retire the explicit PIC requirement for the runtime module's declarations.

### Validation

- Zig 0.18.0-dev.974+598176dbb on Linux x86_64; CUDA 13.4 headers.
- Debug and safe builds, CPU tests in debug and fast modes, and a consumer
  package build passed. GitHub CI passed for the merged migration.
- All 15 GPU examples and 28 random matmul cases passed on a GTX 1660 Ti.
- Other Zig versions and host ABIs have not been revalidated for this migration.
