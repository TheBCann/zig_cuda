/* Input to zig build bindings. Do not enable CUDA's internal API macros:
   they change default-stream aliases and expose legacy 32-bit interfaces. */
#include <cuda.h>

/* Public cuda.h now selects cuCtxCreate_v4. Keep the wrapper's existing v2
   ABI for older drivers. This is the only compatibility declaration we add;
   types and all other function declarations come from the toolkit header. */
CUresult CUDAAPI cuCtxCreate_v2(CUcontext *pctx, unsigned int flags, CUdevice dev);
