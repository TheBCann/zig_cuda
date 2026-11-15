const __root = @This();
pub const __builtin = @import("std").zig.c_translation.builtins;
pub const __helpers = @import("std").zig.c_translation.helpers;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __aro_max_align_ll: c_longlong = 0,
    __aro_max_align_ld: c_longdouble = 0,
};
pub const div_t = extern struct {
    quot: c_int = 0,
    rem: c_int = 0,
};
pub const ldiv_t = extern struct {
    quot: c_long = 0,
    rem: c_long = 0,
};
pub const lldiv_t = extern struct {
    quot: c_longlong = 0,
    rem: c_longlong = 0,
};
pub extern fn __ctype_get_mb_cur_max() usize;
pub extern fn atof(__nptr: [*c]const u8) f64;
pub extern fn atoi(__nptr: [*c]const u8) c_int;
pub extern fn atol(__nptr: [*c]const u8) c_long;
pub extern fn atoll(__nptr: [*c]const u8) c_longlong;
pub extern fn strtod(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8) f64;
pub extern fn strtof(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8) f32;
pub extern fn strtold(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8) c_longdouble;
pub extern fn strtol(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_long;
pub extern fn strtoul(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_ulong;
pub extern fn strtoq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtouq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn strtoll(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtoull(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn l64a(__n: c_long) [*c]u8;
pub extern fn a64l(__s: [*c]const u8) c_long;
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const u_char = __u_char;
pub const u_short = __u_short;
pub const u_int = __u_int;
pub const u_long = __u_long;
pub const quad_t = __quad_t;
pub const u_quad_t = __u_quad_t;
pub const fsid_t = __fsid_t;
pub const loff_t = __loff_t;
pub const ino_t = __ino_t;
pub const dev_t = __dev_t;
pub const gid_t = __gid_t;
pub const mode_t = __mode_t;
pub const nlink_t = __nlink_t;
pub const uid_t = __uid_t;
pub const off_t = __off_t;
pub const pid_t = __pid_t;
pub const id_t = __id_t;
pub const daddr_t = __daddr_t;
pub const caddr_t = __caddr_t;
pub const key_t = __key_t;
pub const clock_t = __clock_t;
pub const clockid_t = __clockid_t;
pub const time_t = __time_t;
pub const timer_t = __timer_t;
pub const ulong = c_ulong;
pub const ushort = c_ushort;
pub const uint = c_uint;
pub const u_int8_t = __uint8_t;
pub const u_int16_t = __uint16_t;
pub const u_int32_t = __uint32_t;
pub const u_int64_t = __uint64_t;
pub const register_t = c_int;
pub fn __bswap_16(arg___bsx: __uint16_t) callconv(.c) __uint16_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @byteSwap(@as(__uint16_t, __bsx));
}
pub fn __bswap_32(arg___bsx: __uint32_t) callconv(.c) __uint32_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @byteSwap(@as(__uint32_t, __bsx));
}
pub fn __bswap_64(arg___bsx: __uint64_t) callconv(.c) __uint64_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @byteSwap(@as(__uint64_t, __bsx));
}
pub fn __uint16_identity(arg___x: __uint16_t) callconv(.c) __uint16_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint32_identity(arg___x: __uint32_t) callconv(.c) __uint32_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint64_identity(arg___x: __uint64_t) callconv(.c) __uint64_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub const __sigset_t = extern struct {
    __val: [16]c_ulong = @import("std").mem.zeroes([16]c_ulong),
};
pub const sigset_t = __sigset_t;
pub const struct_timeval = extern struct {
    tv_sec: __time_t = 0,
    tv_usec: __suseconds_t = 0,
};
pub const struct_timespec = extern struct {
    tv_sec: __time_t = 0,
    tv_nsec: __syscall_slong_t = 0,
};
pub const suseconds_t = __suseconds_t;
pub const __fd_mask = c_long;
pub const fd_set = extern struct {
    __fds_bits: [16]__fd_mask = @import("std").mem.zeroes([16]__fd_mask),
};
pub const fd_mask = __fd_mask;
pub extern fn select(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]struct_timeval) c_int;
pub extern fn pselect(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]const struct_timespec, noalias __sigmask: [*c]const __sigset_t) c_int;
pub const blksize_t = __blksize_t;
pub const blkcnt_t = __blkcnt_t;
pub const fsblkcnt_t = __fsblkcnt_t;
pub const fsfilcnt_t = __fsfilcnt_t;
const struct_unnamed_1 = extern struct {
    __low: c_uint = 0,
    __high: c_uint = 0,
};
pub const __atomic_wide_counter = extern union {
    __value64: c_ulonglong,
    __value32: struct_unnamed_1,
};
pub const struct___pthread_internal_list = extern struct {
    __prev: [*c]struct___pthread_internal_list = null,
    __next: [*c]struct___pthread_internal_list = null,
};
pub const __pthread_list_t = struct___pthread_internal_list;
pub const struct___pthread_internal_slist = extern struct {
    __next: [*c]struct___pthread_internal_slist = null,
};
pub const __pthread_slist_t = struct___pthread_internal_slist;
pub const struct___pthread_mutex_s = extern struct {
    __lock: c_int = 0,
    __count: c_uint = 0,
    __owner: c_int = 0,
    __nusers: c_uint = 0,
    __kind: c_int = 0,
    __spins: c_short = 0,
    __glibc_reserved: c_short = 0,
    __list: __pthread_list_t = @import("std").mem.zeroes(__pthread_list_t),
};
pub const struct___pthread_rwlock_arch_t = extern struct {
    __readers: c_uint = 0,
    __writers: c_uint = 0,
    __wrphase_futex: c_uint = 0,
    __writers_futex: c_uint = 0,
    __pad3: c_uint = 0,
    __pad4: c_uint = 0,
    __cur_writer: c_int = 0,
    __shared: c_int = 0,
    __pad1: c_ulong = 0,
    __pad2: c_ulong = 0,
    __flags: c_uint = 0,
};
pub const struct___pthread_cond_s = extern struct {
    __wseq: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g1_start: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g_size: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g1_orig_size: c_uint = 0,
    __wrefs: c_uint = 0,
    __g_signals: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __unused_initialized_1: c_uint = 0,
    __unused_initialized_2: c_uint = 0,
};
pub const __tss_t = c_uint;
pub const __thrd_t = c_ulong;
pub const __once_flag = extern struct {
    __data: c_int = 0,
};
pub const pthread_t = c_ulong;
pub const pthread_mutexattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_condattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_key_t = c_uint;
pub const pthread_once_t = c_int;
pub const union_pthread_attr_t = extern union {
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_attr_t = union_pthread_attr_t;
pub const pthread_mutex_t = extern union {
    __data: struct___pthread_mutex_s,
    __size: [40]u8,
    __align: c_long,
};
pub const pthread_cond_t = extern union {
    __data: struct___pthread_cond_s,
    __size: [48]u8,
    __align: c_longlong,
};
pub const pthread_rwlock_t = extern union {
    __data: struct___pthread_rwlock_arch_t,
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_rwlockattr_t = extern union {
    __size: [8]u8,
    __align: c_long,
};
pub const pthread_spinlock_t = c_int;
pub const pthread_barrier_t = extern union {
    __size: [32]u8,
    __align: c_long,
};
pub const pthread_barrierattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub extern fn random() c_long;
pub extern fn srandom(__seed: c_uint) void;
pub extern fn initstate(__seed: c_uint, __statebuf: [*c]u8, __statelen: usize) [*c]u8;
pub extern fn setstate(__statebuf: [*c]u8) [*c]u8;
pub const struct_random_data = extern struct {
    fptr: [*c]i32 = null,
    rptr: [*c]i32 = null,
    state: [*c]i32 = null,
    rand_type: c_int = 0,
    rand_deg: c_int = 0,
    rand_sep: c_int = 0,
    end_ptr: [*c]i32 = null,
    pub const random_r = __root.random_r;
    pub const r = __root.random_r;
};
pub extern fn random_r(noalias __buf: [*c]struct_random_data, noalias __result: [*c]i32) c_int;
pub extern fn srandom_r(__seed: c_uint, __buf: [*c]struct_random_data) c_int;
pub extern fn initstate_r(__seed: c_uint, noalias __statebuf: [*c]u8, __statelen: usize, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn setstate_r(noalias __statebuf: [*c]u8, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn rand() c_int;
pub extern fn srand(__seed: c_uint) void;
pub extern fn rand_r(__seed: [*c]c_uint) c_int;
pub extern fn drand48() f64;
pub extern fn erand48(__xsubi: [*c]c_ushort) f64;
pub extern fn lrand48() c_long;
pub extern fn nrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn mrand48() c_long;
pub extern fn jrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn srand48(__seedval: c_long) void;
pub extern fn seed48(__seed16v: [*c]c_ushort) [*c]c_ushort;
pub extern fn lcong48(__param: [*c]c_ushort) void;
pub const struct_drand48_data = extern struct {
    __x: [3]c_ushort = @import("std").mem.zeroes([3]c_ushort),
    __old_x: [3]c_ushort = @import("std").mem.zeroes([3]c_ushort),
    __c: c_ushort = 0,
    __init: c_ushort = 0,
    __a: c_ulonglong = 0,
    pub const drand48_r = __root.drand48_r;
    pub const lrand48_r = __root.lrand48_r;
    pub const mrand48_r = __root.mrand48_r;
    pub const r = __root.drand48_r;
};
pub extern fn drand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn erand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn lrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn nrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn mrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn jrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn srand48_r(__seedval: c_long, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn seed48_r(__seed16v: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn lcong48_r(__param: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn malloc(__size: usize) ?*anyopaque;
pub extern fn calloc(__nmemb: usize, __size: usize) ?*anyopaque;
pub extern fn realloc(__ptr: ?*anyopaque, __size: usize) ?*anyopaque;
pub extern fn free(__ptr: ?*anyopaque) void;
pub extern fn reallocarray(__ptr: ?*anyopaque, __nmemb: usize, __size: usize) ?*anyopaque;
pub extern fn alloca(__size: usize) ?*anyopaque;
pub extern fn valloc(__size: usize) ?*anyopaque;
pub extern fn posix_memalign(__memptr: [*c]?*anyopaque, __alignment: usize, __size: usize) c_int;
pub extern fn aligned_alloc(__alignment: usize, __size: usize) ?*anyopaque;
pub extern fn abort() noreturn;
pub extern fn atexit(__func: ?*const fn () callconv(.c) void) c_int;
pub extern fn at_quick_exit(__func: ?*const fn () callconv(.c) void) c_int;
pub extern fn on_exit(__func: ?*const fn (__status: c_int, __arg: ?*anyopaque) callconv(.c) void, __arg: ?*anyopaque) c_int;
pub extern fn exit(__status: c_int) noreturn;
pub extern fn quick_exit(__status: c_int) noreturn;
pub extern fn _Exit(__status: c_int) noreturn;
pub extern fn getenv(__name: [*c]const u8) [*c]u8;
pub extern fn putenv(__string: [*c]u8) c_int;
pub extern fn setenv(__name: [*c]const u8, __value: [*c]const u8, __replace: c_int) c_int;
pub extern fn unsetenv(__name: [*c]const u8) c_int;
pub extern fn clearenv() c_int;
pub extern fn mktemp(__template: [*c]u8) [*c]u8;
pub extern fn mkstemp(__template: [*c]u8) c_int;
pub extern fn mkstemps(__template: [*c]u8, __suffixlen: c_int) c_int;
pub extern fn mkdtemp(__template: [*c]u8) [*c]u8;
pub extern fn system(__command: [*c]const u8) c_int;
pub extern fn realpath(noalias __name: [*c]const u8, noalias __resolved: [*c]u8) [*c]u8;
pub const __compar_fn_t = ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int;
pub extern fn bsearch(__key: ?*const anyopaque, __base: ?*const anyopaque, __nmemb: usize, __size: usize, __compar: __compar_fn_t) ?*anyopaque;
pub extern fn qsort(__base: ?*anyopaque, __nmemb: usize, __size: usize, __compar: __compar_fn_t) void;
pub extern fn abs(__x: c_int) c_int;
pub extern fn labs(__x: c_long) c_long;
pub extern fn llabs(__x: c_longlong) c_longlong;
pub extern fn div(__numer: c_int, __denom: c_int) div_t;
pub extern fn ldiv(__numer: c_long, __denom: c_long) ldiv_t;
pub extern fn lldiv(__numer: c_longlong, __denom: c_longlong) lldiv_t;
pub extern fn ecvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn fcvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn gcvt(__value: f64, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn qecvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qfcvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qgcvt(__value: c_longdouble, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn ecvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn fcvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qecvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qfcvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn mblen(__s: [*c]const u8, __n: usize) c_int;
pub extern fn mbtowc(noalias __pwc: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) c_int;
pub extern fn wctomb(__s: [*c]u8, __wchar: wchar_t) c_int;
pub extern fn mbstowcs(noalias __pwcs: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) usize;
pub extern fn wcstombs(noalias __s: [*c]u8, noalias __pwcs: [*c]const wchar_t, __n: usize) usize;
pub extern fn rpmatch(__response: [*c]const u8) c_int;
pub extern fn getsubopt(noalias __optionp: [*c][*c]u8, noalias __tokens: [*c]const [*c]u8, noalias __valuep: [*c][*c]u8) c_int;
pub extern fn getloadavg(__loadavg: [*c]f64, __nelem: c_int) c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const cuuint32_t = u32;
pub const cuuint64_t = u64;
pub const CUdeviceptr_v2 = c_ulonglong;
pub const CUdeviceptr = CUdeviceptr_v2;
pub const CUdevice_v1 = c_int;
pub const CUdevice = CUdevice_v1;
pub const struct_CUctx_st = opaque {
    pub const cuCtxDestroy_v2 = __root.cuCtxDestroy_v2;
    pub const cuCtxPushCurrent_v2 = __root.cuCtxPushCurrent_v2;
    pub const cuCtxSetCurrent = __root.cuCtxSetCurrent;
    pub const cuCtxGetId = __root.cuCtxGetId;
    pub const cuCtxSynchronize_v2 = __root.cuCtxSynchronize_v2;
    pub const cuCtxGetApiVersion = __root.cuCtxGetApiVersion;
    pub const cuCtxRecordEvent = __root.cuCtxRecordEvent;
    pub const cuCtxWaitEvent = __root.cuCtxWaitEvent;
    pub const cuCtxDetach = __root.cuCtxDetach;
    pub const cuCtxEnablePeerAccess = __root.cuCtxEnablePeerAccess;
    pub const cuCtxDisablePeerAccess = __root.cuCtxDisablePeerAccess;
    pub const cuCtxGetDevResource = __root.cuCtxGetDevResource;
    pub const v2 = __root.cuCtxDestroy_v2;
};
pub const CUcontext = ?*struct_CUctx_st;
pub const struct_CUmod_st = opaque {
    pub const cuModuleUnload = __root.cuModuleUnload;
};
pub const CUmodule = ?*struct_CUmod_st;
pub const struct_CUfunc_st = opaque {
    pub const cuFuncSetAttribute = __root.cuFuncSetAttribute;
    pub const cuFuncSetCacheConfig = __root.cuFuncSetCacheConfig;
    pub const cuFuncGetParamInfo = __root.cuFuncGetParamInfo;
    pub const cuFuncGetParamCount = __root.cuFuncGetParamCount;
    pub const cuFuncLoad = __root.cuFuncLoad;
    pub const cuLaunchKernel = __root.cuLaunchKernel;
    pub const cuLaunchCooperativeKernel = __root.cuLaunchCooperativeKernel;
    pub const cuFuncSetBlockShape = __root.cuFuncSetBlockShape;
    pub const cuFuncSetSharedSize = __root.cuFuncSetSharedSize;
    pub const cuParamSetSize = __root.cuParamSetSize;
    pub const cuParamSeti = __root.cuParamSeti;
    pub const cuParamSetf = __root.cuParamSetf;
    pub const cuParamSetv = __root.cuParamSetv;
    pub const cuLaunch = __root.cuLaunch;
    pub const cuLaunchGrid = __root.cuLaunchGrid;
    pub const cuLaunchGridAsync = __root.cuLaunchGridAsync;
    pub const cuParamSetTexRef = __root.cuParamSetTexRef;
    pub const cuFuncSetSharedMemConfig = __root.cuFuncSetSharedMemConfig;
};
pub const CUfunction = ?*struct_CUfunc_st;
pub const struct_CUlib_st = opaque {
    pub const cuLibraryUnload = __root.cuLibraryUnload;
};
pub const CUlibrary = ?*struct_CUlib_st;
pub const struct_CUkern_st = opaque {
    pub const cuKernelSetCacheConfig = __root.cuKernelSetCacheConfig;
    pub const cuKernelGetParamInfo = __root.cuKernelGetParamInfo;
    pub const cuKernelGetParamCount = __root.cuKernelGetParamCount;
};
pub const CUkernel = ?*struct_CUkern_st;
pub const struct_CUarray_st = opaque {
    pub const cuMemcpyDtoA_v2 = __root.cuMemcpyDtoA_v2;
    pub const cuMemcpyHtoA_v2 = __root.cuMemcpyHtoA_v2;
    pub const cuMemcpyAtoA_v2 = __root.cuMemcpyAtoA_v2;
    pub const cuMemcpyHtoAAsync_v2 = __root.cuMemcpyHtoAAsync_v2;
    pub const cuArrayDestroy = __root.cuArrayDestroy;
    pub const v2 = __root.cuMemcpyDtoA_v2;
};
pub const CUarray = ?*struct_CUarray_st;
pub const struct_CUmipmappedArray_st = opaque {
    pub const cuMipmappedArrayDestroy = __root.cuMipmappedArrayDestroy;
};
pub const CUmipmappedArray = ?*struct_CUmipmappedArray_st;
pub const struct_CUtexref_st = opaque {
    pub const cuTexRefSetArray = __root.cuTexRefSetArray;
    pub const cuTexRefSetMipmappedArray = __root.cuTexRefSetMipmappedArray;
    pub const cuTexRefSetAddress2D_v3 = __root.cuTexRefSetAddress2D_v3;
    pub const cuTexRefSetFormat = __root.cuTexRefSetFormat;
    pub const cuTexRefSetAddressMode = __root.cuTexRefSetAddressMode;
    pub const cuTexRefSetFilterMode = __root.cuTexRefSetFilterMode;
    pub const cuTexRefSetMipmapFilterMode = __root.cuTexRefSetMipmapFilterMode;
    pub const cuTexRefSetMipmapLevelBias = __root.cuTexRefSetMipmapLevelBias;
    pub const cuTexRefSetMipmapLevelClamp = __root.cuTexRefSetMipmapLevelClamp;
    pub const cuTexRefSetMaxAnisotropy = __root.cuTexRefSetMaxAnisotropy;
    pub const cuTexRefSetBorderColor = __root.cuTexRefSetBorderColor;
    pub const cuTexRefSetFlags = __root.cuTexRefSetFlags;
    pub const cuTexRefDestroy = __root.cuTexRefDestroy;
    pub const v3 = __root.cuTexRefSetAddress2D_v3;
};
pub const CUtexref = ?*struct_CUtexref_st;
pub const struct_CUsurfref_st = opaque {
    pub const cuSurfRefSetArray = __root.cuSurfRefSetArray;
};
pub const CUsurfref = ?*struct_CUsurfref_st;
pub const struct_CUevent_st = opaque {
    pub const cuEventRecord = __root.cuEventRecord;
    pub const cuEventRecordWithFlags = __root.cuEventRecordWithFlags;
    pub const cuEventQuery = __root.cuEventQuery;
    pub const cuEventSynchronize = __root.cuEventSynchronize;
    pub const cuEventDestroy_v2 = __root.cuEventDestroy_v2;
    pub const v2 = __root.cuEventDestroy_v2;
};
pub const CUevent = ?*struct_CUevent_st;
pub const struct_CUstream_st = opaque {
    pub const cuStreamBeginCaptureToCig = __root.cuStreamBeginCaptureToCig;
    pub const cuStreamEndCaptureToCig = __root.cuStreamEndCaptureToCig;
    pub const cuStreamGetPriority = __root.cuStreamGetPriority;
    pub const cuStreamGetDevice = __root.cuStreamGetDevice;
    pub const cuStreamGetFlags = __root.cuStreamGetFlags;
    pub const cuStreamGetId = __root.cuStreamGetId;
    pub const cuStreamGetCtx = __root.cuStreamGetCtx;
    pub const cuStreamGetCtx_v2 = __root.cuStreamGetCtx_v2;
    pub const cuStreamWaitEvent = __root.cuStreamWaitEvent;
    pub const cuStreamAddCallback = __root.cuStreamAddCallback;
    pub const cuStreamBeginCapture_v2 = __root.cuStreamBeginCapture_v2;
    pub const cuStreamBeginRecaptureToGraph = __root.cuStreamBeginRecaptureToGraph;
    pub const cuStreamBeginCaptureToGraph = __root.cuStreamBeginCaptureToGraph;
    pub const cuStreamEndCapture = __root.cuStreamEndCapture;
    pub const cuStreamIsCapturing = __root.cuStreamIsCapturing;
    pub const cuStreamGetCaptureInfo_v3 = __root.cuStreamGetCaptureInfo_v3;
    pub const cuStreamUpdateCaptureDependencies_v2 = __root.cuStreamUpdateCaptureDependencies_v2;
    pub const cuStreamAttachMemAsync = __root.cuStreamAttachMemAsync;
    pub const cuStreamQuery = __root.cuStreamQuery;
    pub const cuStreamSynchronize = __root.cuStreamSynchronize;
    pub const cuStreamDestroy_v2 = __root.cuStreamDestroy_v2;
    pub const cuStreamCopyAttributes = __root.cuStreamCopyAttributes;
    pub const cuStreamGetAttribute = __root.cuStreamGetAttribute;
    pub const cuStreamSetAttribute = __root.cuStreamSetAttribute;
    pub const cuStreamWaitValue32_v2 = __root.cuStreamWaitValue32_v2;
    pub const cuStreamWaitValue64_v2 = __root.cuStreamWaitValue64_v2;
    pub const cuStreamWriteValue32_v2 = __root.cuStreamWriteValue32_v2;
    pub const cuStreamWriteValue64_v2 = __root.cuStreamWriteValue64_v2;
    pub const cuStreamBatchMemOp_v2 = __root.cuStreamBatchMemOp_v2;
    pub const cuLaunchHostFunc = __root.cuLaunchHostFunc;
    pub const cuLaunchHostFunc_v2 = __root.cuLaunchHostFunc_v2;
    pub const cuStreamGetGreenCtx = __root.cuStreamGetGreenCtx;
    pub const cuStreamGetDevResource = __root.cuStreamGetDevResource;
    pub const v2 = __root.cuStreamGetCtx_v2;
    pub const v3 = __root.cuStreamGetCaptureInfo_v3;
};
pub const CUstream = ?*struct_CUstream_st;
pub const struct_CUgraphicsResource_st = opaque {
    pub const cuGraphicsUnregisterResource = __root.cuGraphicsUnregisterResource;
    pub const cuGraphicsResourceSetMapFlags_v2 = __root.cuGraphicsResourceSetMapFlags_v2;
    pub const v2 = __root.cuGraphicsResourceSetMapFlags_v2;
};
pub const CUgraphicsResource = ?*struct_CUgraphicsResource_st;
pub const CUtexObject_v1 = c_ulonglong;
pub const CUtexObject = CUtexObject_v1;
pub const CUsurfObject_v1 = c_ulonglong;
pub const CUsurfObject = CUsurfObject_v1;
pub const struct_CUextMemory_st = opaque {
    pub const cuDestroyExternalMemory = __root.cuDestroyExternalMemory;
};
pub const CUexternalMemory = ?*struct_CUextMemory_st;
pub const struct_CUextSemaphore_st = opaque {
    pub const cuDestroyExternalSemaphore = __root.cuDestroyExternalSemaphore;
};
pub const CUexternalSemaphore = ?*struct_CUextSemaphore_st;
pub const struct_CUgraph_st = opaque {
    pub const cuGraphGetId = __root.cuGraphGetId;
    pub const cuGraphGetNodes = __root.cuGraphGetNodes;
    pub const cuGraphGetRootNodes = __root.cuGraphGetRootNodes;
    pub const cuGraphGetEdges_v2 = __root.cuGraphGetEdges_v2;
    pub const cuGraphAddDependencies_v2 = __root.cuGraphAddDependencies_v2;
    pub const cuGraphRemoveDependencies_v2 = __root.cuGraphRemoveDependencies_v2;
    pub const cuGraphDestroy = __root.cuGraphDestroy;
    pub const cuGraphDebugDotPrint = __root.cuGraphDebugDotPrint;
    pub const cuGraphRetainUserObject = __root.cuGraphRetainUserObject;
    pub const cuGraphReleaseUserObject = __root.cuGraphReleaseUserObject;
    pub const v2 = __root.cuGraphGetEdges_v2;
};
pub const CUgraph = ?*struct_CUgraph_st;
pub const struct_CUgraphNode_st = opaque {
    pub const cuGraphKernelNodeGetParams_v2 = __root.cuGraphKernelNodeGetParams_v2;
    pub const cuGraphKernelNodeSetParams_v2 = __root.cuGraphKernelNodeSetParams_v2;
    pub const cuGraphMemcpyNodeGetParams = __root.cuGraphMemcpyNodeGetParams;
    pub const cuGraphMemcpyNodeSetParams = __root.cuGraphMemcpyNodeSetParams;
    pub const cuGraphMemsetNodeGetParams = __root.cuGraphMemsetNodeGetParams;
    pub const cuGraphMemsetNodeSetParams = __root.cuGraphMemsetNodeSetParams;
    pub const cuGraphHostNodeGetParams = __root.cuGraphHostNodeGetParams;
    pub const cuGraphHostNodeSetParams = __root.cuGraphHostNodeSetParams;
    pub const cuGraphChildGraphNodeGetGraph = __root.cuGraphChildGraphNodeGetGraph;
    pub const cuGraphEventRecordNodeGetEvent = __root.cuGraphEventRecordNodeGetEvent;
    pub const cuGraphEventRecordNodeSetEvent = __root.cuGraphEventRecordNodeSetEvent;
    pub const cuGraphEventWaitNodeGetEvent = __root.cuGraphEventWaitNodeGetEvent;
    pub const cuGraphEventWaitNodeSetEvent = __root.cuGraphEventWaitNodeSetEvent;
    pub const cuGraphExternalSemaphoresSignalNodeGetParams = __root.cuGraphExternalSemaphoresSignalNodeGetParams;
    pub const cuGraphExternalSemaphoresSignalNodeSetParams = __root.cuGraphExternalSemaphoresSignalNodeSetParams;
    pub const cuGraphExternalSemaphoresWaitNodeGetParams = __root.cuGraphExternalSemaphoresWaitNodeGetParams;
    pub const cuGraphExternalSemaphoresWaitNodeSetParams = __root.cuGraphExternalSemaphoresWaitNodeSetParams;
    pub const cuGraphBatchMemOpNodeGetParams = __root.cuGraphBatchMemOpNodeGetParams;
    pub const cuGraphBatchMemOpNodeSetParams = __root.cuGraphBatchMemOpNodeSetParams;
    pub const cuGraphMemAllocNodeGetParams = __root.cuGraphMemAllocNodeGetParams;
    pub const cuGraphMemFreeNodeGetParams = __root.cuGraphMemFreeNodeGetParams;
    pub const cuGraphNodeGetType = __root.cuGraphNodeGetType;
    pub const cuGraphNodeGetContainingGraph = __root.cuGraphNodeGetContainingGraph;
    pub const cuGraphNodeGetLocalId = __root.cuGraphNodeGetLocalId;
    pub const cuGraphNodeGetToolsId = __root.cuGraphNodeGetToolsId;
    pub const cuGraphNodeGetDependencies_v2 = __root.cuGraphNodeGetDependencies_v2;
    pub const cuGraphNodeGetDependentNodes_v2 = __root.cuGraphNodeGetDependentNodes_v2;
    pub const cuGraphDestroyNode = __root.cuGraphDestroyNode;
    pub const cuGraphKernelNodeCopyAttributes = __root.cuGraphKernelNodeCopyAttributes;
    pub const cuGraphKernelNodeGetAttribute = __root.cuGraphKernelNodeGetAttribute;
    pub const cuGraphKernelNodeSetAttribute = __root.cuGraphKernelNodeSetAttribute;
    pub const cuGraphNodeSetParams = __root.cuGraphNodeSetParams;
    pub const cuGraphNodeSetParams_v2 = __root.cuGraphNodeSetParams_v2;
    pub const cuGraphNodeGetParams = __root.cuGraphNodeGetParams;
    pub const v2 = __root.cuGraphKernelNodeGetParams_v2;
};
pub const CUgraphNode = ?*struct_CUgraphNode_st;
pub const struct_CUgraphExec_st = opaque {
    pub const cuGraphExecBatchMemOpNodeSetParams = __root.cuGraphExecBatchMemOpNodeSetParams;
    pub const cuGraphExecGetId = __root.cuGraphExecGetId;
    pub const cuGraphExecGetFlags = __root.cuGraphExecGetFlags;
    pub const cuGraphExecKernelNodeSetParams_v2 = __root.cuGraphExecKernelNodeSetParams_v2;
    pub const cuGraphExecMemcpyNodeSetParams = __root.cuGraphExecMemcpyNodeSetParams;
    pub const cuGraphExecMemsetNodeSetParams = __root.cuGraphExecMemsetNodeSetParams;
    pub const cuGraphExecHostNodeSetParams = __root.cuGraphExecHostNodeSetParams;
    pub const cuGraphExecChildGraphNodeSetParams = __root.cuGraphExecChildGraphNodeSetParams;
    pub const cuGraphExecEventRecordNodeSetEvent = __root.cuGraphExecEventRecordNodeSetEvent;
    pub const cuGraphExecEventWaitNodeSetEvent = __root.cuGraphExecEventWaitNodeSetEvent;
    pub const cuGraphExecExternalSemaphoresSignalNodeSetParams = __root.cuGraphExecExternalSemaphoresSignalNodeSetParams;
    pub const cuGraphExecExternalSemaphoresWaitNodeSetParams = __root.cuGraphExecExternalSemaphoresWaitNodeSetParams;
    pub const cuGraphNodeSetEnabled = __root.cuGraphNodeSetEnabled;
    pub const cuGraphNodeGetEnabled = __root.cuGraphNodeGetEnabled;
    pub const cuGraphUpload = __root.cuGraphUpload;
    pub const cuGraphLaunch = __root.cuGraphLaunch;
    pub const cuGraphExecDestroy = __root.cuGraphExecDestroy;
    pub const cuGraphExecUpdate_v2 = __root.cuGraphExecUpdate_v2;
    pub const cuGraphExecNodeSetParams = __root.cuGraphExecNodeSetParams;
    pub const v2 = __root.cuGraphExecKernelNodeSetParams_v2;
};
pub const CUgraphExec = ?*struct_CUgraphExec_st;
pub const struct_CUmemPoolHandle_st = opaque {
    pub const cuMemPoolTrimTo = __root.cuMemPoolTrimTo;
    pub const cuMemPoolSetAttribute = __root.cuMemPoolSetAttribute;
    pub const cuMemPoolGetAttribute = __root.cuMemPoolGetAttribute;
    pub const cuMemPoolSetAccess = __root.cuMemPoolSetAccess;
    pub const cuMemPoolDestroy = __root.cuMemPoolDestroy;
};
pub const CUmemoryPool = ?*struct_CUmemPoolHandle_st;
pub const struct_CUuserObject_st = opaque {
    pub const cuUserObjectRetain = __root.cuUserObjectRetain;
    pub const cuUserObjectRelease = __root.cuUserObjectRelease;
};
pub const CUuserObject = ?*struct_CUuserObject_st;
pub const CUgraphConditionalHandle = cuuint64_t;
pub const struct_CUgraphDeviceUpdatableNode_st = opaque {};
pub const CUgraphDeviceNode = ?*struct_CUgraphDeviceUpdatableNode_st;
pub const struct_CUasyncCallbackEntry_st = opaque {};
pub const CUasyncCallbackHandle = ?*struct_CUasyncCallbackEntry_st;
pub const struct_CUgreenCtx_st = opaque {
    pub const cuGreenCtxDestroy = __root.cuGreenCtxDestroy;
    pub const cuGreenCtxGetDevResource = __root.cuGreenCtxGetDevResource;
    pub const cuGreenCtxRecordEvent = __root.cuGreenCtxRecordEvent;
    pub const cuGreenCtxWaitEvent = __root.cuGreenCtxWaitEvent;
    pub const cuGreenCtxGetId = __root.cuGreenCtxGetId;
};
pub const CUgreenCtx = ?*struct_CUgreenCtx_st;
pub const struct_CUuuid_st = extern struct {
    bytes: [16]u8 = @import("std").mem.zeroes([16]u8),
    pub const cuDeviceGetUuid_v2 = __root.cuDeviceGetUuid_v2;
    pub const cuDeviceGetFabricClusterUuid = __root.cuDeviceGetFabricClusterUuid;
    pub const v2 = __root.cuDeviceGetUuid_v2;
};
pub const CUuuid = struct_CUuuid_st;
pub const struct_CUmemFabricHandle_st = extern struct {
    data: [64]u8 = @import("std").mem.zeroes([64]u8),
};
pub const CUmemFabricHandle_v1 = struct_CUmemFabricHandle_st;
pub const CUmemFabricHandle = CUmemFabricHandle_v1;
pub const struct_CUipcEventHandle_st = extern struct {
    reserved: [64]u8 = @import("std").mem.zeroes([64]u8),
    pub const cuIpcGetEventHandle = __root.cuIpcGetEventHandle;
};
pub const CUipcEventHandle_v1 = struct_CUipcEventHandle_st;
pub const CUipcEventHandle = CUipcEventHandle_v1;
pub const struct_CUipcMemHandle_st = extern struct {
    reserved: [64]u8 = @import("std").mem.zeroes([64]u8),
    pub const cuIpcGetMemHandle = __root.cuIpcGetMemHandle;
};
pub const CUipcMemHandle_v1 = struct_CUipcMemHandle_st;
pub const CUipcMemHandle = CUipcMemHandle_v1;
pub const CU_IPC_MEM_LAZY_ENABLE_PEER_ACCESS: c_int = 1;
pub const enum_CUipcMem_flags_enum = c_uint;
pub const CUipcMem_flags = enum_CUipcMem_flags_enum;
pub const CU_MEM_ATTACH_GLOBAL: c_int = 1;
pub const CU_MEM_ATTACH_HOST: c_int = 2;
pub const CU_MEM_ATTACH_SINGLE: c_int = 4;
pub const enum_CUmemAttach_flags_enum = c_uint;
pub const CUmemAttach_flags = enum_CUmemAttach_flags_enum;
pub const CU_CTX_SCHED_AUTO: c_int = 0;
pub const CU_CTX_SCHED_SPIN: c_int = 1;
pub const CU_CTX_SCHED_YIELD: c_int = 2;
pub const CU_CTX_SCHED_BLOCKING_SYNC: c_int = 4;
pub const CU_CTX_BLOCKING_SYNC: c_int = 4;
pub const CU_CTX_SCHED_MASK: c_int = 7;
pub const CU_CTX_MAP_HOST: c_int = 8;
pub const CU_CTX_LMEM_RESIZE_TO_MAX: c_int = 16;
pub const CU_CTX_COREDUMP_ENABLE: c_int = 32;
pub const CU_CTX_USER_COREDUMP_ENABLE: c_int = 64;
pub const CU_CTX_SYNC_MEMOPS: c_int = 128;
pub const CU_CTX_FLAGS_MASK: c_int = 255;
pub const enum_CUctx_flags_enum = c_uint;
pub const CUctx_flags = enum_CUctx_flags_enum;
pub const CU_EVENT_SCHED_AUTO: c_int = 0;
pub const CU_EVENT_SCHED_SPIN: c_int = 1;
pub const CU_EVENT_SCHED_YIELD: c_int = 2;
pub const CU_EVENT_SCHED_BLOCKING_SYNC: c_int = 4;
pub const enum_CUevent_sched_flags_enum = c_uint;
pub const CUevent_sched_flags = enum_CUevent_sched_flags_enum;
pub const NVCL_EVENT_SCHED_AUTO: c_int = 0;
pub const NVCL_EVENT_SCHED_SPIN: c_int = 1;
pub const NVCL_EVENT_SCHED_YIELD: c_int = 2;
pub const NVCL_EVENT_SCHED_BLOCKING_SYNC: c_int = 4;
pub const enum_cl_event_flags_enum = c_uint;
pub const cl_event_flags = enum_cl_event_flags_enum;
pub const NVCL_CTX_SCHED_AUTO: c_int = 0;
pub const NVCL_CTX_SCHED_SPIN: c_int = 1;
pub const NVCL_CTX_SCHED_YIELD: c_int = 2;
pub const NVCL_CTX_SCHED_BLOCKING_SYNC: c_int = 4;
pub const enum_cl_context_flags_enum = c_uint;
pub const cl_context_flags = enum_cl_context_flags_enum;
pub const CU_HOST_TASK_BLOCKING: c_int = 0;
pub const CU_HOST_TASK_SPINWAIT: c_int = 1;
pub const enum_CUhostTaskSyncMode_enum = c_uint;
pub const CUhostTaskSyncMode = enum_CUhostTaskSyncMode_enum;
pub const CU_STREAM_DEFAULT: c_int = 0;
pub const CU_STREAM_NON_BLOCKING: c_int = 1;
pub const enum_CUstream_flags_enum = c_uint;
pub const CUstream_flags = enum_CUstream_flags_enum;
pub const CU_EVENT_DEFAULT: c_int = 0;
pub const CU_EVENT_BLOCKING_SYNC: c_int = 1;
pub const CU_EVENT_DISABLE_TIMING: c_int = 2;
pub const CU_EVENT_INTERPROCESS: c_int = 4;
pub const enum_CUevent_flags_enum = c_uint;
pub const CUevent_flags = enum_CUevent_flags_enum;
pub const CU_EVENT_RECORD_DEFAULT: c_int = 0;
pub const CU_EVENT_RECORD_EXTERNAL: c_int = 1;
pub const enum_CUevent_record_flags_enum = c_uint;
pub const CUevent_record_flags = enum_CUevent_record_flags_enum;
pub const CU_EVENT_WAIT_DEFAULT: c_int = 0;
pub const CU_EVENT_WAIT_EXTERNAL: c_int = 1;
pub const enum_CUevent_wait_flags_enum = c_uint;
pub const CUevent_wait_flags = enum_CUevent_wait_flags_enum;
pub const CU_ATOMIC_OPERATION_INTEGER_ADD: c_int = 0;
pub const CU_ATOMIC_OPERATION_INTEGER_MIN: c_int = 1;
pub const CU_ATOMIC_OPERATION_INTEGER_MAX: c_int = 2;
pub const CU_ATOMIC_OPERATION_INTEGER_INCREMENT: c_int = 3;
pub const CU_ATOMIC_OPERATION_INTEGER_DECREMENT: c_int = 4;
pub const CU_ATOMIC_OPERATION_AND: c_int = 5;
pub const CU_ATOMIC_OPERATION_OR: c_int = 6;
pub const CU_ATOMIC_OPERATION_XOR: c_int = 7;
pub const CU_ATOMIC_OPERATION_EXCHANGE: c_int = 8;
pub const CU_ATOMIC_OPERATION_CAS: c_int = 9;
pub const CU_ATOMIC_OPERATION_FLOAT_ADD: c_int = 10;
pub const CU_ATOMIC_OPERATION_FLOAT_MIN: c_int = 11;
pub const CU_ATOMIC_OPERATION_FLOAT_MAX: c_int = 12;
pub const CU_ATOMIC_OPERATION_MAX: c_int = 13;
pub const enum_CUatomicOperation_enum = c_uint;
pub const CUatomicOperation = enum_CUatomicOperation_enum;
pub const CU_ATOMIC_CAPABILITY_SIGNED: c_int = 1;
pub const CU_ATOMIC_CAPABILITY_UNSIGNED: c_int = 2;
pub const CU_ATOMIC_CAPABILITY_REDUCTION: c_int = 4;
pub const CU_ATOMIC_CAPABILITY_SCALAR_32: c_int = 8;
pub const CU_ATOMIC_CAPABILITY_SCALAR_64: c_int = 16;
pub const CU_ATOMIC_CAPABILITY_SCALAR_128: c_int = 32;
pub const CU_ATOMIC_CAPABILITY_VECTOR_32x4: c_int = 64;
pub const enum_CUatomicOperationCapability_enum = c_uint;
pub const CUatomicOperationCapability = enum_CUatomicOperationCapability_enum;
pub const CU_STREAM_WAIT_VALUE_GEQ: c_int = 0;
pub const CU_STREAM_WAIT_VALUE_EQ: c_int = 1;
pub const CU_STREAM_WAIT_VALUE_AND: c_int = 2;
pub const CU_STREAM_WAIT_VALUE_NOR: c_int = 3;
pub const CU_STREAM_WAIT_VALUE_FLUSH: c_int = 1073741824;
pub const enum_CUstreamWaitValue_flags_enum = c_uint;
pub const CUstreamWaitValue_flags = enum_CUstreamWaitValue_flags_enum;
pub const CU_STREAM_WRITE_VALUE_DEFAULT: c_int = 0;
pub const CU_STREAM_WRITE_VALUE_NO_MEMORY_BARRIER: c_int = 1;
pub const enum_CUstreamWriteValue_flags_enum = c_uint;
pub const CUstreamWriteValue_flags = enum_CUstreamWriteValue_flags_enum;
pub const CU_STREAM_MEM_OP_WAIT_VALUE_32: c_int = 1;
pub const CU_STREAM_MEM_OP_WRITE_VALUE_32: c_int = 2;
pub const CU_STREAM_MEM_OP_WAIT_VALUE_64: c_int = 4;
pub const CU_STREAM_MEM_OP_WRITE_VALUE_64: c_int = 5;
pub const CU_STREAM_MEM_OP_BARRIER: c_int = 6;
pub const CU_STREAM_MEM_OP_ATOMIC_REDUCTION: c_int = 8;
pub const CU_STREAM_MEM_OP_FLUSH_REMOTE_WRITES: c_int = 3;
pub const enum_CUstreamBatchMemOpType_enum = c_uint;
pub const CUstreamBatchMemOpType = enum_CUstreamBatchMemOpType_enum;
pub const CU_STREAM_MEMORY_BARRIER_TYPE_SYS: c_int = 0;
pub const CU_STREAM_MEMORY_BARRIER_TYPE_GPU: c_int = 1;
pub const enum_CUstreamMemoryBarrier_flags_enum = c_uint;
pub const CUstreamMemoryBarrier_flags = enum_CUstreamMemoryBarrier_flags_enum;
pub const CU_STREAM_ATOMIC_REDUCTION_OP_OR: c_int = 6;
pub const CU_STREAM_ATOMIC_REDUCTION_OP_AND: c_int = 5;
pub const CU_STREAM_ATOMIC_REDUCTION_OP_ADD: c_int = 0;
pub const enum_CUstreamAtomicReductionOpType_enum = c_uint;
pub const CUstreamAtomicReductionOpType = enum_CUstreamAtomicReductionOpType_enum;
pub const CU_STREAM_ATOMIC_REDUCTION_UNSIGNED_32: c_int = 14;
pub const CU_STREAM_ATOMIC_REDUCTION_UNSIGNED_64: c_int = 22;
pub const enum_CUstreamAtomicReductionDataType_enum = c_uint;
pub const CUstreamAtomicReductionDataType = enum_CUstreamAtomicReductionDataType_enum;
const union_unnamed_3 = extern union {
    value: cuuint32_t,
    value64: cuuint64_t,
};
pub const struct_CUstreamMemOpWaitValueParams_st_2 = extern struct {
    operation: CUstreamBatchMemOpType = @import("std").mem.zeroes(CUstreamBatchMemOpType),
    address: CUdeviceptr = 0,
    unnamed_0: union_unnamed_3 = @import("std").mem.zeroes(union_unnamed_3),
    flags: c_uint = 0,
    alias: CUdeviceptr = 0,
};
const union_unnamed_5 = extern union {
    value: cuuint32_t,
    value64: cuuint64_t,
};
pub const struct_CUstreamMemOpWriteValueParams_st_4 = extern struct {
    operation: CUstreamBatchMemOpType = @import("std").mem.zeroes(CUstreamBatchMemOpType),
    address: CUdeviceptr = 0,
    unnamed_0: union_unnamed_5 = @import("std").mem.zeroes(union_unnamed_5),
    flags: c_uint = 0,
    alias: CUdeviceptr = 0,
};
pub const struct_CUstreamMemOpFlushRemoteWritesParams_st_6 = extern struct {
    operation: CUstreamBatchMemOpType = @import("std").mem.zeroes(CUstreamBatchMemOpType),
    flags: c_uint = 0,
};
pub const struct_CUstreamMemOpMemoryBarrierParams_st_7 = extern struct {
    operation: CUstreamBatchMemOpType = @import("std").mem.zeroes(CUstreamBatchMemOpType),
    flags: c_uint = 0,
};
pub const struct_CUstreamMemOpAtomicReductionParams_st_8 = extern struct {
    operation: CUstreamBatchMemOpType = @import("std").mem.zeroes(CUstreamBatchMemOpType),
    flags: c_uint = 0,
    reductionOp: CUstreamAtomicReductionOpType = @import("std").mem.zeroes(CUstreamAtomicReductionOpType),
    dataType: CUstreamAtomicReductionDataType = @import("std").mem.zeroes(CUstreamAtomicReductionDataType),
    address: CUdeviceptr = 0,
    value: cuuint64_t = 0,
    alias: CUdeviceptr = 0,
};
pub const union_CUstreamBatchMemOpParams_union = extern union {
    operation: CUstreamBatchMemOpType,
    waitValue: struct_CUstreamMemOpWaitValueParams_st_2,
    writeValue: struct_CUstreamMemOpWriteValueParams_st_4,
    flushRemoteWrites: struct_CUstreamMemOpFlushRemoteWritesParams_st_6,
    memoryBarrier: struct_CUstreamMemOpMemoryBarrierParams_st_7,
    atomicReduction: struct_CUstreamMemOpAtomicReductionParams_st_8,
    pad: [6]cuuint64_t,
};
pub const CUstreamBatchMemOpParams_v1 = union_CUstreamBatchMemOpParams_union;
pub const CUstreamBatchMemOpParams = CUstreamBatchMemOpParams_v1;
pub const struct_CUDA_BATCH_MEM_OP_NODE_PARAMS_v1_st = extern struct {
    ctx: CUcontext = null,
    count: c_uint = 0,
    paramArray: [*c]CUstreamBatchMemOpParams = null,
    flags: c_uint = 0,
};
pub const CUDA_BATCH_MEM_OP_NODE_PARAMS_v1 = struct_CUDA_BATCH_MEM_OP_NODE_PARAMS_v1_st;
pub const CUDA_BATCH_MEM_OP_NODE_PARAMS = CUDA_BATCH_MEM_OP_NODE_PARAMS_v1;
pub const struct_CUDA_BATCH_MEM_OP_NODE_PARAMS_v2_st = extern struct {
    ctx: CUcontext = null,
    count: c_uint = 0,
    paramArray: [*c]CUstreamBatchMemOpParams = null,
    flags: c_uint = 0,
};
pub const CUDA_BATCH_MEM_OP_NODE_PARAMS_v2 = struct_CUDA_BATCH_MEM_OP_NODE_PARAMS_v2_st;
pub const CU_OCCUPANCY_DEFAULT: c_int = 0;
pub const CU_OCCUPANCY_DISABLE_CACHING_OVERRIDE: c_int = 1;
pub const enum_CUoccupancy_flags_enum = c_uint;
pub const CUoccupancy_flags = enum_CUoccupancy_flags_enum;
pub const CU_STREAM_ADD_CAPTURE_DEPENDENCIES: c_int = 0;
pub const CU_STREAM_SET_CAPTURE_DEPENDENCIES: c_int = 1;
pub const enum_CUstreamUpdateCaptureDependencies_flags_enum = c_uint;
pub const CUstreamUpdateCaptureDependencies_flags = enum_CUstreamUpdateCaptureDependencies_flags_enum;
pub const CU_ASYNC_NOTIFICATION_TYPE_OVER_BUDGET: c_int = 1;
pub const enum_CUasyncNotificationType_enum = c_uint;
pub const CUasyncNotificationType = enum_CUasyncNotificationType_enum;
const struct_unnamed_10 = extern struct {
    bytesOverBudget: c_ulonglong = 0,
};
const union_unnamed_9 = extern union {
    overBudget: struct_unnamed_10,
};
pub const struct_CUasyncNotificationInfo_st = extern struct {
    type: CUasyncNotificationType = @import("std").mem.zeroes(CUasyncNotificationType),
    info: union_unnamed_9 = @import("std").mem.zeroes(union_unnamed_9),
};
pub const CUasyncNotificationInfo = struct_CUasyncNotificationInfo_st;
pub const CUasyncCallback = ?*const fn (info: [*c]CUasyncNotificationInfo, userData: ?*anyopaque, callback: CUasyncCallbackHandle) callconv(.c) void;
pub const CU_AD_FORMAT_UNSIGNED_INT8: c_int = 1;
pub const CU_AD_FORMAT_UNSIGNED_INT16: c_int = 2;
pub const CU_AD_FORMAT_UNSIGNED_INT32: c_int = 3;
pub const CU_AD_FORMAT_SIGNED_INT8: c_int = 8;
pub const CU_AD_FORMAT_SIGNED_INT16: c_int = 9;
pub const CU_AD_FORMAT_SIGNED_INT32: c_int = 10;
pub const CU_AD_FORMAT_HALF: c_int = 16;
pub const CU_AD_FORMAT_FLOAT: c_int = 32;
pub const CU_AD_FORMAT_NV12: c_int = 176;
pub const CU_AD_FORMAT_UNORM_INT8X1: c_int = 192;
pub const CU_AD_FORMAT_UNORM_INT8X2: c_int = 193;
pub const CU_AD_FORMAT_UNORM_INT8X4: c_int = 194;
pub const CU_AD_FORMAT_UNORM_INT16X1: c_int = 195;
pub const CU_AD_FORMAT_UNORM_INT16X2: c_int = 196;
pub const CU_AD_FORMAT_UNORM_INT16X4: c_int = 197;
pub const CU_AD_FORMAT_SNORM_INT8X1: c_int = 198;
pub const CU_AD_FORMAT_SNORM_INT8X2: c_int = 199;
pub const CU_AD_FORMAT_SNORM_INT8X4: c_int = 200;
pub const CU_AD_FORMAT_SNORM_INT16X1: c_int = 201;
pub const CU_AD_FORMAT_SNORM_INT16X2: c_int = 202;
pub const CU_AD_FORMAT_SNORM_INT16X4: c_int = 203;
pub const CU_AD_FORMAT_BC1_UNORM: c_int = 145;
pub const CU_AD_FORMAT_BC1_UNORM_SRGB: c_int = 146;
pub const CU_AD_FORMAT_BC2_UNORM: c_int = 147;
pub const CU_AD_FORMAT_BC2_UNORM_SRGB: c_int = 148;
pub const CU_AD_FORMAT_BC3_UNORM: c_int = 149;
pub const CU_AD_FORMAT_BC3_UNORM_SRGB: c_int = 150;
pub const CU_AD_FORMAT_BC4_UNORM: c_int = 151;
pub const CU_AD_FORMAT_BC4_SNORM: c_int = 152;
pub const CU_AD_FORMAT_BC5_UNORM: c_int = 153;
pub const CU_AD_FORMAT_BC5_SNORM: c_int = 154;
pub const CU_AD_FORMAT_BC6H_UF16: c_int = 155;
pub const CU_AD_FORMAT_BC6H_SF16: c_int = 156;
pub const CU_AD_FORMAT_BC7_UNORM: c_int = 157;
pub const CU_AD_FORMAT_BC7_UNORM_SRGB: c_int = 158;
pub const CU_AD_FORMAT_P010: c_int = 159;
pub const CU_AD_FORMAT_P016: c_int = 161;
pub const CU_AD_FORMAT_NV16: c_int = 162;
pub const CU_AD_FORMAT_P210: c_int = 163;
pub const CU_AD_FORMAT_P216: c_int = 164;
pub const CU_AD_FORMAT_YUY2: c_int = 165;
pub const CU_AD_FORMAT_Y210: c_int = 166;
pub const CU_AD_FORMAT_Y216: c_int = 167;
pub const CU_AD_FORMAT_AYUV: c_int = 168;
pub const CU_AD_FORMAT_Y410: c_int = 169;
pub const CU_AD_FORMAT_Y416: c_int = 177;
pub const CU_AD_FORMAT_Y444_PLANAR8: c_int = 178;
pub const CU_AD_FORMAT_Y444_PLANAR10: c_int = 179;
pub const CU_AD_FORMAT_YUV444_8bit_SemiPlanar: c_int = 180;
pub const CU_AD_FORMAT_YUV444_16bit_SemiPlanar: c_int = 181;
pub const CU_AD_FORMAT_UNORM_INT_101010_2: c_int = 80;
pub const CU_AD_FORMAT_UINT8_PACKED_422: c_int = 81;
pub const CU_AD_FORMAT_UINT8_PACKED_444: c_int = 82;
pub const CU_AD_FORMAT_UINT8_SEMIPLANAR_420: c_int = 83;
pub const CU_AD_FORMAT_UINT16_SEMIPLANAR_420: c_int = 84;
pub const CU_AD_FORMAT_UINT8_SEMIPLANAR_422: c_int = 85;
pub const CU_AD_FORMAT_UINT16_SEMIPLANAR_422: c_int = 86;
pub const CU_AD_FORMAT_UINT8_SEMIPLANAR_444: c_int = 87;
pub const CU_AD_FORMAT_UINT16_SEMIPLANAR_444: c_int = 88;
pub const CU_AD_FORMAT_UINT8_PLANAR_420: c_int = 89;
pub const CU_AD_FORMAT_UINT16_PLANAR_420: c_int = 90;
pub const CU_AD_FORMAT_UINT8_PLANAR_422: c_int = 91;
pub const CU_AD_FORMAT_UINT16_PLANAR_422: c_int = 92;
pub const CU_AD_FORMAT_UINT8_PLANAR_444: c_int = 93;
pub const CU_AD_FORMAT_UINT16_PLANAR_444: c_int = 94;
pub const CU_AD_FORMAT_MAX: c_int = 2147483647;
pub const enum_CUarray_format_enum = c_uint;
pub const CUarray_format = enum_CUarray_format_enum;
pub const CU_TR_ADDRESS_MODE_WRAP: c_int = 0;
pub const CU_TR_ADDRESS_MODE_CLAMP: c_int = 1;
pub const CU_TR_ADDRESS_MODE_MIRROR: c_int = 2;
pub const CU_TR_ADDRESS_MODE_BORDER: c_int = 3;
pub const enum_CUaddress_mode_enum = c_uint;
pub const CUaddress_mode = enum_CUaddress_mode_enum;
pub const CU_TR_FILTER_MODE_POINT: c_int = 0;
pub const CU_TR_FILTER_MODE_LINEAR: c_int = 1;
pub const enum_CUfilter_mode_enum = c_uint;
pub const CUfilter_mode = enum_CUfilter_mode_enum;
pub const CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK: c_int = 1;
pub const CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X: c_int = 2;
pub const CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y: c_int = 3;
pub const CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z: c_int = 4;
pub const CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X: c_int = 5;
pub const CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y: c_int = 6;
pub const CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z: c_int = 7;
pub const CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK: c_int = 8;
pub const CU_DEVICE_ATTRIBUTE_SHARED_MEMORY_PER_BLOCK: c_int = 8;
pub const CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY: c_int = 9;
pub const CU_DEVICE_ATTRIBUTE_WARP_SIZE: c_int = 10;
pub const CU_DEVICE_ATTRIBUTE_MAX_PITCH: c_int = 11;
pub const CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_BLOCK: c_int = 12;
pub const CU_DEVICE_ATTRIBUTE_REGISTERS_PER_BLOCK: c_int = 12;
pub const CU_DEVICE_ATTRIBUTE_CLOCK_RATE: c_int = 13;
pub const CU_DEVICE_ATTRIBUTE_TEXTURE_ALIGNMENT: c_int = 14;
pub const CU_DEVICE_ATTRIBUTE_GPU_OVERLAP: c_int = 15;
pub const CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT: c_int = 16;
pub const CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT: c_int = 17;
pub const CU_DEVICE_ATTRIBUTE_INTEGRATED: c_int = 18;
pub const CU_DEVICE_ATTRIBUTE_CAN_MAP_HOST_MEMORY: c_int = 19;
pub const CU_DEVICE_ATTRIBUTE_COMPUTE_MODE: c_int = 20;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_WIDTH: c_int = 21;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_WIDTH: c_int = 22;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_HEIGHT: c_int = 23;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH: c_int = 24;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT: c_int = 25;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH: c_int = 26;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_WIDTH: c_int = 27;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_HEIGHT: c_int = 28;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_LAYERS: c_int = 29;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_WIDTH: c_int = 27;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_HEIGHT: c_int = 28;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_NUMSLICES: c_int = 29;
pub const CU_DEVICE_ATTRIBUTE_SURFACE_ALIGNMENT: c_int = 30;
pub const CU_DEVICE_ATTRIBUTE_CONCURRENT_KERNELS: c_int = 31;
pub const CU_DEVICE_ATTRIBUTE_ECC_ENABLED: c_int = 32;
pub const CU_DEVICE_ATTRIBUTE_PCI_BUS_ID: c_int = 33;
pub const CU_DEVICE_ATTRIBUTE_PCI_DEVICE_ID: c_int = 34;
pub const CU_DEVICE_ATTRIBUTE_TCC_DRIVER: c_int = 35;
pub const CU_DEVICE_ATTRIBUTE_MEMORY_CLOCK_RATE: c_int = 36;
pub const CU_DEVICE_ATTRIBUTE_GLOBAL_MEMORY_BUS_WIDTH: c_int = 37;
pub const CU_DEVICE_ATTRIBUTE_L2_CACHE_SIZE: c_int = 38;
pub const CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR: c_int = 39;
pub const CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT: c_int = 40;
pub const CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING: c_int = 41;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_WIDTH: c_int = 42;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_LAYERS: c_int = 43;
pub const CU_DEVICE_ATTRIBUTE_CAN_TEX2D_GATHER: c_int = 44;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_WIDTH: c_int = 45;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_HEIGHT: c_int = 46;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH_ALTERNATE: c_int = 47;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT_ALTERNATE: c_int = 48;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH_ALTERNATE: c_int = 49;
pub const CU_DEVICE_ATTRIBUTE_PCI_DOMAIN_ID: c_int = 50;
pub const CU_DEVICE_ATTRIBUTE_TEXTURE_PITCH_ALIGNMENT: c_int = 51;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_WIDTH: c_int = 52;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_WIDTH: c_int = 53;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_LAYERS: c_int = 54;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_WIDTH: c_int = 55;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_WIDTH: c_int = 56;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_HEIGHT: c_int = 57;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_WIDTH: c_int = 58;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_HEIGHT: c_int = 59;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_DEPTH: c_int = 60;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_WIDTH: c_int = 61;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_LAYERS: c_int = 62;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_WIDTH: c_int = 63;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_HEIGHT: c_int = 64;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_LAYERS: c_int = 65;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_WIDTH: c_int = 66;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_WIDTH: c_int = 67;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_LAYERS: c_int = 68;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LINEAR_WIDTH: c_int = 69;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_WIDTH: c_int = 70;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_HEIGHT: c_int = 71;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_PITCH: c_int = 72;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_WIDTH: c_int = 73;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_HEIGHT: c_int = 74;
pub const CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR: c_int = 75;
pub const CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR: c_int = 76;
pub const CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_MIPMAPPED_WIDTH: c_int = 77;
pub const CU_DEVICE_ATTRIBUTE_STREAM_PRIORITIES_SUPPORTED: c_int = 78;
pub const CU_DEVICE_ATTRIBUTE_GLOBAL_L1_CACHE_SUPPORTED: c_int = 79;
pub const CU_DEVICE_ATTRIBUTE_LOCAL_L1_CACHE_SUPPORTED: c_int = 80;
pub const CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_MULTIPROCESSOR: c_int = 81;
pub const CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_MULTIPROCESSOR: c_int = 82;
pub const CU_DEVICE_ATTRIBUTE_MANAGED_MEMORY: c_int = 83;
pub const CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD: c_int = 84;
pub const CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD_GROUP_ID: c_int = 85;
pub const CU_DEVICE_ATTRIBUTE_HOST_NATIVE_ATOMIC_SUPPORTED: c_int = 86;
pub const CU_DEVICE_ATTRIBUTE_SINGLE_TO_DOUBLE_PRECISION_PERF_RATIO: c_int = 87;
pub const CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS: c_int = 88;
pub const CU_DEVICE_ATTRIBUTE_CONCURRENT_MANAGED_ACCESS: c_int = 89;
pub const CU_DEVICE_ATTRIBUTE_COMPUTE_PREEMPTION_SUPPORTED: c_int = 90;
pub const CU_DEVICE_ATTRIBUTE_CAN_USE_HOST_POINTER_FOR_REGISTERED_MEM: c_int = 91;
pub const CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_MEM_OPS_V1: c_int = 92;
pub const CU_DEVICE_ATTRIBUTE_CAN_USE_64_BIT_STREAM_MEM_OPS_V1: c_int = 93;
pub const CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_WAIT_VALUE_NOR_V1: c_int = 94;
pub const CU_DEVICE_ATTRIBUTE_COOPERATIVE_LAUNCH: c_int = 95;
pub const CU_DEVICE_ATTRIBUTE_COOPERATIVE_MULTI_DEVICE_LAUNCH: c_int = 96;
pub const CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK_OPTIN: c_int = 97;
pub const CU_DEVICE_ATTRIBUTE_CAN_FLUSH_REMOTE_WRITES: c_int = 98;
pub const CU_DEVICE_ATTRIBUTE_HOST_REGISTER_SUPPORTED: c_int = 99;
pub const CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS_USES_HOST_PAGE_TABLES: c_int = 100;
pub const CU_DEVICE_ATTRIBUTE_DIRECT_MANAGED_MEM_ACCESS_FROM_HOST: c_int = 101;
pub const CU_DEVICE_ATTRIBUTE_VIRTUAL_ADDRESS_MANAGEMENT_SUPPORTED: c_int = 102;
pub const CU_DEVICE_ATTRIBUTE_VIRTUAL_MEMORY_MANAGEMENT_SUPPORTED: c_int = 102;
pub const CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_POSIX_FILE_DESCRIPTOR_SUPPORTED: c_int = 103;
pub const CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_WIN32_HANDLE_SUPPORTED: c_int = 104;
pub const CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_WIN32_KMT_HANDLE_SUPPORTED: c_int = 105;
pub const CU_DEVICE_ATTRIBUTE_MAX_BLOCKS_PER_MULTIPROCESSOR: c_int = 106;
pub const CU_DEVICE_ATTRIBUTE_GENERIC_COMPRESSION_SUPPORTED: c_int = 107;
pub const CU_DEVICE_ATTRIBUTE_MAX_PERSISTING_L2_CACHE_SIZE: c_int = 108;
pub const CU_DEVICE_ATTRIBUTE_MAX_ACCESS_POLICY_WINDOW_SIZE: c_int = 109;
pub const CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_WITH_CUDA_VMM_SUPPORTED: c_int = 110;
pub const CU_DEVICE_ATTRIBUTE_RESERVED_SHARED_MEMORY_PER_BLOCK: c_int = 111;
pub const CU_DEVICE_ATTRIBUTE_SPARSE_CUDA_ARRAY_SUPPORTED: c_int = 112;
pub const CU_DEVICE_ATTRIBUTE_READ_ONLY_HOST_REGISTER_SUPPORTED: c_int = 113;
pub const CU_DEVICE_ATTRIBUTE_TIMELINE_SEMAPHORE_INTEROP_SUPPORTED: c_int = 114;
pub const CU_DEVICE_ATTRIBUTE_MEMORY_POOLS_SUPPORTED: c_int = 115;
pub const CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_SUPPORTED: c_int = 116;
pub const CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_FLUSH_WRITES_OPTIONS: c_int = 117;
pub const CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_WRITES_ORDERING: c_int = 118;
pub const CU_DEVICE_ATTRIBUTE_MEMPOOL_SUPPORTED_HANDLE_TYPES: c_int = 119;
pub const CU_DEVICE_ATTRIBUTE_CLUSTER_LAUNCH: c_int = 120;
pub const CU_DEVICE_ATTRIBUTE_DEFERRED_MAPPING_CUDA_ARRAY_SUPPORTED: c_int = 121;
pub const CU_DEVICE_ATTRIBUTE_CAN_USE_64_BIT_STREAM_MEM_OPS: c_int = 122;
pub const CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_WAIT_VALUE_NOR: c_int = 123;
pub const CU_DEVICE_ATTRIBUTE_DMA_BUF_SUPPORTED: c_int = 124;
pub const CU_DEVICE_ATTRIBUTE_IPC_EVENT_SUPPORTED: c_int = 125;
pub const CU_DEVICE_ATTRIBUTE_MEM_SYNC_DOMAIN_COUNT: c_int = 126;
pub const CU_DEVICE_ATTRIBUTE_TENSOR_MAP_ACCESS_SUPPORTED: c_int = 127;
pub const CU_DEVICE_ATTRIBUTE_HANDLE_TYPE_FABRIC_SUPPORTED: c_int = 128;
pub const CU_DEVICE_ATTRIBUTE_UNIFIED_FUNCTION_POINTERS: c_int = 129;
pub const CU_DEVICE_ATTRIBUTE_NUMA_CONFIG: c_int = 130;
pub const CU_DEVICE_ATTRIBUTE_NUMA_ID: c_int = 131;
pub const CU_DEVICE_ATTRIBUTE_MULTICAST_SUPPORTED: c_int = 132;
pub const CU_DEVICE_ATTRIBUTE_MPS_ENABLED: c_int = 133;
pub const CU_DEVICE_ATTRIBUTE_HOST_NUMA_ID: c_int = 134;
pub const CU_DEVICE_ATTRIBUTE_D3D12_CIG_SUPPORTED: c_int = 135;
pub const CU_DEVICE_ATTRIBUTE_MEM_DECOMPRESS_ALGORITHM_MASK: c_int = 136;
pub const CU_DEVICE_ATTRIBUTE_MEM_DECOMPRESS_MAXIMUM_LENGTH: c_int = 137;
pub const CU_DEVICE_ATTRIBUTE_VULKAN_CIG_SUPPORTED: c_int = 138;
pub const CU_DEVICE_ATTRIBUTE_GPU_PCI_DEVICE_ID: c_int = 139;
pub const CU_DEVICE_ATTRIBUTE_GPU_PCI_SUBSYSTEM_ID: c_int = 140;
pub const CU_DEVICE_ATTRIBUTE_HOST_NUMA_VIRTUAL_MEMORY_MANAGEMENT_SUPPORTED: c_int = 141;
pub const CU_DEVICE_ATTRIBUTE_HOST_NUMA_MEMORY_POOLS_SUPPORTED: c_int = 142;
pub const CU_DEVICE_ATTRIBUTE_HOST_NUMA_MULTINODE_IPC_SUPPORTED: c_int = 143;
pub const CU_DEVICE_ATTRIBUTE_HOST_MEMORY_POOLS_SUPPORTED: c_int = 144;
pub const CU_DEVICE_ATTRIBUTE_HOST_VIRTUAL_MEMORY_MANAGEMENT_SUPPORTED: c_int = 145;
pub const CU_DEVICE_ATTRIBUTE_HOST_ALLOC_DMA_BUF_SUPPORTED: c_int = 146;
pub const CU_DEVICE_ATTRIBUTE_ONLY_PARTIAL_HOST_NATIVE_ATOMIC_SUPPORTED: c_int = 147;
pub const CU_DEVICE_ATTRIBUTE_ATOMIC_REDUCTION_SUPPORTED: c_int = 148;
pub const CU_DEVICE_ATTRIBUTE_LOCALITY_DOMAIN_COUNT: c_int = 149;
pub const CU_DEVICE_ATTRIBUTE_MAX_OVERSIZED_SHARED_MEMORY_PER_BLOCK: c_int = 150;
pub const CU_DEVICE_ATTRIBUTE_D3D12_CIG_STREAMS_SUPPORTED: c_int = 151;
pub const CU_DEVICE_ATTRIBUTE_DMA_BUF_MMAP_SUPPORTED: c_int = 152;
pub const CU_DEVICE_ATTRIBUTE_LOGICAL_ENDPOINT_UNICAST_SUPPORTED: c_int = 153;
pub const CU_DEVICE_ATTRIBUTE_LOGICAL_ENDPOINT_MULTICAST_SUPPORTED: c_int = 154;
pub const CU_DEVICE_ATTRIBUTE_LOGICAL_ENDPOINT_COUNTED_OPS_SUPPORTED: c_int = 155;
pub const CU_DEVICE_ATTRIBUTE_LOGICAL_ENDPOINT_UNICAST_ACCESS_ON_OWNER_DEVICE_SUPPORTED: c_int = 156;
pub const CU_DEVICE_ATTRIBUTE_LOCALITY_DOMAIN_MULTIPROCESSOR_COUNT: c_int = 157;
pub const CU_DEVICE_ATTRIBUTE_LOGICAL_ENDPOINT_SUPPORTED_HANDLE_TYPES: c_int = 158;
pub const CU_DEVICE_ATTRIBUTE_GPU_DIRECT_RDMA_WITH_LOCALIZED_MEMORY_SUPPORTED: c_int = 161;
pub const CU_DEVICE_ATTRIBUTE_MAX: c_int = 162;
pub const enum_CUdevice_attribute_enum = c_uint;
pub const CUdevice_attribute = enum_CUdevice_attribute_enum;
pub const struct_CUdevprop_st = extern struct {
    maxThreadsPerBlock: c_int = 0,
    maxThreadsDim: [3]c_int = @import("std").mem.zeroes([3]c_int),
    maxGridSize: [3]c_int = @import("std").mem.zeroes([3]c_int),
    sharedMemPerBlock: c_int = 0,
    totalConstantMemory: c_int = 0,
    SIMDWidth: c_int = 0,
    memPitch: c_int = 0,
    regsPerBlock: c_int = 0,
    clockRate: c_int = 0,
    textureAlign: c_int = 0,
    pub const cuDeviceGetProperties = __root.cuDeviceGetProperties;
};
pub const CUdevprop_v1 = struct_CUdevprop_st;
pub const CUdevprop = CUdevprop_v1;
pub const CU_POINTER_ATTRIBUTE_CONTEXT: c_int = 1;
pub const CU_POINTER_ATTRIBUTE_MEMORY_TYPE: c_int = 2;
pub const CU_POINTER_ATTRIBUTE_DEVICE_POINTER: c_int = 3;
pub const CU_POINTER_ATTRIBUTE_HOST_POINTER: c_int = 4;
pub const CU_POINTER_ATTRIBUTE_P2P_TOKENS: c_int = 5;
pub const CU_POINTER_ATTRIBUTE_SYNC_MEMOPS: c_int = 6;
pub const CU_POINTER_ATTRIBUTE_BUFFER_ID: c_int = 7;
pub const CU_POINTER_ATTRIBUTE_IS_MANAGED: c_int = 8;
pub const CU_POINTER_ATTRIBUTE_DEVICE_ORDINAL: c_int = 9;
pub const CU_POINTER_ATTRIBUTE_IS_LEGACY_CUDA_IPC_CAPABLE: c_int = 10;
pub const CU_POINTER_ATTRIBUTE_RANGE_START_ADDR: c_int = 11;
pub const CU_POINTER_ATTRIBUTE_RANGE_SIZE: c_int = 12;
pub const CU_POINTER_ATTRIBUTE_MAPPED: c_int = 13;
pub const CU_POINTER_ATTRIBUTE_ALLOWED_HANDLE_TYPES: c_int = 14;
pub const CU_POINTER_ATTRIBUTE_IS_GPU_DIRECT_RDMA_CAPABLE: c_int = 15;
pub const CU_POINTER_ATTRIBUTE_ACCESS_FLAGS: c_int = 16;
pub const CU_POINTER_ATTRIBUTE_MEMPOOL_HANDLE: c_int = 17;
pub const CU_POINTER_ATTRIBUTE_MAPPING_SIZE: c_int = 18;
pub const CU_POINTER_ATTRIBUTE_MAPPING_BASE_ADDR: c_int = 19;
pub const CU_POINTER_ATTRIBUTE_MEMORY_BLOCK_ID: c_int = 20;
pub const CU_POINTER_ATTRIBUTE_IS_HW_DECOMPRESS_CAPABLE: c_int = 21;
pub const CU_POINTER_ATTRIBUTE_LOCALITY_DOMAIN_ORDINAL: c_int = 22;
pub const enum_CUpointer_attribute_enum = c_uint;
pub const CUpointer_attribute = enum_CUpointer_attribute_enum;
pub const CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK: c_int = 0;
pub const CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES: c_int = 1;
pub const CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES: c_int = 2;
pub const CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES: c_int = 3;
pub const CU_FUNC_ATTRIBUTE_NUM_REGS: c_int = 4;
pub const CU_FUNC_ATTRIBUTE_PTX_VERSION: c_int = 5;
pub const CU_FUNC_ATTRIBUTE_BINARY_VERSION: c_int = 6;
pub const CU_FUNC_ATTRIBUTE_CACHE_MODE_CA: c_int = 7;
pub const CU_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES: c_int = 8;
pub const CU_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT: c_int = 9;
pub const CU_FUNC_ATTRIBUTE_CLUSTER_SIZE_MUST_BE_SET: c_int = 10;
pub const CU_FUNC_ATTRIBUTE_REQUIRED_CLUSTER_WIDTH: c_int = 11;
pub const CU_FUNC_ATTRIBUTE_REQUIRED_CLUSTER_HEIGHT: c_int = 12;
pub const CU_FUNC_ATTRIBUTE_REQUIRED_CLUSTER_DEPTH: c_int = 13;
pub const CU_FUNC_ATTRIBUTE_NON_PORTABLE_CLUSTER_SIZE_ALLOWED: c_int = 14;
pub const CU_FUNC_ATTRIBUTE_CLUSTER_SCHEDULING_POLICY_PREFERENCE: c_int = 15;
pub const CU_FUNC_ATTRIBUTE_DEVICE_NODE_UPDATE_SUPPORTED: c_int = 16;
pub const CU_FUNC_ATTRIBUTE_SHARED_MEMORY_MODE: c_int = 17;
pub const CU_FUNC_ATTRIBUTE_MAX: c_int = 18;
pub const enum_CUfunction_attribute_enum = c_uint;
pub const CUfunction_attribute = enum_CUfunction_attribute_enum;
pub const CU_FUNC_CACHE_PREFER_NONE: c_int = 0;
pub const CU_FUNC_CACHE_PREFER_SHARED: c_int = 1;
pub const CU_FUNC_CACHE_PREFER_L1: c_int = 2;
pub const CU_FUNC_CACHE_PREFER_EQUAL: c_int = 3;
pub const enum_CUfunc_cache_enum = c_uint;
pub const CUfunc_cache = enum_CUfunc_cache_enum;
pub const CU_SHARED_MEM_CONFIG_DEFAULT_BANK_SIZE: c_int = 0;
pub const CU_SHARED_MEM_CONFIG_FOUR_BYTE_BANK_SIZE: c_int = 1;
pub const CU_SHARED_MEM_CONFIG_EIGHT_BYTE_BANK_SIZE: c_int = 2;
pub const enum_CUsharedconfig_enum = c_uint;
pub const CUsharedconfig = enum_CUsharedconfig_enum;
pub const CU_SHAREDMEM_CARVEOUT_DEFAULT: c_int = -1;
pub const CU_SHAREDMEM_CARVEOUT_MAX_SHARED: c_int = 100;
pub const CU_SHAREDMEM_CARVEOUT_MAX_L1: c_int = 0;
pub const enum_CUshared_carveout_enum = c_int;
pub const CUshared_carveout = enum_CUshared_carveout_enum;
pub const CU_MEMORYTYPE_HOST: c_int = 1;
pub const CU_MEMORYTYPE_DEVICE: c_int = 2;
pub const CU_MEMORYTYPE_ARRAY: c_int = 3;
pub const CU_MEMORYTYPE_UNIFIED: c_int = 4;
pub const enum_CUmemorytype_enum = c_uint;
pub const CUmemorytype = enum_CUmemorytype_enum;
pub const CU_COMPUTEMODE_DEFAULT: c_int = 0;
pub const CU_COMPUTEMODE_PROHIBITED: c_int = 2;
pub const CU_COMPUTEMODE_EXCLUSIVE_PROCESS: c_int = 3;
pub const enum_CUcomputemode_enum = c_uint;
pub const CUcomputemode = enum_CUcomputemode_enum;
pub const CU_MEM_ADVISE_SET_READ_MOSTLY: c_int = 1;
pub const CU_MEM_ADVISE_UNSET_READ_MOSTLY: c_int = 2;
pub const CU_MEM_ADVISE_SET_PREFERRED_LOCATION: c_int = 3;
pub const CU_MEM_ADVISE_UNSET_PREFERRED_LOCATION: c_int = 4;
pub const CU_MEM_ADVISE_SET_ACCESSED_BY: c_int = 5;
pub const CU_MEM_ADVISE_UNSET_ACCESSED_BY: c_int = 6;
pub const enum_CUmem_advise_enum = c_uint;
pub const CUmem_advise = enum_CUmem_advise_enum;
pub const CU_MEM_RANGE_ATTRIBUTE_READ_MOSTLY: c_int = 1;
pub const CU_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION: c_int = 2;
pub const CU_MEM_RANGE_ATTRIBUTE_ACCESSED_BY: c_int = 3;
pub const CU_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION: c_int = 4;
pub const CU_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION_TYPE: c_int = 5;
pub const CU_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION_ID: c_int = 6;
pub const CU_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION_TYPE: c_int = 7;
pub const CU_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION_ID: c_int = 8;
pub const enum_CUmem_range_attribute_enum = c_uint;
pub const CUmem_range_attribute = enum_CUmem_range_attribute_enum;
pub const CU_JIT_MAX_REGISTERS: c_int = 0;
pub const CU_JIT_THREADS_PER_BLOCK: c_int = 1;
pub const CU_JIT_WALL_TIME: c_int = 2;
pub const CU_JIT_INFO_LOG_BUFFER: c_int = 3;
pub const CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES: c_int = 4;
pub const CU_JIT_ERROR_LOG_BUFFER: c_int = 5;
pub const CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES: c_int = 6;
pub const CU_JIT_OPTIMIZATION_LEVEL: c_int = 7;
pub const CU_JIT_TARGET_FROM_CUCONTEXT: c_int = 8;
pub const CU_JIT_TARGET: c_int = 9;
pub const CU_JIT_FALLBACK_STRATEGY: c_int = 10;
pub const CU_JIT_GENERATE_DEBUG_INFO: c_int = 11;
pub const CU_JIT_LOG_VERBOSE: c_int = 12;
pub const CU_JIT_GENERATE_LINE_INFO: c_int = 13;
pub const CU_JIT_CACHE_MODE: c_int = 14;
pub const CU_JIT_NEW_SM3X_OPT: c_int = 15;
pub const CU_JIT_FAST_COMPILE: c_int = 16;
pub const CU_JIT_GLOBAL_SYMBOL_NAMES: c_int = 17;
pub const CU_JIT_GLOBAL_SYMBOL_ADDRESSES: c_int = 18;
pub const CU_JIT_GLOBAL_SYMBOL_COUNT: c_int = 19;
pub const CU_JIT_LTO: c_int = 20;
pub const CU_JIT_FTZ: c_int = 21;
pub const CU_JIT_PREC_DIV: c_int = 22;
pub const CU_JIT_PREC_SQRT: c_int = 23;
pub const CU_JIT_FMA: c_int = 24;
pub const CU_JIT_REFERENCED_KERNEL_NAMES: c_int = 25;
pub const CU_JIT_REFERENCED_KERNEL_COUNT: c_int = 26;
pub const CU_JIT_REFERENCED_VARIABLE_NAMES: c_int = 27;
pub const CU_JIT_REFERENCED_VARIABLE_COUNT: c_int = 28;
pub const CU_JIT_OPTIMIZE_UNUSED_DEVICE_VARIABLES: c_int = 29;
pub const CU_JIT_POSITION_INDEPENDENT_CODE: c_int = 30;
pub const CU_JIT_MIN_CTA_PER_SM: c_int = 31;
pub const CU_JIT_MAX_THREADS_PER_BLOCK: c_int = 32;
pub const CU_JIT_OVERRIDE_DIRECTIVE_VALUES: c_int = 33;
pub const CU_JIT_SPLIT_COMPILE: c_int = 34;
pub const CU_JIT_BINARY_LOADER_THREAD_COUNT: c_int = 35;
pub const CU_JIT_NUM_OPTIONS: c_int = 36;
pub const enum_CUjit_option_enum = c_uint;
pub const CUjit_option = enum_CUjit_option_enum;
pub const CU_TARGET_COMPUTE_30: c_int = 30;
pub const CU_TARGET_COMPUTE_32: c_int = 32;
pub const CU_TARGET_COMPUTE_35: c_int = 35;
pub const CU_TARGET_COMPUTE_37: c_int = 37;
pub const CU_TARGET_COMPUTE_50: c_int = 50;
pub const CU_TARGET_COMPUTE_52: c_int = 52;
pub const CU_TARGET_COMPUTE_53: c_int = 53;
pub const CU_TARGET_COMPUTE_60: c_int = 60;
pub const CU_TARGET_COMPUTE_61: c_int = 61;
pub const CU_TARGET_COMPUTE_62: c_int = 62;
pub const CU_TARGET_COMPUTE_70: c_int = 70;
pub const CU_TARGET_COMPUTE_72: c_int = 72;
pub const CU_TARGET_COMPUTE_75: c_int = 75;
pub const CU_TARGET_COMPUTE_80: c_int = 80;
pub const CU_TARGET_COMPUTE_86: c_int = 86;
pub const CU_TARGET_COMPUTE_87: c_int = 87;
pub const CU_TARGET_COMPUTE_89: c_int = 89;
pub const CU_TARGET_COMPUTE_90: c_int = 90;
pub const CU_TARGET_COMPUTE_100: c_int = 100;
pub const CU_TARGET_COMPUTE_110: c_int = 110;
pub const CU_TARGET_COMPUTE_103: c_int = 103;
pub const CU_TARGET_COMPUTE_107: c_int = 107;
pub const CU_TARGET_COMPUTE_120: c_int = 120;
pub const CU_TARGET_COMPUTE_121: c_int = 121;
pub const CU_TARGET_COMPUTE_90A: c_int = 65626;
pub const CU_TARGET_COMPUTE_100A: c_int = 65636;
pub const CU_TARGET_COMPUTE_110A: c_int = 65646;
pub const CU_TARGET_COMPUTE_103A: c_int = 65639;
pub const CU_TARGET_COMPUTE_107A: c_int = 65643;
pub const CU_TARGET_COMPUTE_120A: c_int = 65656;
pub const CU_TARGET_COMPUTE_121A: c_int = 65657;
pub const CU_TARGET_COMPUTE_100F: c_int = 131172;
pub const CU_TARGET_COMPUTE_110F: c_int = 131182;
pub const CU_TARGET_COMPUTE_103F: c_int = 131175;
pub const CU_TARGET_COMPUTE_107F: c_int = 131179;
pub const CU_TARGET_COMPUTE_120F: c_int = 131192;
pub const CU_TARGET_COMPUTE_121F: c_int = 131193;
pub const enum_CUjit_target_enum = c_uint;
pub const CUjit_target = enum_CUjit_target_enum;
pub const CU_PREFER_PTX: c_int = 0;
pub const CU_PREFER_BINARY: c_int = 1;
pub const enum_CUjit_fallback_enum = c_uint;
pub const CUjit_fallback = enum_CUjit_fallback_enum;
pub const CU_JIT_CACHE_OPTION_NONE: c_int = 0;
pub const CU_JIT_CACHE_OPTION_CG: c_int = 1;
pub const CU_JIT_CACHE_OPTION_CA: c_int = 2;
pub const enum_CUjit_cacheMode_enum = c_uint;
pub const CUjit_cacheMode = enum_CUjit_cacheMode_enum;
pub const CU_JIT_INPUT_CUBIN: c_int = 0;
pub const CU_JIT_INPUT_PTX: c_int = 1;
pub const CU_JIT_INPUT_FATBINARY: c_int = 2;
pub const CU_JIT_INPUT_OBJECT: c_int = 3;
pub const CU_JIT_INPUT_LIBRARY: c_int = 4;
pub const CU_JIT_INPUT_NVVM: c_int = 5;
pub const CU_JIT_NUM_INPUT_TYPES: c_int = 6;
pub const enum_CUjitInputType_enum = c_uint;
pub const CUjitInputType = enum_CUjitInputType_enum;
pub const struct_CUlinkState_st = opaque {
    pub const cuLinkAddData_v2 = __root.cuLinkAddData_v2;
    pub const cuLinkAddFile_v2 = __root.cuLinkAddFile_v2;
    pub const cuLinkComplete = __root.cuLinkComplete;
    pub const cuLinkDestroy = __root.cuLinkDestroy;
    pub const v2 = __root.cuLinkAddData_v2;
};
pub const CUlinkState = ?*struct_CUlinkState_st;
pub const CU_GRAPHICS_REGISTER_FLAGS_NONE: c_int = 0;
pub const CU_GRAPHICS_REGISTER_FLAGS_READ_ONLY: c_int = 1;
pub const CU_GRAPHICS_REGISTER_FLAGS_WRITE_DISCARD: c_int = 2;
pub const CU_GRAPHICS_REGISTER_FLAGS_SURFACE_LDST: c_int = 4;
pub const CU_GRAPHICS_REGISTER_FLAGS_TEXTURE_GATHER: c_int = 8;
pub const enum_CUgraphicsRegisterFlags_enum = c_uint;
pub const CUgraphicsRegisterFlags = enum_CUgraphicsRegisterFlags_enum;
pub const CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE: c_int = 0;
pub const CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY: c_int = 1;
pub const CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD: c_int = 2;
pub const enum_CUgraphicsMapResourceFlags_enum = c_uint;
pub const CUgraphicsMapResourceFlags = enum_CUgraphicsMapResourceFlags_enum;
pub const CU_CUBEMAP_FACE_POSITIVE_X: c_int = 0;
pub const CU_CUBEMAP_FACE_NEGATIVE_X: c_int = 1;
pub const CU_CUBEMAP_FACE_POSITIVE_Y: c_int = 2;
pub const CU_CUBEMAP_FACE_NEGATIVE_Y: c_int = 3;
pub const CU_CUBEMAP_FACE_POSITIVE_Z: c_int = 4;
pub const CU_CUBEMAP_FACE_NEGATIVE_Z: c_int = 5;
pub const enum_CUarray_cubemap_face_enum = c_uint;
pub const CUarray_cubemap_face = enum_CUarray_cubemap_face_enum;
pub const CU_LIMIT_STACK_SIZE: c_int = 0;
pub const CU_LIMIT_PRINTF_FIFO_SIZE: c_int = 1;
pub const CU_LIMIT_MALLOC_HEAP_SIZE: c_int = 2;
pub const CU_LIMIT_DEV_RUNTIME_SYNC_DEPTH: c_int = 3;
pub const CU_LIMIT_DEV_RUNTIME_PENDING_LAUNCH_COUNT: c_int = 4;
pub const CU_LIMIT_MAX_L2_FETCH_GRANULARITY: c_int = 5;
pub const CU_LIMIT_PERSISTING_L2_CACHE_SIZE: c_int = 6;
pub const CU_LIMIT_SHMEM_SIZE: c_int = 7;
pub const CU_LIMIT_CIG_ENABLED: c_int = 8;
pub const CU_LIMIT_CIG_SHMEM_FALLBACK_ENABLED: c_int = 9;
pub const CU_LIMIT_PER_BLOCK_MEMORY_SIZE: c_int = 10;
pub const CU_LIMIT_MAX: c_int = 11;
pub const enum_CUlimit_enum = c_uint;
pub const CUlimit = enum_CUlimit_enum;
pub const CU_RESOURCE_TYPE_ARRAY: c_int = 0;
pub const CU_RESOURCE_TYPE_MIPMAPPED_ARRAY: c_int = 1;
pub const CU_RESOURCE_TYPE_LINEAR: c_int = 2;
pub const CU_RESOURCE_TYPE_PITCH2D: c_int = 3;
pub const enum_CUresourcetype_enum = c_uint;
pub const CUresourcetype = enum_CUresourcetype_enum;
pub const CUhostFn = ?*const fn (userData: ?*anyopaque) callconv(.c) void;
pub const CU_ACCESS_PROPERTY_NORMAL: c_int = 0;
pub const CU_ACCESS_PROPERTY_STREAMING: c_int = 1;
pub const CU_ACCESS_PROPERTY_PERSISTING: c_int = 2;
pub const enum_CUaccessProperty_enum = c_uint;
pub const CUaccessProperty = enum_CUaccessProperty_enum;
pub const struct_CUaccessPolicyWindow_st = extern struct {
    base_ptr: ?*anyopaque = null,
    num_bytes: usize = 0,
    hitRatio: f32 = 0,
    hitProp: CUaccessProperty = @import("std").mem.zeroes(CUaccessProperty),
    missProp: CUaccessProperty = @import("std").mem.zeroes(CUaccessProperty),
};
pub const CUaccessPolicyWindow_v1 = struct_CUaccessPolicyWindow_st;
pub const CUaccessPolicyWindow = CUaccessPolicyWindow_v1;
pub const struct_CUDA_KERNEL_NODE_PARAMS_st = extern struct {
    func: CUfunction = null,
    gridDimX: c_uint = 0,
    gridDimY: c_uint = 0,
    gridDimZ: c_uint = 0,
    blockDimX: c_uint = 0,
    blockDimY: c_uint = 0,
    blockDimZ: c_uint = 0,
    sharedMemBytes: c_uint = 0,
    kernelParams: [*c]?*anyopaque = null,
    extra: [*c]?*anyopaque = null,
};
pub const CUDA_KERNEL_NODE_PARAMS_v1 = struct_CUDA_KERNEL_NODE_PARAMS_st;
pub const struct_CUDA_KERNEL_NODE_PARAMS_v2_st = extern struct {
    func: CUfunction = null,
    gridDimX: c_uint = 0,
    gridDimY: c_uint = 0,
    gridDimZ: c_uint = 0,
    blockDimX: c_uint = 0,
    blockDimY: c_uint = 0,
    blockDimZ: c_uint = 0,
    sharedMemBytes: c_uint = 0,
    kernelParams: [*c]?*anyopaque = null,
    extra: [*c]?*anyopaque = null,
    kern: CUkernel = null,
    ctx: CUcontext = null,
};
pub const CUDA_KERNEL_NODE_PARAMS_v2 = struct_CUDA_KERNEL_NODE_PARAMS_v2_st;
pub const CUDA_KERNEL_NODE_PARAMS = CUDA_KERNEL_NODE_PARAMS_v2;
pub const struct_CUDA_KERNEL_NODE_PARAMS_v3_st = extern struct {
    func: CUfunction = null,
    gridDimX: c_uint = 0,
    gridDimY: c_uint = 0,
    gridDimZ: c_uint = 0,
    blockDimX: c_uint = 0,
    blockDimY: c_uint = 0,
    blockDimZ: c_uint = 0,
    sharedMemBytes: c_uint = 0,
    kernelParams: [*c]?*anyopaque = null,
    extra: [*c]?*anyopaque = null,
    kern: CUkernel = null,
    ctx: CUcontext = null,
};
pub const CUDA_KERNEL_NODE_PARAMS_v3 = struct_CUDA_KERNEL_NODE_PARAMS_v3_st;
pub const struct_CUDA_MEMSET_NODE_PARAMS_st = extern struct {
    dst: CUdeviceptr = 0,
    pitch: usize = 0,
    value: c_uint = 0,
    elementSize: c_uint = 0,
    width: usize = 0,
    height: usize = 0,
};
pub const CUDA_MEMSET_NODE_PARAMS_v1 = struct_CUDA_MEMSET_NODE_PARAMS_st;
pub const CUDA_MEMSET_NODE_PARAMS = CUDA_MEMSET_NODE_PARAMS_v1;
pub const struct_CUDA_MEMSET_NODE_PARAMS_v2_st = extern struct {
    dst: CUdeviceptr = 0,
    pitch: usize = 0,
    value: c_uint = 0,
    elementSize: c_uint = 0,
    width: usize = 0,
    height: usize = 0,
    ctx: CUcontext = null,
};
pub const CUDA_MEMSET_NODE_PARAMS_v2 = struct_CUDA_MEMSET_NODE_PARAMS_v2_st;
pub const struct_CUDA_HOST_NODE_PARAMS_st = extern struct {
    @"fn": CUhostFn = null,
    userData: ?*anyopaque = null,
};
pub const CUDA_HOST_NODE_PARAMS_v1 = struct_CUDA_HOST_NODE_PARAMS_st;
pub const CUDA_HOST_NODE_PARAMS = CUDA_HOST_NODE_PARAMS_v1;
const union_unnamed_11 = extern union {
    ctx: CUcontext,
    gCtx: CUgreenCtx,
};
pub const struct_CUDA_HOST_NODE_PARAMS_v2_st = extern struct {
    @"fn": CUhostFn = null,
    userData: ?*anyopaque = null,
    syncMode: c_uint = 0,
    unnamed_0: union_unnamed_11 = @import("std").mem.zeroes(union_unnamed_11),
};
pub const CUDA_HOST_NODE_PARAMS_v2 = struct_CUDA_HOST_NODE_PARAMS_v2_st;
pub const CU_GRAPH_COND_TYPE_IF: c_int = 0;
pub const CU_GRAPH_COND_TYPE_WHILE: c_int = 1;
pub const CU_GRAPH_COND_TYPE_SWITCH: c_int = 2;
pub const enum_CUgraphConditionalNodeType_enum = c_uint;
pub const CUgraphConditionalNodeType = enum_CUgraphConditionalNodeType_enum;
pub const struct_CUDA_CONDITIONAL_NODE_PARAMS = extern struct {
    handle: CUgraphConditionalHandle = 0,
    type: CUgraphConditionalNodeType = @import("std").mem.zeroes(CUgraphConditionalNodeType),
    size: c_uint = 0,
    phGraph_out: [*c]CUgraph = null,
    ctx: CUcontext = null,
};
pub const CUDA_CONDITIONAL_NODE_PARAMS = struct_CUDA_CONDITIONAL_NODE_PARAMS;
pub const CU_GRAPH_NODE_TYPE_KERNEL: c_int = 0;
pub const CU_GRAPH_NODE_TYPE_MEMCPY: c_int = 1;
pub const CU_GRAPH_NODE_TYPE_MEMSET: c_int = 2;
pub const CU_GRAPH_NODE_TYPE_HOST: c_int = 3;
pub const CU_GRAPH_NODE_TYPE_GRAPH: c_int = 4;
pub const CU_GRAPH_NODE_TYPE_EMPTY: c_int = 5;
pub const CU_GRAPH_NODE_TYPE_WAIT_EVENT: c_int = 6;
pub const CU_GRAPH_NODE_TYPE_EVENT_RECORD: c_int = 7;
pub const CU_GRAPH_NODE_TYPE_EXT_SEMAS_SIGNAL: c_int = 8;
pub const CU_GRAPH_NODE_TYPE_EXT_SEMAS_WAIT: c_int = 9;
pub const CU_GRAPH_NODE_TYPE_MEM_ALLOC: c_int = 10;
pub const CU_GRAPH_NODE_TYPE_MEM_FREE: c_int = 11;
pub const CU_GRAPH_NODE_TYPE_BATCH_MEM_OP: c_int = 12;
pub const CU_GRAPH_NODE_TYPE_CONDITIONAL: c_int = 13;
pub const CU_GRAPH_NODE_TYPE_RESERVED_16: c_int = 16;
pub const enum_CUgraphNodeType_enum = c_uint;
pub const CUgraphNodeType = enum_CUgraphNodeType_enum;
pub const CU_GRAPH_DEPENDENCY_TYPE_DEFAULT: c_int = 0;
pub const CU_GRAPH_DEPENDENCY_TYPE_PROGRAMMATIC: c_int = 1;
pub const enum_CUgraphDependencyType_enum = c_uint;
pub const CUgraphDependencyType = enum_CUgraphDependencyType_enum;
pub const struct_CUgraphEdgeData_st = extern struct {
    from_port: u8 = 0,
    to_port: u8 = 0,
    type: u8 = 0,
    reserved: [5]u8 = @import("std").mem.zeroes([5]u8),
};
pub const CUgraphEdgeData = struct_CUgraphEdgeData_st;
pub const CUDA_GRAPH_INSTANTIATE_SUCCESS: c_int = 0;
pub const CUDA_GRAPH_INSTANTIATE_ERROR: c_int = 1;
pub const CUDA_GRAPH_INSTANTIATE_INVALID_STRUCTURE: c_int = 2;
pub const CUDA_GRAPH_INSTANTIATE_NODE_OPERATION_NOT_SUPPORTED: c_int = 3;
pub const CUDA_GRAPH_INSTANTIATE_MULTIPLE_CTXS_NOT_SUPPORTED: c_int = 4;
pub const CUDA_GRAPH_INSTANTIATE_CONDITIONAL_HANDLE_UNUSED: c_int = 5;
pub const enum_CUgraphInstantiateResult_enum = c_uint;
pub const CUgraphInstantiateResult = enum_CUgraphInstantiateResult_enum;
pub const struct_CUDA_GRAPH_INSTANTIATE_PARAMS_st = extern struct {
    flags: cuuint64_t = 0,
    hUploadStream: CUstream = null,
    hErrNode_out: CUgraphNode = null,
    result_out: CUgraphInstantiateResult = @import("std").mem.zeroes(CUgraphInstantiateResult),
};
pub const CUDA_GRAPH_INSTANTIATE_PARAMS = struct_CUDA_GRAPH_INSTANTIATE_PARAMS_st;
pub const CU_SYNC_POLICY_AUTO: c_int = 1;
pub const CU_SYNC_POLICY_SPIN: c_int = 2;
pub const CU_SYNC_POLICY_YIELD: c_int = 3;
pub const CU_SYNC_POLICY_BLOCKING_SYNC: c_int = 4;
pub const enum_CUsynchronizationPolicy_enum = c_uint;
pub const CUsynchronizationPolicy = enum_CUsynchronizationPolicy_enum;
pub const CU_CLUSTER_SCHEDULING_POLICY_DEFAULT: c_int = 0;
pub const CU_CLUSTER_SCHEDULING_POLICY_SPREAD: c_int = 1;
pub const CU_CLUSTER_SCHEDULING_POLICY_LOAD_BALANCING: c_int = 2;
pub const CU_CLUSTER_SCHEDULING_POLICY_RUBIN_DSMEM_LOCALITY: c_int = 3;
pub const enum_CUclusterSchedulingPolicy_enum = c_uint;
pub const CUclusterSchedulingPolicy = enum_CUclusterSchedulingPolicy_enum;
pub const CU_LAUNCH_MEM_SYNC_DOMAIN_DEFAULT: c_int = 0;
pub const CU_LAUNCH_MEM_SYNC_DOMAIN_REMOTE: c_int = 1;
pub const enum_CUlaunchMemSyncDomain_enum = c_uint;
pub const CUlaunchMemSyncDomain = enum_CUlaunchMemSyncDomain_enum;
pub const struct_CUlaunchMemSyncDomainMap_st = extern struct {
    default_: u8 = 0,
    remote: u8 = 0,
};
pub const CUlaunchMemSyncDomainMap = struct_CUlaunchMemSyncDomainMap_st;
pub const CU_LAUNCH_PORTABLE_CLUSTER_MODE_DEFAULT: c_int = 0;
pub const CU_LAUNCH_PORTABLE_CLUSTER_MODE_REQUIRE_PORTABLE: c_int = 1;
pub const CU_LAUNCH_PORTABLE_CLUSTER_MODE_ALLOW_NON_PORTABLE: c_int = 2;
pub const enum_CUlaunchAttributePortableClusterMode_enum = c_uint;
pub const CUlaunchAttributePortableClusterMode = enum_CUlaunchAttributePortableClusterMode_enum;
pub const CU_SHARED_MEMORY_MODE_DEFAULT: c_int = 0;
pub const CU_SHARED_MEMORY_MODE_REQUIRE_PORTABLE: c_int = 1;
pub const CU_SHARED_MEMORY_MODE_ALLOW_NON_PORTABLE: c_int = 2;
pub const CU_SHARED_MEMORY_MODE_ALLOW_OVERSIZED_SHARED_MEMORY: c_int = 3;
pub const CU_SHARED_MEMORY_MODE_PREFER_OVERSIZED_SHARED_MEMORY: c_int = 4;
pub const enum_CUsharedMemoryMode_enum = c_uint;
pub const CUsharedMemoryMode = enum_CUsharedMemoryMode_enum;
pub const CU_LAUNCH_ATTRIBUTE_IGNORE: c_int = 0;
pub const CU_LAUNCH_ATTRIBUTE_ACCESS_POLICY_WINDOW: c_int = 1;
pub const CU_LAUNCH_ATTRIBUTE_COOPERATIVE: c_int = 2;
pub const CU_LAUNCH_ATTRIBUTE_SYNCHRONIZATION_POLICY: c_int = 3;
pub const CU_LAUNCH_ATTRIBUTE_CLUSTER_DIMENSION: c_int = 4;
pub const CU_LAUNCH_ATTRIBUTE_CLUSTER_SCHEDULING_POLICY_PREFERENCE: c_int = 5;
pub const CU_LAUNCH_ATTRIBUTE_PROGRAMMATIC_STREAM_SERIALIZATION: c_int = 6;
pub const CU_LAUNCH_ATTRIBUTE_PROGRAMMATIC_EVENT: c_int = 7;
pub const CU_LAUNCH_ATTRIBUTE_PRIORITY: c_int = 8;
pub const CU_LAUNCH_ATTRIBUTE_MEM_SYNC_DOMAIN_MAP: c_int = 9;
pub const CU_LAUNCH_ATTRIBUTE_MEM_SYNC_DOMAIN: c_int = 10;
pub const CU_LAUNCH_ATTRIBUTE_PREFERRED_CLUSTER_DIMENSION: c_int = 11;
pub const CU_LAUNCH_ATTRIBUTE_LAUNCH_COMPLETION_EVENT: c_int = 12;
pub const CU_LAUNCH_ATTRIBUTE_DEVICE_UPDATABLE_KERNEL_NODE: c_int = 13;
pub const CU_LAUNCH_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT: c_int = 14;
pub const CU_LAUNCH_ATTRIBUTE_NVLINK_UTIL_CENTRIC_SCHEDULING: c_int = 16;
pub const CU_LAUNCH_ATTRIBUTE_PORTABLE_CLUSTER_SIZE_MODE: c_int = 17;
pub const CU_LAUNCH_ATTRIBUTE_SHARED_MEMORY_MODE: c_int = 18;
pub const enum_CUlaunchAttributeID_enum = c_uint;
pub const CUlaunchAttributeID = enum_CUlaunchAttributeID_enum;
const struct_unnamed_12 = extern struct {
    x: c_uint = 0,
    y: c_uint = 0,
    z: c_uint = 0,
};
const struct_unnamed_13 = extern struct {
    event: CUevent = null,
    flags: c_int = 0,
    triggerAtBlockStart: c_int = 0,
};
const struct_unnamed_14 = extern struct {
    event: CUevent = null,
    flags: c_int = 0,
};
const struct_unnamed_15 = extern struct {
    x: c_uint = 0,
    y: c_uint = 0,
    z: c_uint = 0,
};
const struct_unnamed_16 = extern struct {
    deviceUpdatable: c_int = 0,
    devNode: CUgraphDeviceNode = null,
};
pub const union_CUlaunchAttributeValue_union = extern union {
    pad: [64]u8,
    accessPolicyWindow: CUaccessPolicyWindow,
    cooperative: c_int,
    syncPolicy: CUsynchronizationPolicy,
    clusterDim: struct_unnamed_12,
    clusterSchedulingPolicyPreference: CUclusterSchedulingPolicy,
    programmaticStreamSerializationAllowed: c_int,
    programmaticEvent: struct_unnamed_13,
    launchCompletionEvent: struct_unnamed_14,
    priority: c_int,
    memSyncDomainMap: CUlaunchMemSyncDomainMap,
    memSyncDomain: CUlaunchMemSyncDomain,
    preferredClusterDim: struct_unnamed_15,
    deviceUpdatableKernelNode: struct_unnamed_16,
    sharedMemCarveout: c_uint,
    nvlinkUtilCentricScheduling: c_uint,
    portableClusterSizeMode: CUlaunchAttributePortableClusterMode,
    sharedMemoryMode: CUsharedMemoryMode,
};
pub const CUlaunchAttributeValue = union_CUlaunchAttributeValue_union;
pub const struct_CUlaunchAttribute_st = extern struct {
    id: CUlaunchAttributeID = @import("std").mem.zeroes(CUlaunchAttributeID),
    pad: [4]u8 = @import("std").mem.zeroes([4]u8),
    value: CUlaunchAttributeValue = @import("std").mem.zeroes(CUlaunchAttributeValue),
};
pub const CUlaunchAttribute = struct_CUlaunchAttribute_st;
pub const struct_CUlaunchConfig_st = extern struct {
    gridDimX: c_uint = 0,
    gridDimY: c_uint = 0,
    gridDimZ: c_uint = 0,
    blockDimX: c_uint = 0,
    blockDimY: c_uint = 0,
    blockDimZ: c_uint = 0,
    sharedMemBytes: c_uint = 0,
    hStream: CUstream = null,
    attrs: [*c]CUlaunchAttribute = null,
    numAttrs: c_uint = 0,
    pub const cuLaunchKernelEx = __root.cuLaunchKernelEx;
};
pub const CUlaunchConfig = struct_CUlaunchConfig_st;
pub const CUkernelNodeAttrID = CUlaunchAttributeID;
pub const CUkernelNodeAttrValue_v1 = CUlaunchAttributeValue;
pub const CUkernelNodeAttrValue = CUkernelNodeAttrValue_v1;
pub const CU_STREAM_CAPTURE_STATUS_NONE: c_int = 0;
pub const CU_STREAM_CAPTURE_STATUS_ACTIVE: c_int = 1;
pub const CU_STREAM_CAPTURE_STATUS_INVALIDATED: c_int = 2;
pub const enum_CUstreamCaptureStatus_enum = c_uint;
pub const CUstreamCaptureStatus = enum_CUstreamCaptureStatus_enum;
pub const CU_STREAM_CAPTURE_MODE_GLOBAL: c_int = 0;
pub const CU_STREAM_CAPTURE_MODE_THREAD_LOCAL: c_int = 1;
pub const CU_STREAM_CAPTURE_MODE_RELAXED: c_int = 2;
pub const enum_CUstreamCaptureMode_enum = c_uint;
pub const CUstreamCaptureMode = enum_CUstreamCaptureMode_enum;
pub const CUstreamAttrID = CUlaunchAttributeID;
pub const CUstreamAttrValue_v1 = CUlaunchAttributeValue;
pub const CUstreamAttrValue = CUstreamAttrValue_v1;
pub const CU_GET_PROC_ADDRESS_DEFAULT: c_int = 0;
pub const CU_GET_PROC_ADDRESS_LEGACY_STREAM: c_int = 1;
pub const CU_GET_PROC_ADDRESS_PER_THREAD_DEFAULT_STREAM: c_int = 2;
pub const enum_CUdriverProcAddress_flags_enum = c_uint;
pub const CUdriverProcAddress_flags = enum_CUdriverProcAddress_flags_enum;
pub const CU_GET_PROC_ADDRESS_SUCCESS: c_int = 0;
pub const CU_GET_PROC_ADDRESS_SYMBOL_NOT_FOUND: c_int = 1;
pub const CU_GET_PROC_ADDRESS_VERSION_NOT_SUFFICIENT: c_int = 2;
pub const enum_CUdriverProcAddressQueryResult_enum = c_uint;
pub const CUdriverProcAddressQueryResult = enum_CUdriverProcAddressQueryResult_enum;
pub const CU_EXEC_AFFINITY_TYPE_SM_COUNT: c_int = 0;
pub const CU_EXEC_AFFINITY_TYPE_MAX: c_int = 1;
pub const enum_CUexecAffinityType_enum = c_uint;
pub const CUexecAffinityType = enum_CUexecAffinityType_enum;
pub const struct_CUexecAffinitySmCount_st = extern struct {
    val: c_uint = 0,
};
pub const CUexecAffinitySmCount_v1 = struct_CUexecAffinitySmCount_st;
pub const CUexecAffinitySmCount = CUexecAffinitySmCount_v1;
const union_unnamed_17 = extern union {
    smCount: CUexecAffinitySmCount,
};
pub const struct_CUexecAffinityParam_st = extern struct {
    type: CUexecAffinityType = @import("std").mem.zeroes(CUexecAffinityType),
    param: union_unnamed_17 = @import("std").mem.zeroes(union_unnamed_17),
    pub const cuCtxGetExecAffinity = __root.cuCtxGetExecAffinity;
};
pub const CUexecAffinityParam_v1 = struct_CUexecAffinityParam_st;
pub const CUexecAffinityParam = CUexecAffinityParam_v1;
pub const CIG_DATA_TYPE_D3D12_COMMAND_QUEUE: c_int = 1;
pub const CIG_DATA_TYPE_NV_BLOB: c_int = 2;
pub const enum_CUcigDataType_enum = c_uint;
pub const CUcigDataType = enum_CUcigDataType_enum;
pub const struct_CUctxCigParam_st = extern struct {
    sharedDataType: CUcigDataType = @import("std").mem.zeroes(CUcigDataType),
    sharedData: ?*anyopaque = null,
};
pub const CUctxCigParam = struct_CUctxCigParam_st;
pub const struct_CUctxCreateParams_st = extern struct {
    execAffinityParams: [*c]CUexecAffinityParam = null,
    numExecAffinityParams: c_int = 0,
    cigParams: [*c]CUctxCigParam = null,
};
pub const CUctxCreateParams = struct_CUctxCreateParams_st;
pub const STREAM_CIG_DATA_TYPE_D3D12_COMMAND_LIST: c_int = 1;
pub const enum_CUstreamCigDataType_enum = c_uint;
pub const CUstreamCigDataType = enum_CUstreamCigDataType_enum;
pub const struct_CUstreamCigParam_st = extern struct {
    streamSharedDataType: CUstreamCigDataType = @import("std").mem.zeroes(CUstreamCigDataType),
    streamSharedData: ?*anyopaque = null,
};
pub const CUstreamCigParam = struct_CUstreamCigParam_st;
pub const struct_CUstreamCigCaptureParams_st = extern struct {
    streamCigParams: [*c]CUstreamCigParam = null,
};
pub const CUstreamCigCaptureParams = struct_CUstreamCigCaptureParams_st;
pub const CU_LIBRARY_HOST_UNIVERSAL_FUNCTION_AND_DATA_TABLE: c_int = 0;
pub const CU_LIBRARY_BINARY_IS_PRESERVED: c_int = 1;
pub const CU_LIBRARY_NUM_OPTIONS: c_int = 2;
pub const enum_CUlibraryOption_enum = c_uint;
pub const CUlibraryOption = enum_CUlibraryOption_enum;
pub const struct_CUlibraryHostUniversalFunctionAndDataTable_st = extern struct {
    functionTable: ?*anyopaque = null,
    functionWindowSize: usize = 0,
    dataTable: ?*anyopaque = null,
    dataWindowSize: usize = 0,
};
pub const CUlibraryHostUniversalFunctionAndDataTable = struct_CUlibraryHostUniversalFunctionAndDataTable_st;
pub const CUDA_SUCCESS: c_int = 0;
pub const CUDA_ERROR_INVALID_VALUE: c_int = 1;
pub const CUDA_ERROR_OUT_OF_MEMORY: c_int = 2;
pub const CUDA_ERROR_NOT_INITIALIZED: c_int = 3;
pub const CUDA_ERROR_DEINITIALIZED: c_int = 4;
pub const CUDA_ERROR_PROFILER_DISABLED: c_int = 5;
pub const CUDA_ERROR_PROFILER_NOT_INITIALIZED: c_int = 6;
pub const CUDA_ERROR_PROFILER_ALREADY_STARTED: c_int = 7;
pub const CUDA_ERROR_PROFILER_ALREADY_STOPPED: c_int = 8;
pub const CUDA_ERROR_STUB_LIBRARY: c_int = 34;
pub const CUDA_ERROR_CALL_REQUIRES_NEWER_DRIVER: c_int = 36;
pub const CUDA_ERROR_DEVICE_UNAVAILABLE: c_int = 46;
pub const CUDA_ERROR_MULTICAST_RESOURCE_FULL: c_int = 47;
pub const CUDA_ERROR_NO_DEVICE: c_int = 100;
pub const CUDA_ERROR_INVALID_DEVICE: c_int = 101;
pub const CUDA_ERROR_DEVICE_NOT_LICENSED: c_int = 102;
pub const CUDA_ERROR_INVALID_IMAGE: c_int = 200;
pub const CUDA_ERROR_INVALID_CONTEXT: c_int = 201;
pub const CUDA_ERROR_CONTEXT_ALREADY_CURRENT: c_int = 202;
pub const CUDA_ERROR_MAP_FAILED: c_int = 205;
pub const CUDA_ERROR_UNMAP_FAILED: c_int = 206;
pub const CUDA_ERROR_ARRAY_IS_MAPPED: c_int = 207;
pub const CUDA_ERROR_ALREADY_MAPPED: c_int = 208;
pub const CUDA_ERROR_NO_BINARY_FOR_GPU: c_int = 209;
pub const CUDA_ERROR_ALREADY_ACQUIRED: c_int = 210;
pub const CUDA_ERROR_NOT_MAPPED: c_int = 211;
pub const CUDA_ERROR_NOT_MAPPED_AS_ARRAY: c_int = 212;
pub const CUDA_ERROR_NOT_MAPPED_AS_POINTER: c_int = 213;
pub const CUDA_ERROR_ECC_UNCORRECTABLE: c_int = 214;
pub const CUDA_ERROR_UNSUPPORTED_LIMIT: c_int = 215;
pub const CUDA_ERROR_CONTEXT_ALREADY_IN_USE: c_int = 216;
pub const CUDA_ERROR_PEER_ACCESS_UNSUPPORTED: c_int = 217;
pub const CUDA_ERROR_INVALID_PTX: c_int = 218;
pub const CUDA_ERROR_INVALID_GRAPHICS_CONTEXT: c_int = 219;
pub const CUDA_ERROR_NVLINK_UNCORRECTABLE: c_int = 220;
pub const CUDA_ERROR_JIT_COMPILER_NOT_FOUND: c_int = 221;
pub const CUDA_ERROR_UNSUPPORTED_PTX_VERSION: c_int = 222;
pub const CUDA_ERROR_JIT_COMPILATION_DISABLED: c_int = 223;
pub const CUDA_ERROR_UNSUPPORTED_EXEC_AFFINITY: c_int = 224;
pub const CUDA_ERROR_UNSUPPORTED_DEVSIDE_SYNC: c_int = 225;
pub const CUDA_ERROR_CONTAINED: c_int = 226;
pub const CUDA_ERROR_INSUFFICIENT_LOADER_VERSION: c_int = 227;
pub const CUDA_ERROR_INVALID_SOURCE: c_int = 300;
pub const CUDA_ERROR_FILE_NOT_FOUND: c_int = 301;
pub const CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND: c_int = 302;
pub const CUDA_ERROR_SHARED_OBJECT_INIT_FAILED: c_int = 303;
pub const CUDA_ERROR_OPERATING_SYSTEM: c_int = 304;
pub const CUDA_ERROR_INVALID_HANDLE: c_int = 400;
pub const CUDA_ERROR_ILLEGAL_STATE: c_int = 401;
pub const CUDA_ERROR_LOSSY_QUERY: c_int = 402;
pub const CUDA_ERROR_NOT_FOUND: c_int = 500;
pub const CUDA_ERROR_NOT_READY: c_int = 600;
pub const CUDA_ERROR_ILLEGAL_ADDRESS: c_int = 700;
pub const CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES: c_int = 701;
pub const CUDA_ERROR_LAUNCH_TIMEOUT: c_int = 702;
pub const CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING: c_int = 703;
pub const CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED: c_int = 704;
pub const CUDA_ERROR_PEER_ACCESS_NOT_ENABLED: c_int = 705;
pub const CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE: c_int = 708;
pub const CUDA_ERROR_CONTEXT_IS_DESTROYED: c_int = 709;
pub const CUDA_ERROR_ASSERT: c_int = 710;
pub const CUDA_ERROR_TOO_MANY_PEERS: c_int = 711;
pub const CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED: c_int = 712;
pub const CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED: c_int = 713;
pub const CUDA_ERROR_HARDWARE_STACK_ERROR: c_int = 714;
pub const CUDA_ERROR_ILLEGAL_INSTRUCTION: c_int = 715;
pub const CUDA_ERROR_MISALIGNED_ADDRESS: c_int = 716;
pub const CUDA_ERROR_INVALID_ADDRESS_SPACE: c_int = 717;
pub const CUDA_ERROR_INVALID_PC: c_int = 718;
pub const CUDA_ERROR_LAUNCH_FAILED: c_int = 719;
pub const CUDA_ERROR_COOPERATIVE_LAUNCH_TOO_LARGE: c_int = 720;
pub const CUDA_ERROR_TENSOR_MEMORY_LEAK: c_int = 721;
pub const CUDA_ERROR_NOT_PERMITTED: c_int = 800;
pub const CUDA_ERROR_NOT_SUPPORTED: c_int = 801;
pub const CUDA_ERROR_SYSTEM_NOT_READY: c_int = 802;
pub const CUDA_ERROR_SYSTEM_DRIVER_MISMATCH: c_int = 803;
pub const CUDA_ERROR_COMPAT_NOT_SUPPORTED_ON_DEVICE: c_int = 804;
pub const CUDA_ERROR_MPS_CONNECTION_FAILED: c_int = 805;
pub const CUDA_ERROR_MPS_RPC_FAILURE: c_int = 806;
pub const CUDA_ERROR_MPS_SERVER_NOT_READY: c_int = 807;
pub const CUDA_ERROR_MPS_MAX_CLIENTS_REACHED: c_int = 808;
pub const CUDA_ERROR_MPS_MAX_CONNECTIONS_REACHED: c_int = 809;
pub const CUDA_ERROR_MPS_CLIENT_TERMINATED: c_int = 810;
pub const CUDA_ERROR_CDP_NOT_SUPPORTED: c_int = 811;
pub const CUDA_ERROR_CDP_VERSION_MISMATCH: c_int = 812;
pub const CUDA_ERROR_STREAM_CAPTURE_UNSUPPORTED: c_int = 900;
pub const CUDA_ERROR_STREAM_CAPTURE_INVALIDATED: c_int = 901;
pub const CUDA_ERROR_STREAM_CAPTURE_MERGE: c_int = 902;
pub const CUDA_ERROR_STREAM_CAPTURE_UNMATCHED: c_int = 903;
pub const CUDA_ERROR_STREAM_CAPTURE_UNJOINED: c_int = 904;
pub const CUDA_ERROR_STREAM_CAPTURE_ISOLATION: c_int = 905;
pub const CUDA_ERROR_STREAM_CAPTURE_IMPLICIT: c_int = 906;
pub const CUDA_ERROR_CAPTURED_EVENT: c_int = 907;
pub const CUDA_ERROR_STREAM_CAPTURE_WRONG_THREAD: c_int = 908;
pub const CUDA_ERROR_TIMEOUT: c_int = 909;
pub const CUDA_ERROR_GRAPH_EXEC_UPDATE_FAILURE: c_int = 910;
pub const CUDA_ERROR_EXTERNAL_DEVICE: c_int = 911;
pub const CUDA_ERROR_INVALID_CLUSTER_SIZE: c_int = 912;
pub const CUDA_ERROR_FUNCTION_NOT_LOADED: c_int = 913;
pub const CUDA_ERROR_INVALID_RESOURCE_TYPE: c_int = 914;
pub const CUDA_ERROR_INVALID_RESOURCE_CONFIGURATION: c_int = 915;
pub const CUDA_ERROR_KEY_ROTATION: c_int = 916;
pub const CUDA_ERROR_STREAM_DETACHED: c_int = 917;
pub const CUDA_ERROR_GRAPH_RECAPTURE_FAILURE: c_int = 918;
pub const CUDA_ERROR_FABRIC_NOT_READY: c_int = 919;
pub const CUDA_ERROR_UNKNOWN: c_int = 999;
pub const enum_cudaError_enum = c_uint;
pub const CUresult = enum_cudaError_enum;
pub const CU_DEVICE_P2P_ATTRIBUTE_PERFORMANCE_RANK: c_int = 1;
pub const CU_DEVICE_P2P_ATTRIBUTE_ACCESS_SUPPORTED: c_int = 2;
pub const CU_DEVICE_P2P_ATTRIBUTE_NATIVE_ATOMIC_SUPPORTED: c_int = 3;
pub const CU_DEVICE_P2P_ATTRIBUTE_ACCESS_ACCESS_SUPPORTED: c_int = 4;
pub const CU_DEVICE_P2P_ATTRIBUTE_CUDA_ARRAY_ACCESS_SUPPORTED: c_int = 4;
pub const CU_DEVICE_P2P_ATTRIBUTE_ONLY_PARTIAL_NATIVE_ATOMIC_SUPPORTED: c_int = 5;
pub const enum_CUdevice_P2PAttribute_enum = c_uint;
pub const CUdevice_P2PAttribute = enum_CUdevice_P2PAttribute_enum;
pub const CUstreamCallback = ?*const fn (hStream: CUstream, status: CUresult, userData: ?*anyopaque) callconv(.c) void;
pub const CUoccupancyB2DSize = ?*const fn (blockSize: c_int) callconv(.c) usize;
pub const struct_CUDA_MEMCPY2D_st = extern struct {
    srcXInBytes: usize = 0,
    srcY: usize = 0,
    srcMemoryType: CUmemorytype = @import("std").mem.zeroes(CUmemorytype),
    srcHost: ?*const anyopaque = null,
    srcDevice: CUdeviceptr = 0,
    srcArray: CUarray = null,
    srcPitch: usize = 0,
    dstXInBytes: usize = 0,
    dstY: usize = 0,
    dstMemoryType: CUmemorytype = @import("std").mem.zeroes(CUmemorytype),
    dstHost: ?*anyopaque = null,
    dstDevice: CUdeviceptr = 0,
    dstArray: CUarray = null,
    dstPitch: usize = 0,
    WidthInBytes: usize = 0,
    Height: usize = 0,
    pub const cuMemcpy2D_v2 = __root.cuMemcpy2D_v2;
    pub const cuMemcpy2DUnaligned_v2 = __root.cuMemcpy2DUnaligned_v2;
    pub const cuMemcpy2DAsync_v2 = __root.cuMemcpy2DAsync_v2;
    pub const v2 = __root.cuMemcpy2D_v2;
};
pub const CUDA_MEMCPY2D_v2 = struct_CUDA_MEMCPY2D_st;
pub const CUDA_MEMCPY2D = CUDA_MEMCPY2D_v2;
pub const struct_CUDA_MEMCPY3D_st = extern struct {
    srcXInBytes: usize = 0,
    srcY: usize = 0,
    srcZ: usize = 0,
    srcLOD: usize = 0,
    srcMemoryType: CUmemorytype = @import("std").mem.zeroes(CUmemorytype),
    srcHost: ?*const anyopaque = null,
    srcDevice: CUdeviceptr = 0,
    srcArray: CUarray = null,
    reserved0: ?*anyopaque = null,
    srcPitch: usize = 0,
    srcHeight: usize = 0,
    dstXInBytes: usize = 0,
    dstY: usize = 0,
    dstZ: usize = 0,
    dstLOD: usize = 0,
    dstMemoryType: CUmemorytype = @import("std").mem.zeroes(CUmemorytype),
    dstHost: ?*anyopaque = null,
    dstDevice: CUdeviceptr = 0,
    dstArray: CUarray = null,
    reserved1: ?*anyopaque = null,
    dstPitch: usize = 0,
    dstHeight: usize = 0,
    WidthInBytes: usize = 0,
    Height: usize = 0,
    Depth: usize = 0,
    pub const cuMemcpy3D_v2 = __root.cuMemcpy3D_v2;
    pub const cuMemcpy3DAsync_v2 = __root.cuMemcpy3DAsync_v2;
    pub const v2 = __root.cuMemcpy3D_v2;
};
pub const CUDA_MEMCPY3D_v2 = struct_CUDA_MEMCPY3D_st;
pub const CUDA_MEMCPY3D = CUDA_MEMCPY3D_v2;
pub const struct_CUDA_MEMCPY3D_PEER_st = extern struct {
    srcXInBytes: usize = 0,
    srcY: usize = 0,
    srcZ: usize = 0,
    srcLOD: usize = 0,
    srcMemoryType: CUmemorytype = @import("std").mem.zeroes(CUmemorytype),
    srcHost: ?*const anyopaque = null,
    srcDevice: CUdeviceptr = 0,
    srcArray: CUarray = null,
    srcContext: CUcontext = null,
    srcPitch: usize = 0,
    srcHeight: usize = 0,
    dstXInBytes: usize = 0,
    dstY: usize = 0,
    dstZ: usize = 0,
    dstLOD: usize = 0,
    dstMemoryType: CUmemorytype = @import("std").mem.zeroes(CUmemorytype),
    dstHost: ?*anyopaque = null,
    dstDevice: CUdeviceptr = 0,
    dstArray: CUarray = null,
    dstContext: CUcontext = null,
    dstPitch: usize = 0,
    dstHeight: usize = 0,
    WidthInBytes: usize = 0,
    Height: usize = 0,
    Depth: usize = 0,
    pub const cuMemcpy3DPeer = __root.cuMemcpy3DPeer;
    pub const cuMemcpy3DPeerAsync = __root.cuMemcpy3DPeerAsync;
};
pub const CUDA_MEMCPY3D_PEER_v1 = struct_CUDA_MEMCPY3D_PEER_st;
pub const CUDA_MEMCPY3D_PEER = CUDA_MEMCPY3D_PEER_v1;
pub const struct_CUDA_MEMCPY_NODE_PARAMS_st = extern struct {
    flags: c_int = 0,
    reserved: c_int = 0,
    copyCtx: CUcontext = null,
    copyParams: CUDA_MEMCPY3D = @import("std").mem.zeroes(CUDA_MEMCPY3D),
};
pub const CUDA_MEMCPY_NODE_PARAMS = struct_CUDA_MEMCPY_NODE_PARAMS_st;
pub const struct_CUDA_ARRAY_DESCRIPTOR_st = extern struct {
    Width: usize = 0,
    Height: usize = 0,
    Format: CUarray_format = @import("std").mem.zeroes(CUarray_format),
    NumChannels: c_uint = 0,
    pub const cuArrayGetDescriptor_v2 = __root.cuArrayGetDescriptor_v2;
    pub const v2 = __root.cuArrayGetDescriptor_v2;
};
pub const CUDA_ARRAY_DESCRIPTOR_v2 = struct_CUDA_ARRAY_DESCRIPTOR_st;
pub const CUDA_ARRAY_DESCRIPTOR = CUDA_ARRAY_DESCRIPTOR_v2;
pub const struct_CUDA_ARRAY3D_DESCRIPTOR_st = extern struct {
    Width: usize = 0,
    Height: usize = 0,
    Depth: usize = 0,
    Format: CUarray_format = @import("std").mem.zeroes(CUarray_format),
    NumChannels: c_uint = 0,
    Flags: c_uint = 0,
    pub const cuArray3DGetDescriptor_v2 = __root.cuArray3DGetDescriptor_v2;
    pub const v2 = __root.cuArray3DGetDescriptor_v2;
};
pub const CUDA_ARRAY3D_DESCRIPTOR_v2 = struct_CUDA_ARRAY3D_DESCRIPTOR_st;
pub const CUDA_ARRAY3D_DESCRIPTOR = CUDA_ARRAY3D_DESCRIPTOR_v2;
const struct_unnamed_18 = extern struct {
    width: c_uint = 0,
    height: c_uint = 0,
    depth: c_uint = 0,
};
pub const struct_CUDA_ARRAY_SPARSE_PROPERTIES_st = extern struct {
    tileExtent: struct_unnamed_18 = @import("std").mem.zeroes(struct_unnamed_18),
    miptailFirstLevel: c_uint = 0,
    miptailSize: c_ulonglong = 0,
    flags: c_uint = 0,
    reserved: [4]c_uint = @import("std").mem.zeroes([4]c_uint),
    pub const cuArrayGetSparseProperties = __root.cuArrayGetSparseProperties;
    pub const cuMipmappedArrayGetSparseProperties = __root.cuMipmappedArrayGetSparseProperties;
};
pub const CUDA_ARRAY_SPARSE_PROPERTIES_v1 = struct_CUDA_ARRAY_SPARSE_PROPERTIES_st;
pub const CUDA_ARRAY_SPARSE_PROPERTIES = CUDA_ARRAY_SPARSE_PROPERTIES_v1;
pub const struct_CUDA_ARRAY_MEMORY_REQUIREMENTS_st = extern struct {
    size: usize = 0,
    alignment: usize = 0,
    reserved: [4]c_uint = @import("std").mem.zeroes([4]c_uint),
    pub const cuArrayGetMemoryRequirements = __root.cuArrayGetMemoryRequirements;
    pub const cuMipmappedArrayGetMemoryRequirements = __root.cuMipmappedArrayGetMemoryRequirements;
};
pub const CUDA_ARRAY_MEMORY_REQUIREMENTS_v1 = struct_CUDA_ARRAY_MEMORY_REQUIREMENTS_st;
pub const CUDA_ARRAY_MEMORY_REQUIREMENTS = CUDA_ARRAY_MEMORY_REQUIREMENTS_v1;
const struct_unnamed_20 = extern struct {
    hArray: CUarray = null,
};
const struct_unnamed_21 = extern struct {
    hMipmappedArray: CUmipmappedArray = null,
};
const struct_unnamed_22 = extern struct {
    devPtr: CUdeviceptr = 0,
    format: CUarray_format = @import("std").mem.zeroes(CUarray_format),
    numChannels: c_uint = 0,
    sizeInBytes: usize = 0,
};
const struct_unnamed_23 = extern struct {
    devPtr: CUdeviceptr = 0,
    format: CUarray_format = @import("std").mem.zeroes(CUarray_format),
    numChannels: c_uint = 0,
    width: usize = 0,
    height: usize = 0,
    pitchInBytes: usize = 0,
};
const struct_unnamed_24 = extern struct {
    reserved: [32]c_int = @import("std").mem.zeroes([32]c_int),
};
const union_unnamed_19 = extern union {
    array: struct_unnamed_20,
    mipmap: struct_unnamed_21,
    linear: struct_unnamed_22,
    pitch2D: struct_unnamed_23,
    reserved: struct_unnamed_24,
};
pub const struct_CUDA_RESOURCE_DESC_st = extern struct {
    resType: CUresourcetype = @import("std").mem.zeroes(CUresourcetype),
    res: union_unnamed_19 = @import("std").mem.zeroes(union_unnamed_19),
    flags: c_uint = 0,
    pub const cuTexObjectGetResourceDesc = __root.cuTexObjectGetResourceDesc;
    pub const cuSurfObjectGetResourceDesc = __root.cuSurfObjectGetResourceDesc;
};
pub const CUDA_RESOURCE_DESC_v1 = struct_CUDA_RESOURCE_DESC_st;
pub const CUDA_RESOURCE_DESC = CUDA_RESOURCE_DESC_v1;
pub const struct_CUDA_TEXTURE_DESC_st = extern struct {
    addressMode: [3]CUaddress_mode = @import("std").mem.zeroes([3]CUaddress_mode),
    filterMode: CUfilter_mode = @import("std").mem.zeroes(CUfilter_mode),
    flags: c_uint = 0,
    maxAnisotropy: c_uint = 0,
    mipmapFilterMode: CUfilter_mode = @import("std").mem.zeroes(CUfilter_mode),
    mipmapLevelBias: f32 = 0,
    minMipmapLevelClamp: f32 = 0,
    maxMipmapLevelClamp: f32 = 0,
    borderColor: [4]f32 = @import("std").mem.zeroes([4]f32),
    reserved: [12]c_int = @import("std").mem.zeroes([12]c_int),
    pub const cuTexObjectGetTextureDesc = __root.cuTexObjectGetTextureDesc;
};
pub const CUDA_TEXTURE_DESC_v1 = struct_CUDA_TEXTURE_DESC_st;
pub const CUDA_TEXTURE_DESC = CUDA_TEXTURE_DESC_v1;
pub const CU_RES_VIEW_FORMAT_NONE: c_int = 0;
pub const CU_RES_VIEW_FORMAT_UINT_1X8: c_int = 1;
pub const CU_RES_VIEW_FORMAT_UINT_2X8: c_int = 2;
pub const CU_RES_VIEW_FORMAT_UINT_4X8: c_int = 3;
pub const CU_RES_VIEW_FORMAT_SINT_1X8: c_int = 4;
pub const CU_RES_VIEW_FORMAT_SINT_2X8: c_int = 5;
pub const CU_RES_VIEW_FORMAT_SINT_4X8: c_int = 6;
pub const CU_RES_VIEW_FORMAT_UINT_1X16: c_int = 7;
pub const CU_RES_VIEW_FORMAT_UINT_2X16: c_int = 8;
pub const CU_RES_VIEW_FORMAT_UINT_4X16: c_int = 9;
pub const CU_RES_VIEW_FORMAT_SINT_1X16: c_int = 10;
pub const CU_RES_VIEW_FORMAT_SINT_2X16: c_int = 11;
pub const CU_RES_VIEW_FORMAT_SINT_4X16: c_int = 12;
pub const CU_RES_VIEW_FORMAT_UINT_1X32: c_int = 13;
pub const CU_RES_VIEW_FORMAT_UINT_2X32: c_int = 14;
pub const CU_RES_VIEW_FORMAT_UINT_4X32: c_int = 15;
pub const CU_RES_VIEW_FORMAT_SINT_1X32: c_int = 16;
pub const CU_RES_VIEW_FORMAT_SINT_2X32: c_int = 17;
pub const CU_RES_VIEW_FORMAT_SINT_4X32: c_int = 18;
pub const CU_RES_VIEW_FORMAT_FLOAT_1X16: c_int = 19;
pub const CU_RES_VIEW_FORMAT_FLOAT_2X16: c_int = 20;
pub const CU_RES_VIEW_FORMAT_FLOAT_4X16: c_int = 21;
pub const CU_RES_VIEW_FORMAT_FLOAT_1X32: c_int = 22;
pub const CU_RES_VIEW_FORMAT_FLOAT_2X32: c_int = 23;
pub const CU_RES_VIEW_FORMAT_FLOAT_4X32: c_int = 24;
pub const CU_RES_VIEW_FORMAT_UNSIGNED_BC1: c_int = 25;
pub const CU_RES_VIEW_FORMAT_UNSIGNED_BC2: c_int = 26;
pub const CU_RES_VIEW_FORMAT_UNSIGNED_BC3: c_int = 27;
pub const CU_RES_VIEW_FORMAT_UNSIGNED_BC4: c_int = 28;
pub const CU_RES_VIEW_FORMAT_SIGNED_BC4: c_int = 29;
pub const CU_RES_VIEW_FORMAT_UNSIGNED_BC5: c_int = 30;
pub const CU_RES_VIEW_FORMAT_SIGNED_BC5: c_int = 31;
pub const CU_RES_VIEW_FORMAT_UNSIGNED_BC6H: c_int = 32;
pub const CU_RES_VIEW_FORMAT_SIGNED_BC6H: c_int = 33;
pub const CU_RES_VIEW_FORMAT_UNSIGNED_BC7: c_int = 34;
pub const enum_CUresourceViewFormat_enum = c_uint;
pub const CUresourceViewFormat = enum_CUresourceViewFormat_enum;
pub const struct_CUDA_RESOURCE_VIEW_DESC_st = extern struct {
    format: CUresourceViewFormat = @import("std").mem.zeroes(CUresourceViewFormat),
    width: usize = 0,
    height: usize = 0,
    depth: usize = 0,
    firstMipmapLevel: c_uint = 0,
    lastMipmapLevel: c_uint = 0,
    firstLayer: c_uint = 0,
    lastLayer: c_uint = 0,
    reserved: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
    pub const cuTexObjectGetResourceViewDesc = __root.cuTexObjectGetResourceViewDesc;
};
pub const CUDA_RESOURCE_VIEW_DESC_v1 = struct_CUDA_RESOURCE_VIEW_DESC_st;
pub const CUDA_RESOURCE_VIEW_DESC = CUDA_RESOURCE_VIEW_DESC_v1;
pub const struct_CUtensorMap_st = extern struct {
    @"opaque": [16]cuuint64_t align(128) = @import("std").mem.zeroes([16]cuuint64_t),
    pub const cuTensorMapEncodeTiled = __root.cuTensorMapEncodeTiled;
    pub const cuTensorMapEncodeIm2col = __root.cuTensorMapEncodeIm2col;
    pub const cuTensorMapEncodeIm2colWide = __root.cuTensorMapEncodeIm2colWide;
    pub const cuTensorMapReplaceAddress = __root.cuTensorMapReplaceAddress;
};
pub const CUtensorMap = struct_CUtensorMap_st;
pub const CU_TENSOR_MAP_DATA_TYPE_UINT8: c_int = 0;
pub const CU_TENSOR_MAP_DATA_TYPE_UINT16: c_int = 1;
pub const CU_TENSOR_MAP_DATA_TYPE_UINT32: c_int = 2;
pub const CU_TENSOR_MAP_DATA_TYPE_INT32: c_int = 3;
pub const CU_TENSOR_MAP_DATA_TYPE_UINT64: c_int = 4;
pub const CU_TENSOR_MAP_DATA_TYPE_INT64: c_int = 5;
pub const CU_TENSOR_MAP_DATA_TYPE_FLOAT16: c_int = 6;
pub const CU_TENSOR_MAP_DATA_TYPE_FLOAT32: c_int = 7;
pub const CU_TENSOR_MAP_DATA_TYPE_FLOAT64: c_int = 8;
pub const CU_TENSOR_MAP_DATA_TYPE_BFLOAT16: c_int = 9;
pub const CU_TENSOR_MAP_DATA_TYPE_FLOAT32_FTZ: c_int = 10;
pub const CU_TENSOR_MAP_DATA_TYPE_TFLOAT32: c_int = 11;
pub const CU_TENSOR_MAP_DATA_TYPE_TFLOAT32_FTZ: c_int = 12;
pub const CU_TENSOR_MAP_DATA_TYPE_16U4_ALIGN8B: c_int = 13;
pub const CU_TENSOR_MAP_DATA_TYPE_16U4_ALIGN16B: c_int = 14;
pub const CU_TENSOR_MAP_DATA_TYPE_16U6_ALIGN16B: c_int = 15;
pub const enum_CUtensorMapDataType_enum = c_uint;
pub const CUtensorMapDataType = enum_CUtensorMapDataType_enum;
pub const CU_TENSOR_MAP_INTERLEAVE_NONE: c_int = 0;
pub const CU_TENSOR_MAP_INTERLEAVE_16B: c_int = 1;
pub const CU_TENSOR_MAP_INTERLEAVE_32B: c_int = 2;
pub const enum_CUtensorMapInterleave_enum = c_uint;
pub const CUtensorMapInterleave = enum_CUtensorMapInterleave_enum;
pub const CU_TENSOR_MAP_SWIZZLE_NONE: c_int = 0;
pub const CU_TENSOR_MAP_SWIZZLE_32B: c_int = 1;
pub const CU_TENSOR_MAP_SWIZZLE_64B: c_int = 2;
pub const CU_TENSOR_MAP_SWIZZLE_128B: c_int = 3;
pub const CU_TENSOR_MAP_SWIZZLE_128B_ATOM_32B: c_int = 4;
pub const CU_TENSOR_MAP_SWIZZLE_128B_ATOM_32B_FLIP_8B: c_int = 5;
pub const CU_TENSOR_MAP_SWIZZLE_128B_ATOM_64B: c_int = 6;
pub const enum_CUtensorMapSwizzle_enum = c_uint;
pub const CUtensorMapSwizzle = enum_CUtensorMapSwizzle_enum;
pub const CU_TENSOR_MAP_L2_PROMOTION_NONE: c_int = 0;
pub const CU_TENSOR_MAP_L2_PROMOTION_L2_64B: c_int = 1;
pub const CU_TENSOR_MAP_L2_PROMOTION_L2_128B: c_int = 2;
pub const CU_TENSOR_MAP_L2_PROMOTION_L2_256B: c_int = 3;
pub const enum_CUtensorMapL2promotion_enum = c_uint;
pub const CUtensorMapL2promotion = enum_CUtensorMapL2promotion_enum;
pub const CU_TENSOR_MAP_FLOAT_OOB_FILL_NONE: c_int = 0;
pub const CU_TENSOR_MAP_FLOAT_OOB_FILL_NAN_REQUEST_ZERO_FMA: c_int = 1;
pub const enum_CUtensorMapFloatOOBfill_enum = c_uint;
pub const CUtensorMapFloatOOBfill = enum_CUtensorMapFloatOOBfill_enum;
pub const CU_TENSOR_MAP_IM2COL_WIDE_MODE_W: c_int = 0;
pub const CU_TENSOR_MAP_IM2COL_WIDE_MODE_W128: c_int = 1;
pub const enum_CUtensorMapIm2ColWideMode_enum = c_uint;
pub const CUtensorMapIm2ColWideMode = enum_CUtensorMapIm2ColWideMode_enum;
pub const struct_CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_st = extern struct {
    p2pToken: c_ulonglong = 0,
    vaSpaceToken: c_uint = 0,
};
pub const CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_v1 = struct_CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_st;
pub const CUDA_POINTER_ATTRIBUTE_P2P_TOKENS = CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_v1;
pub const CU_POINTER_ATTRIBUTE_ACCESS_FLAG_NONE: c_int = 0;
pub const CU_POINTER_ATTRIBUTE_ACCESS_FLAG_READ: c_int = 1;
pub const CU_POINTER_ATTRIBUTE_ACCESS_FLAG_READWRITE: c_int = 3;
pub const enum_CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS_enum = c_uint;
pub const CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS = enum_CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS_enum;
pub const struct_CUDA_LAUNCH_PARAMS_st = extern struct {
    function: CUfunction = null,
    gridDimX: c_uint = 0,
    gridDimY: c_uint = 0,
    gridDimZ: c_uint = 0,
    blockDimX: c_uint = 0,
    blockDimY: c_uint = 0,
    blockDimZ: c_uint = 0,
    sharedMemBytes: c_uint = 0,
    hStream: CUstream = null,
    kernelParams: [*c]?*anyopaque = null,
    pub const cuLaunchCooperativeKernelMultiDevice = __root.cuLaunchCooperativeKernelMultiDevice;
};
pub const CUDA_LAUNCH_PARAMS_v1 = struct_CUDA_LAUNCH_PARAMS_st;
pub const CUDA_LAUNCH_PARAMS = CUDA_LAUNCH_PARAMS_v1;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD: c_int = 1;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32: c_int = 2;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_KMT: c_int = 3;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_HEAP: c_int = 4;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_RESOURCE: c_int = 5;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_RESOURCE: c_int = 6;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_RESOURCE_KMT: c_int = 7;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_NVSCIBUF: c_int = 8;
pub const CU_EXTERNAL_MEMORY_HANDLE_TYPE_DMABUF_FD: c_int = 9;
pub const enum_CUexternalMemoryHandleType_enum = c_uint;
pub const CUexternalMemoryHandleType = enum_CUexternalMemoryHandleType_enum;
const struct_unnamed_26 = extern struct {
    handle: ?*anyopaque = null,
    name: ?*const anyopaque = null,
};
const union_unnamed_25 = extern union {
    fd: c_int,
    win32: struct_unnamed_26,
    nvSciBufObject: ?*const anyopaque,
};
pub const struct_CUDA_EXTERNAL_MEMORY_HANDLE_DESC_st = extern struct {
    type: CUexternalMemoryHandleType = @import("std").mem.zeroes(CUexternalMemoryHandleType),
    handle: union_unnamed_25 = @import("std").mem.zeroes(union_unnamed_25),
    size: c_ulonglong = 0,
    flags: c_uint = 0,
    reserved: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
};
pub const CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1 = struct_CUDA_EXTERNAL_MEMORY_HANDLE_DESC_st;
pub const CUDA_EXTERNAL_MEMORY_HANDLE_DESC = CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1;
pub const struct_CUDA_EXTERNAL_MEMORY_BUFFER_DESC_st = extern struct {
    offset: c_ulonglong = 0,
    size: c_ulonglong = 0,
    flags: c_uint = 0,
    reserved: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
};
pub const CUDA_EXTERNAL_MEMORY_BUFFER_DESC_v1 = struct_CUDA_EXTERNAL_MEMORY_BUFFER_DESC_st;
pub const CUDA_EXTERNAL_MEMORY_BUFFER_DESC = CUDA_EXTERNAL_MEMORY_BUFFER_DESC_v1;
pub const struct_CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_st = extern struct {
    offset: c_ulonglong = 0,
    arrayDesc: CUDA_ARRAY3D_DESCRIPTOR = @import("std").mem.zeroes(CUDA_ARRAY3D_DESCRIPTOR),
    numLevels: c_uint = 0,
    reserved: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
};
pub const CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_v1 = struct_CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_st;
pub const CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC = CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_v1;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD: c_int = 1;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32: c_int = 2;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT: c_int = 3;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE: c_int = 4;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_FENCE: c_int = 5;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_NVSCISYNC: c_int = 6;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_KEYED_MUTEX: c_int = 7;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D11_KEYED_MUTEX_KMT: c_int = 8;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_TIMELINE_SEMAPHORE_FD: c_int = 9;
pub const CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_TIMELINE_SEMAPHORE_WIN32: c_int = 10;
pub const enum_CUexternalSemaphoreHandleType_enum = c_uint;
pub const CUexternalSemaphoreHandleType = enum_CUexternalSemaphoreHandleType_enum;
const struct_unnamed_28 = extern struct {
    handle: ?*anyopaque = null,
    name: ?*const anyopaque = null,
};
const union_unnamed_27 = extern union {
    fd: c_int,
    win32: struct_unnamed_28,
    nvSciSyncObj: ?*const anyopaque,
};
pub const struct_CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_st = extern struct {
    type: CUexternalSemaphoreHandleType = @import("std").mem.zeroes(CUexternalSemaphoreHandleType),
    handle: union_unnamed_27 = @import("std").mem.zeroes(union_unnamed_27),
    flags: c_uint = 0,
    reserved: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
};
pub const CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1 = struct_CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_st;
pub const CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC = CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1;
const struct_unnamed_30 = extern struct {
    value: c_ulonglong = 0,
};
const union_unnamed_31 = extern union {
    fence: ?*anyopaque,
    reserved: c_ulonglong,
};
const struct_unnamed_32 = extern struct {
    key: c_ulonglong = 0,
};
const struct_unnamed_29 = extern struct {
    fence: struct_unnamed_30 = @import("std").mem.zeroes(struct_unnamed_30),
    nvSciSync: union_unnamed_31 = @import("std").mem.zeroes(union_unnamed_31),
    keyedMutex: struct_unnamed_32 = @import("std").mem.zeroes(struct_unnamed_32),
    reserved: [12]c_uint = @import("std").mem.zeroes([12]c_uint),
};
pub const struct_CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_st = extern struct {
    params: struct_unnamed_29 = @import("std").mem.zeroes(struct_unnamed_29),
    flags: c_uint = 0,
    reserved: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
};
pub const CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1 = struct_CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_st;
pub const CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS = CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1;
const struct_unnamed_34 = extern struct {
    value: c_ulonglong = 0,
};
const union_unnamed_35 = extern union {
    fence: ?*anyopaque,
    reserved: c_ulonglong,
};
const struct_unnamed_36 = extern struct {
    key: c_ulonglong = 0,
    timeoutMs: c_uint = 0,
};
const struct_unnamed_33 = extern struct {
    fence: struct_unnamed_34 = @import("std").mem.zeroes(struct_unnamed_34),
    nvSciSync: union_unnamed_35 = @import("std").mem.zeroes(union_unnamed_35),
    keyedMutex: struct_unnamed_36 = @import("std").mem.zeroes(struct_unnamed_36),
    reserved: [10]c_uint = @import("std").mem.zeroes([10]c_uint),
};
pub const struct_CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_st = extern struct {
    params: struct_unnamed_33 = @import("std").mem.zeroes(struct_unnamed_33),
    flags: c_uint = 0,
    reserved: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
};
pub const CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1 = struct_CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_st;
pub const CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS = CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1;
pub const struct_CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_st = extern struct {
    extSemArray: [*c]CUexternalSemaphore = null,
    paramsArray: [*c]const CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS = null,
    numExtSems: c_uint = 0,
};
pub const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v1 = struct_CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_st;
pub const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS = CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v1;
const union_unnamed_37 = extern union {
    ctx: CUcontext,
    gCtx: CUgreenCtx,
};
pub const struct_CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v2_st = extern struct {
    extSemArray: [*c]CUexternalSemaphore = null,
    paramsArray: [*c]const CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS = null,
    numExtSems: c_uint = 0,
    unnamed_0: union_unnamed_37 = @import("std").mem.zeroes(union_unnamed_37),
};
pub const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v2 = struct_CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v2_st;
pub const struct_CUDA_EXT_SEM_WAIT_NODE_PARAMS_st = extern struct {
    extSemArray: [*c]CUexternalSemaphore = null,
    paramsArray: [*c]const CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS = null,
    numExtSems: c_uint = 0,
};
pub const CUDA_EXT_SEM_WAIT_NODE_PARAMS_v1 = struct_CUDA_EXT_SEM_WAIT_NODE_PARAMS_st;
pub const CUDA_EXT_SEM_WAIT_NODE_PARAMS = CUDA_EXT_SEM_WAIT_NODE_PARAMS_v1;
const union_unnamed_38 = extern union {
    ctx: CUcontext,
    gCtx: CUgreenCtx,
};
pub const struct_CUDA_EXT_SEM_WAIT_NODE_PARAMS_v2_st = extern struct {
    extSemArray: [*c]CUexternalSemaphore = null,
    paramsArray: [*c]const CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS = null,
    numExtSems: c_uint = 0,
    unnamed_0: union_unnamed_38 = @import("std").mem.zeroes(union_unnamed_38),
};
pub const CUDA_EXT_SEM_WAIT_NODE_PARAMS_v2 = struct_CUDA_EXT_SEM_WAIT_NODE_PARAMS_v2_st;
pub const CUmemGenericAllocationHandle_v1 = c_ulonglong;
pub const CUmemGenericAllocationHandle = CUmemGenericAllocationHandle_v1;
pub const CU_MEM_HANDLE_TYPE_NONE: c_int = 0;
pub const CU_MEM_HANDLE_TYPE_POSIX_FILE_DESCRIPTOR: c_int = 1;
pub const CU_MEM_HANDLE_TYPE_WIN32: c_int = 2;
pub const CU_MEM_HANDLE_TYPE_WIN32_KMT: c_int = 4;
pub const CU_MEM_HANDLE_TYPE_FABRIC: c_int = 8;
pub const CU_MEM_HANDLE_TYPE_MAX: c_int = 2147483647;
pub const enum_CUmemAllocationHandleType_enum = c_uint;
pub const CUmemAllocationHandleType = enum_CUmemAllocationHandleType_enum;
pub const CU_MEM_ACCESS_FLAGS_PROT_NONE: c_int = 0;
pub const CU_MEM_ACCESS_FLAGS_PROT_READ: c_int = 1;
pub const CU_MEM_ACCESS_FLAGS_PROT_READWRITE: c_int = 3;
pub const CU_MEM_ACCESS_FLAGS_PROT_MAX: c_int = 2147483647;
pub const enum_CUmemAccess_flags_enum = c_uint;
pub const CUmemAccess_flags = enum_CUmemAccess_flags_enum;
pub const CU_MEM_LOCATION_TYPE_INVALID: c_int = 0;
pub const CU_MEM_LOCATION_TYPE_NONE: c_int = 0;
pub const CU_MEM_LOCATION_TYPE_DEVICE: c_int = 1;
pub const CU_MEM_LOCATION_TYPE_HOST: c_int = 2;
pub const CU_MEM_LOCATION_TYPE_HOST_NUMA: c_int = 3;
pub const CU_MEM_LOCATION_TYPE_HOST_NUMA_CURRENT: c_int = 4;
pub const CU_MEM_LOCATION_TYPE_INVISIBLE: c_int = 5;
pub const CU_MEM_LOCATION_TYPE_DEVICE_LOCALITY_DOMAIN: c_int = 6;
pub const CU_MEM_LOCATION_TYPE_MAX: c_int = 2147483647;
pub const enum_CUmemLocationType_enum = c_uint;
pub const CUmemLocationType = enum_CUmemLocationType_enum;
pub const CU_MEM_ALLOCATION_TYPE_INVALID: c_int = 0;
pub const CU_MEM_ALLOCATION_TYPE_PINNED: c_int = 1;
pub const CU_MEM_ALLOCATION_TYPE_MANAGED: c_int = 2;
pub const CU_MEM_ALLOCATION_TYPE_MAX: c_int = 2147483647;
pub const enum_CUmemAllocationType_enum = c_uint;
pub const CUmemAllocationType = enum_CUmemAllocationType_enum;
pub const CU_MEM_ALLOC_GRANULARITY_MINIMUM: c_int = 0;
pub const CU_MEM_ALLOC_GRANULARITY_RECOMMENDED: c_int = 1;
pub const enum_CUmemAllocationGranularity_flags_enum = c_uint;
pub const CUmemAllocationGranularity_flags = enum_CUmemAllocationGranularity_flags_enum;
pub const CU_MEM_RANGE_HANDLE_TYPE_DMA_BUF_FD: c_int = 1;
pub const CU_MEM_RANGE_HANDLE_TYPE_MAX: c_int = 2147483647;
pub const enum_CUmemRangeHandleType_enum = c_uint;
pub const CUmemRangeHandleType = enum_CUmemRangeHandleType_enum;
pub const CU_MEM_RANGE_FLAG_DMA_BUF_MAPPING_TYPE_PCIE: c_int = 1;
pub const enum_CUmemRangeFlags_enum = c_uint;
pub const CUmemRangeFlags = enum_CUmemRangeFlags_enum;
pub const CU_ARRAY_SPARSE_SUBRESOURCE_TYPE_SPARSE_LEVEL: c_int = 0;
pub const CU_ARRAY_SPARSE_SUBRESOURCE_TYPE_MIPTAIL: c_int = 1;
pub const enum_CUarraySparseSubresourceType_enum = c_uint;
pub const CUarraySparseSubresourceType = enum_CUarraySparseSubresourceType_enum;
pub const CU_MEM_OPERATION_TYPE_MAP: c_int = 1;
pub const CU_MEM_OPERATION_TYPE_UNMAP: c_int = 2;
pub const enum_CUmemOperationType_enum = c_uint;
pub const CUmemOperationType = enum_CUmemOperationType_enum;
pub const CU_MEM_HANDLE_TYPE_GENERIC: c_int = 0;
pub const enum_CUmemHandleType_enum = c_uint;
pub const CUmemHandleType = enum_CUmemHandleType_enum;
const union_unnamed_39 = extern union {
    mipmap: CUmipmappedArray,
    array: CUarray,
};
const struct_unnamed_41 = extern struct {
    level: c_uint = 0,
    layer: c_uint = 0,
    offsetX: c_uint = 0,
    offsetY: c_uint = 0,
    offsetZ: c_uint = 0,
    extentWidth: c_uint = 0,
    extentHeight: c_uint = 0,
    extentDepth: c_uint = 0,
};
const struct_unnamed_42 = extern struct {
    layer: c_uint = 0,
    offset: c_ulonglong = 0,
    size: c_ulonglong = 0,
};
const union_unnamed_40 = extern union {
    sparseLevel: struct_unnamed_41,
    miptail: struct_unnamed_42,
};
const union_unnamed_43 = extern union {
    memHandle: CUmemGenericAllocationHandle,
};
pub const struct_CUarrayMapInfo_st = extern struct {
    resourceType: CUresourcetype = @import("std").mem.zeroes(CUresourcetype),
    resource: union_unnamed_39 = @import("std").mem.zeroes(union_unnamed_39),
    subresourceType: CUarraySparseSubresourceType = @import("std").mem.zeroes(CUarraySparseSubresourceType),
    subresource: union_unnamed_40 = @import("std").mem.zeroes(union_unnamed_40),
    memOperationType: CUmemOperationType = @import("std").mem.zeroes(CUmemOperationType),
    memHandleType: CUmemHandleType = @import("std").mem.zeroes(CUmemHandleType),
    memHandle: union_unnamed_43 = @import("std").mem.zeroes(union_unnamed_43),
    offset: c_ulonglong = 0,
    deviceBitMask: c_uint = 0,
    flags: c_uint = 0,
    reserved: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    pub const cuMemMapArrayAsync = __root.cuMemMapArrayAsync;
};
pub const CUarrayMapInfo_v1 = struct_CUarrayMapInfo_st;
pub const CUarrayMapInfo = CUarrayMapInfo_v1;
const struct_unnamed_45 = extern struct {
    deviceId: u8 = 0,
    localityDomainId: u8 = 0,
};
const union_unnamed_44 = extern union {
    id: c_int,
    localized: struct_unnamed_45,
};
pub const struct_CUmemLocation_st = extern struct {
    type: CUmemLocationType = @import("std").mem.zeroes(CUmemLocationType),
    unnamed_0: union_unnamed_44 = @import("std").mem.zeroes(union_unnamed_44),
    pub const cuMemSetMemPool = __root.cuMemSetMemPool;
};
pub const CUmemLocation_v1 = struct_CUmemLocation_st;
pub const CUmemLocation = CUmemLocation_v1;
pub const CU_MEM_ALLOCATION_COMP_NONE: c_int = 0;
pub const CU_MEM_ALLOCATION_COMP_GENERIC: c_int = 1;
pub const enum_CUmemAllocationCompType_enum = c_uint;
pub const CUmemAllocationCompType = enum_CUmemAllocationCompType_enum;
const struct_unnamed_46 = extern struct {
    compressionType: u8 = 0,
    gpuDirectRDMACapable: u8 = 0,
    usage: c_ushort = 0,
    reserved: [4]u8 = @import("std").mem.zeroes([4]u8),
};
pub const struct_CUmemAllocationProp_st = extern struct {
    type: CUmemAllocationType = @import("std").mem.zeroes(CUmemAllocationType),
    requestedHandleTypes: CUmemAllocationHandleType = @import("std").mem.zeroes(CUmemAllocationHandleType),
    location: CUmemLocation = @import("std").mem.zeroes(CUmemLocation),
    win32HandleMetaData: ?*anyopaque = null,
    allocFlags: struct_unnamed_46 = @import("std").mem.zeroes(struct_unnamed_46),
    pub const cuMemGetAllocationPropertiesFromHandle = __root.cuMemGetAllocationPropertiesFromHandle;
};
pub const CUmemAllocationProp_v1 = struct_CUmemAllocationProp_st;
pub const CUmemAllocationProp = CUmemAllocationProp_v1;
pub const CU_MULTICAST_GRANULARITY_MINIMUM: c_int = 0;
pub const CU_MULTICAST_GRANULARITY_RECOMMENDED: c_int = 1;
pub const enum_CUmulticastGranularity_flags_enum = c_uint;
pub const CUmulticastGranularity_flags = enum_CUmulticastGranularity_flags_enum;
pub const struct_CUmulticastObjectProp_st = extern struct {
    numDevices: c_uint = 0,
    size: usize = 0,
    handleTypes: c_ulonglong = 0,
    flags: c_ulonglong = 0,
};
pub const CUmulticastObjectProp_v1 = struct_CUmulticastObjectProp_st;
pub const CUmulticastObjectProp = CUmulticastObjectProp_v1;
pub const struct_CUmemAccessDesc_st = extern struct {
    location: CUmemLocation = @import("std").mem.zeroes(CUmemLocation),
    flags: CUmemAccess_flags = @import("std").mem.zeroes(CUmemAccess_flags),
};
pub const CUmemAccessDesc_v1 = struct_CUmemAccessDesc_st;
pub const CUmemAccessDesc = CUmemAccessDesc_v1;
pub const CU_GRAPH_EXEC_UPDATE_SUCCESS: c_int = 0;
pub const CU_GRAPH_EXEC_UPDATE_ERROR: c_int = 1;
pub const CU_GRAPH_EXEC_UPDATE_ERROR_TOPOLOGY_CHANGED: c_int = 2;
pub const CU_GRAPH_EXEC_UPDATE_ERROR_NODE_TYPE_CHANGED: c_int = 3;
pub const CU_GRAPH_EXEC_UPDATE_ERROR_FUNCTION_CHANGED: c_int = 4;
pub const CU_GRAPH_EXEC_UPDATE_ERROR_PARAMETERS_CHANGED: c_int = 5;
pub const CU_GRAPH_EXEC_UPDATE_ERROR_NOT_SUPPORTED: c_int = 6;
pub const CU_GRAPH_EXEC_UPDATE_ERROR_UNSUPPORTED_FUNCTION_CHANGE: c_int = 7;
pub const CU_GRAPH_EXEC_UPDATE_ERROR_ATTRIBUTES_CHANGED: c_int = 8;
pub const enum_CUgraphExecUpdateResult_enum = c_uint;
pub const CUgraphExecUpdateResult = enum_CUgraphExecUpdateResult_enum;
pub const struct_CUgraphExecUpdateResultInfo_st = extern struct {
    result: CUgraphExecUpdateResult = @import("std").mem.zeroes(CUgraphExecUpdateResult),
    errorNode: CUgraphNode = null,
    errorFromNode: CUgraphNode = null,
};
pub const CUgraphExecUpdateResultInfo_v1 = struct_CUgraphExecUpdateResultInfo_st;
pub const CUgraphExecUpdateResultInfo = CUgraphExecUpdateResultInfo_v1;
pub const CU_MEMPOOL_ATTR_REUSE_FOLLOW_EVENT_DEPENDENCIES: c_int = 1;
pub const CU_MEMPOOL_ATTR_REUSE_ALLOW_OPPORTUNISTIC: c_int = 2;
pub const CU_MEMPOOL_ATTR_REUSE_ALLOW_INTERNAL_DEPENDENCIES: c_int = 3;
pub const CU_MEMPOOL_ATTR_RELEASE_THRESHOLD: c_int = 4;
pub const CU_MEMPOOL_ATTR_RESERVED_MEM_CURRENT: c_int = 5;
pub const CU_MEMPOOL_ATTR_RESERVED_MEM_HIGH: c_int = 6;
pub const CU_MEMPOOL_ATTR_USED_MEM_CURRENT: c_int = 7;
pub const CU_MEMPOOL_ATTR_USED_MEM_HIGH: c_int = 8;
pub const CU_MEMPOOL_ATTR_ALLOCATION_TYPE: c_int = 9;
pub const CU_MEMPOOL_ATTR_EXPORT_HANDLE_TYPES: c_int = 10;
pub const CU_MEMPOOL_ATTR_LOCATION_ID: c_int = 11;
pub const CU_MEMPOOL_ATTR_LOCATION_TYPE: c_int = 12;
pub const CU_MEMPOOL_ATTR_MAX_POOL_SIZE: c_int = 13;
pub const CU_MEMPOOL_ATTR_HW_DECOMPRESS_ENABLED: c_int = 14;
pub const CU_MEMPOOL_ATTR_LOCALITY_DOMAIN_ID: c_int = 15;
pub const enum_CUmemPool_attribute_enum = c_uint;
pub const CUmemPool_attribute = enum_CUmemPool_attribute_enum;
pub const struct_CUmemPoolProps_st = extern struct {
    allocType: CUmemAllocationType = @import("std").mem.zeroes(CUmemAllocationType),
    handleTypes: CUmemAllocationHandleType = @import("std").mem.zeroes(CUmemAllocationHandleType),
    location: CUmemLocation = @import("std").mem.zeroes(CUmemLocation),
    win32SecurityAttributes: ?*anyopaque = null,
    maxSize: usize = 0,
    usage: c_ushort = 0,
    gpuDirectRDMACapable: u8 = 0,
    reserved: [53]u8 = @import("std").mem.zeroes([53]u8),
};
pub const CUmemPoolProps_v1 = struct_CUmemPoolProps_st;
pub const CUmemPoolProps = CUmemPoolProps_v1;
pub const struct_CUmemPoolPtrExportData_st = extern struct {
    reserved: [64]u8 = @import("std").mem.zeroes([64]u8),
    pub const cuMemPoolExportPointer = __root.cuMemPoolExportPointer;
};
pub const CUmemPoolPtrExportData_v1 = struct_CUmemPoolPtrExportData_st;
pub const CUmemPoolPtrExportData = CUmemPoolPtrExportData_v1;
pub const CU_MEMCPY_FLAG_DEFAULT: c_int = 0;
pub const CU_MEMCPY_FLAG_PREFER_OVERLAP_WITH_COMPUTE: c_int = 1;
pub const enum_CUmemcpyFlags_enum = c_uint;
pub const CUmemcpyFlags = enum_CUmemcpyFlags_enum;
pub const CU_MEMCPY_SRC_ACCESS_ORDER_INVALID: c_int = 0;
pub const CU_MEMCPY_SRC_ACCESS_ORDER_STREAM: c_int = 1;
pub const CU_MEMCPY_SRC_ACCESS_ORDER_DURING_API_CALL: c_int = 2;
pub const CU_MEMCPY_SRC_ACCESS_ORDER_ANY: c_int = 3;
pub const CU_MEMCPY_SRC_ACCESS_ORDER_MAX: c_int = 2147483647;
pub const enum_CUmemcpySrcAccessOrder_enum = c_uint;
pub const CUmemcpySrcAccessOrder = enum_CUmemcpySrcAccessOrder_enum;
pub const struct_CUmemcpyAttributes_st = extern struct {
    srcAccessOrder: CUmemcpySrcAccessOrder = @import("std").mem.zeroes(CUmemcpySrcAccessOrder),
    srcLocHint: CUmemLocation = @import("std").mem.zeroes(CUmemLocation),
    dstLocHint: CUmemLocation = @import("std").mem.zeroes(CUmemLocation),
    flags: c_uint = 0,
};
pub const CUmemcpyAttributes_v1 = struct_CUmemcpyAttributes_st;
pub const CUmemcpyAttributes = CUmemcpyAttributes_v1;
pub const CU_MEMCPY_OPERAND_TYPE_POINTER: c_int = 1;
pub const CU_MEMCPY_OPERAND_TYPE_ARRAY: c_int = 2;
pub const CU_MEMCPY_OPERAND_TYPE_MAX: c_int = 2147483647;
pub const enum_CUmemcpy3DOperandType_enum = c_uint;
pub const CUmemcpy3DOperandType = enum_CUmemcpy3DOperandType_enum;
pub const struct_CUoffset3D_st = extern struct {
    x: usize = 0,
    y: usize = 0,
    z: usize = 0,
};
pub const CUoffset3D_v1 = struct_CUoffset3D_st;
pub const CUoffset3D = CUoffset3D_v1;
pub const struct_CUextent3D_st = extern struct {
    width: usize = 0,
    height: usize = 0,
    depth: usize = 0,
};
pub const CUextent3D_v1 = struct_CUextent3D_st;
pub const CUextent3D = CUextent3D_v1;
const struct_unnamed_48 = extern struct {
    ptr: CUdeviceptr = 0,
    rowLength: usize = 0,
    layerHeight: usize = 0,
    locHint: CUmemLocation = @import("std").mem.zeroes(CUmemLocation),
};
const struct_unnamed_49 = extern struct {
    array: CUarray = null,
    offset: CUoffset3D = @import("std").mem.zeroes(CUoffset3D),
};
const union_unnamed_47 = extern union {
    ptr: struct_unnamed_48,
    array: struct_unnamed_49,
};
pub const struct_CUmemcpy3DOperand_st = extern struct {
    type: CUmemcpy3DOperandType = @import("std").mem.zeroes(CUmemcpy3DOperandType),
    op: union_unnamed_47 = @import("std").mem.zeroes(union_unnamed_47),
};
pub const CUmemcpy3DOperand_v1 = struct_CUmemcpy3DOperand_st;
pub const CUmemcpy3DOperand = CUmemcpy3DOperand_v1;
pub const struct_CUDA_MEMCPY3D_BATCH_OP_st = extern struct {
    src: CUmemcpy3DOperand = @import("std").mem.zeroes(CUmemcpy3DOperand),
    dst: CUmemcpy3DOperand = @import("std").mem.zeroes(CUmemcpy3DOperand),
    extent: CUextent3D = @import("std").mem.zeroes(CUextent3D),
    srcAccessOrder: CUmemcpySrcAccessOrder = @import("std").mem.zeroes(CUmemcpySrcAccessOrder),
    flags: c_uint = 0,
    pub const cuMemcpy3DWithAttributesAsync = __root.cuMemcpy3DWithAttributesAsync;
};
pub const CUDA_MEMCPY3D_BATCH_OP_v1 = struct_CUDA_MEMCPY3D_BATCH_OP_st;
pub const CUDA_MEMCPY3D_BATCH_OP = CUDA_MEMCPY3D_BATCH_OP_v1;
pub const struct_CUDA_MEM_ALLOC_NODE_PARAMS_v1_st = extern struct {
    poolProps: CUmemPoolProps = @import("std").mem.zeroes(CUmemPoolProps),
    accessDescs: [*c]const CUmemAccessDesc = null,
    accessDescCount: usize = 0,
    bytesize: usize = 0,
    dptr: CUdeviceptr = 0,
};
pub const CUDA_MEM_ALLOC_NODE_PARAMS_v1 = struct_CUDA_MEM_ALLOC_NODE_PARAMS_v1_st;
pub const CUDA_MEM_ALLOC_NODE_PARAMS = CUDA_MEM_ALLOC_NODE_PARAMS_v1;
pub const struct_CUDA_MEM_ALLOC_NODE_PARAMS_v2_st = extern struct {
    poolProps: CUmemPoolProps = @import("std").mem.zeroes(CUmemPoolProps),
    accessDescs: [*c]const CUmemAccessDesc = null,
    accessDescCount: usize = 0,
    bytesize: usize = 0,
    dptr: CUdeviceptr = 0,
};
pub const CUDA_MEM_ALLOC_NODE_PARAMS_v2 = struct_CUDA_MEM_ALLOC_NODE_PARAMS_v2_st;
pub const struct_CUDA_MEM_FREE_NODE_PARAMS_st = extern struct {
    dptr: CUdeviceptr = 0,
};
pub const CUDA_MEM_FREE_NODE_PARAMS = struct_CUDA_MEM_FREE_NODE_PARAMS_st;
pub const CU_GRAPH_MEM_ATTR_USED_MEM_CURRENT: c_int = 0;
pub const CU_GRAPH_MEM_ATTR_USED_MEM_HIGH: c_int = 1;
pub const CU_GRAPH_MEM_ATTR_RESERVED_MEM_CURRENT: c_int = 2;
pub const CU_GRAPH_MEM_ATTR_RESERVED_MEM_HIGH: c_int = 3;
pub const enum_CUgraphMem_attribute_enum = c_uint;
pub const CUgraphMem_attribute = enum_CUgraphMem_attribute_enum;
pub const CU_GRAPH_CHILD_GRAPH_OWNERSHIP_CLONE: c_int = 0;
pub const CU_GRAPH_CHILD_GRAPH_OWNERSHIP_MOVE: c_int = 1;
pub const CU_GRAPH_CHILD_GRAPH_OWNERSHIP_INVALID: c_int = -1;
pub const enum_CUgraphChildGraphNodeOwnership_enum = c_int;
pub const CUgraphChildGraphNodeOwnership = enum_CUgraphChildGraphNodeOwnership_enum;
pub const struct_CUDA_CHILD_GRAPH_NODE_PARAMS_st = extern struct {
    graph: CUgraph = null,
    ownership: CUgraphChildGraphNodeOwnership = @import("std").mem.zeroes(CUgraphChildGraphNodeOwnership),
};
pub const CUDA_CHILD_GRAPH_NODE_PARAMS = struct_CUDA_CHILD_GRAPH_NODE_PARAMS_st;
const union_unnamed_50 = extern union {
    ctx: CUcontext,
    gCtx: CUgreenCtx,
};
pub const struct_CUDA_EVENT_RECORD_NODE_PARAMS_st = extern struct {
    event: CUevent = null,
    unnamed_0: union_unnamed_50 = @import("std").mem.zeroes(union_unnamed_50),
};
pub const CUDA_EVENT_RECORD_NODE_PARAMS = struct_CUDA_EVENT_RECORD_NODE_PARAMS_st;
pub const struct_CUDA_EVENT_WAIT_NODE_PARAMS_st = extern struct {
    event: CUevent = null,
};
pub const CUDA_EVENT_WAIT_NODE_PARAMS = struct_CUDA_EVENT_WAIT_NODE_PARAMS_st;
const union_unnamed_51 = extern union {
    reserved1: [29]c_longlong,
    kernel: CUDA_KERNEL_NODE_PARAMS_v3,
    memcpy: CUDA_MEMCPY_NODE_PARAMS,
    memset: CUDA_MEMSET_NODE_PARAMS_v2,
    host: CUDA_HOST_NODE_PARAMS_v2,
    graph: CUDA_CHILD_GRAPH_NODE_PARAMS,
    eventWait: CUDA_EVENT_WAIT_NODE_PARAMS,
    eventRecord: CUDA_EVENT_RECORD_NODE_PARAMS,
    extSemSignal: CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v2,
    extSemWait: CUDA_EXT_SEM_WAIT_NODE_PARAMS_v2,
    alloc: CUDA_MEM_ALLOC_NODE_PARAMS_v2,
    free: CUDA_MEM_FREE_NODE_PARAMS,
    memOp: CUDA_BATCH_MEM_OP_NODE_PARAMS_v2,
    conditional: CUDA_CONDITIONAL_NODE_PARAMS,
    asBytes: [232]u8,
};
pub const struct_CUgraphNodeParams_st = extern struct {
    type: CUgraphNodeType = @import("std").mem.zeroes(CUgraphNodeType),
    reserved0: [3]c_int = @import("std").mem.zeroes([3]c_int),
    unnamed_0: union_unnamed_51 = @import("std").mem.zeroes(union_unnamed_51),
    reserved2: c_longlong = 0,
};
pub const CUgraphNodeParams = struct_CUgraphNodeParams_st;
pub const CU_FLUSH_GPU_DIRECT_RDMA_WRITES_OPTION_HOST: c_int = 1;
pub const CU_FLUSH_GPU_DIRECT_RDMA_WRITES_OPTION_MEMOPS: c_int = 2;
pub const enum_CUflushGPUDirectRDMAWritesOptions_enum = c_uint;
pub const CUflushGPUDirectRDMAWritesOptions = enum_CUflushGPUDirectRDMAWritesOptions_enum;
pub const CU_GPU_DIRECT_RDMA_WRITES_ORDERING_NONE: c_int = 0;
pub const CU_GPU_DIRECT_RDMA_WRITES_ORDERING_OWNER: c_int = 100;
pub const CU_GPU_DIRECT_RDMA_WRITES_ORDERING_ALL_DEVICES: c_int = 200;
pub const enum_CUGPUDirectRDMAWritesOrdering_enum = c_uint;
pub const CUGPUDirectRDMAWritesOrdering = enum_CUGPUDirectRDMAWritesOrdering_enum;
pub const CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TO_OWNER: c_int = 100;
pub const CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TO_ALL_DEVICES: c_int = 200;
pub const enum_CUflushGPUDirectRDMAWritesScope_enum = c_uint;
pub const CUflushGPUDirectRDMAWritesScope = enum_CUflushGPUDirectRDMAWritesScope_enum;
pub const CU_FLUSH_GPU_DIRECT_RDMA_WRITES_TARGET_CURRENT_CTX: c_int = 0;
pub const enum_CUflushGPUDirectRDMAWritesTarget_enum = c_uint;
pub const CUflushGPUDirectRDMAWritesTarget = enum_CUflushGPUDirectRDMAWritesTarget_enum;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_VERBOSE: c_int = 1;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_RUNTIME_TYPES: c_int = 2;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_KERNEL_NODE_PARAMS: c_int = 4;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_MEMCPY_NODE_PARAMS: c_int = 8;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_MEMSET_NODE_PARAMS: c_int = 16;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_HOST_NODE_PARAMS: c_int = 32;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_EVENT_NODE_PARAMS: c_int = 64;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_EXT_SEMAS_SIGNAL_NODE_PARAMS: c_int = 128;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_EXT_SEMAS_WAIT_NODE_PARAMS: c_int = 256;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_KERNEL_NODE_ATTRIBUTES: c_int = 512;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_HANDLES: c_int = 1024;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_MEM_ALLOC_NODE_PARAMS: c_int = 2048;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_MEM_FREE_NODE_PARAMS: c_int = 4096;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_BATCH_MEM_OP_NODE_PARAMS: c_int = 8192;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_EXTRA_TOPO_INFO: c_int = 16384;
pub const CU_GRAPH_DEBUG_DOT_FLAGS_CONDITIONAL_NODE_PARAMS: c_int = 32768;
pub const enum_CUgraphDebugDot_flags_enum = c_uint;
pub const CUgraphDebugDot_flags = enum_CUgraphDebugDot_flags_enum;
pub const CU_USER_OBJECT_NO_DESTRUCTOR_SYNC: c_int = 1;
pub const enum_CUuserObject_flags_enum = c_uint;
pub const CUuserObject_flags = enum_CUuserObject_flags_enum;
pub const CU_GRAPH_USER_OBJECT_MOVE: c_int = 1;
pub const enum_CUuserObjectRetain_flags_enum = c_uint;
pub const CUuserObjectRetain_flags = enum_CUuserObjectRetain_flags_enum;
pub const CUDA_GRAPH_INSTANTIATE_FLAG_AUTO_FREE_ON_LAUNCH: c_int = 1;
pub const CUDA_GRAPH_INSTANTIATE_FLAG_UPLOAD: c_int = 2;
pub const CUDA_GRAPH_INSTANTIATE_FLAG_DEVICE_LAUNCH: c_int = 4;
pub const CUDA_GRAPH_INSTANTIATE_FLAG_USE_NODE_PRIORITY: c_int = 8;
pub const enum_CUgraphInstantiate_flags_enum = c_uint;
pub const CUgraphInstantiate_flags = enum_CUgraphInstantiate_flags_enum;
pub const CU_DEVICE_NUMA_CONFIG_NONE: c_int = 0;
pub const CU_DEVICE_NUMA_CONFIG_NUMA_NODE: c_int = 1;
pub const enum_CUdeviceNumaConfig_enum = c_uint;
pub const CUdeviceNumaConfig = enum_CUdeviceNumaConfig_enum;
pub const CU_PROCESS_STATE_RUNNING: c_int = 0;
pub const CU_PROCESS_STATE_LOCKED: c_int = 1;
pub const CU_PROCESS_STATE_CHECKPOINTED: c_int = 2;
pub const CU_PROCESS_STATE_FAILED: c_int = 3;
pub const CU_PROCESS_STATE_CHECKPOINTING: c_int = 4;
pub const CU_PROCESS_STATE_RESTORING: c_int = 5;
pub const enum_CUprocessState_enum = c_uint;
pub const CUprocessState = enum_CUprocessState_enum;
pub const struct_CUcheckpointCustomStoragePerDeviceData_st = extern struct {
    devPtr: CUdeviceptr = 0,
    size: usize = 0,
    stream: CUstream = null,
};
pub const CUcheckpointCustomStoragePerDeviceData = struct_CUcheckpointCustomStoragePerDeviceData_st;
pub const struct_CUIcheckpointOperation_st = opaque {
    pub const cuCheckpointOperationComplete = __root.cuCheckpointOperationComplete;
};
pub const CUcheckpointOperationHandle = ?*struct_CUIcheckpointOperation_st;
pub const struct_CUcheckpointCustomStorageInfo_st = extern struct {
    handle: CUcheckpointOperationHandle = null,
    perDeviceData: [*c]CUcheckpointCustomStoragePerDeviceData = null,
    deviceCount: c_uint = 0,
};
pub const CUcheckpointCustomStorageInfo = struct_CUcheckpointCustomStorageInfo_st;
pub const struct_CUcheckpointLockArgs_st = extern struct {
    timeoutMs: c_uint = 0,
    reserved0: c_uint = 0,
    reserved1: [7]cuuint64_t = @import("std").mem.zeroes([7]cuuint64_t),
};
pub const CUcheckpointLockArgs = struct_CUcheckpointLockArgs_st;
pub const struct_CUcheckpointCheckpointArgs_st = extern struct {
    customStorageInfo_out: [*c][*c]CUcheckpointCustomStorageInfo = null,
    reserved: [56]u8 = @import("std").mem.zeroes([56]u8),
};
pub const CUcheckpointCheckpointArgs = struct_CUcheckpointCheckpointArgs_st;
pub const struct_CUcheckpointGpuPair_st = extern struct {
    oldUuid: CUuuid = @import("std").mem.zeroes(CUuuid),
    newUuid: CUuuid = @import("std").mem.zeroes(CUuuid),
};
pub const CUcheckpointGpuPair = struct_CUcheckpointGpuPair_st;
pub const struct_CUcheckpointRestoreArgs_st = extern struct {
    gpuPairs: [*c]CUcheckpointGpuPair = null,
    gpuPairsCount: c_uint = 0,
    padding0: c_uint = 0,
    customStorageInfo_out: [*c][*c]CUcheckpointCustomStorageInfo = null,
    reserved: [40]u8 = @import("std").mem.zeroes([40]u8),
};
pub const CUcheckpointRestoreArgs = struct_CUcheckpointRestoreArgs_st;
pub const struct_CUcheckpointUnlockArgs_st = extern struct {
    reserved: [8]cuuint64_t = @import("std").mem.zeroes([8]cuuint64_t),
};
pub const CUcheckpointUnlockArgs = struct_CUcheckpointUnlockArgs_st;
pub extern fn cuGetErrorString(@"error": CUresult, pStr: [*c][*c]const u8) CUresult;
pub extern fn cuGetErrorName(@"error": CUresult, pStr: [*c][*c]const u8) CUresult;
pub extern fn cuInit(Flags: c_uint) CUresult;
pub extern fn cuDriverGetVersion(driverVersion: [*c]c_int) CUresult;
pub extern fn cuDeviceGet(device: [*c]CUdevice, ordinal: c_int) CUresult;
pub extern fn cuDeviceGetCount(count: [*c]c_int) CUresult;
pub extern fn cuDeviceGetName(name: [*c]u8, len: c_int, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetUuid_v2(uuid: [*c]CUuuid, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetLuid(luid: [*c]u8, deviceNodeMask: [*c]c_uint, dev: CUdevice) CUresult;
pub extern fn cuDeviceTotalMem_v2(bytes: [*c]usize, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetTexture1DLinearMaxWidth(maxWidthInElements: [*c]usize, format: CUarray_format, numChannels: c_uint, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetAttribute(pi: [*c]c_int, attrib: CUdevice_attribute, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetHostAtomicCapabilities(capabilities: [*c]c_uint, operations: [*c]const CUatomicOperation, count: c_uint, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetNvSciSyncAttributes(nvSciSyncAttrList: ?*anyopaque, dev: CUdevice, flags: c_int) CUresult;
pub extern fn cuDeviceSetMemPool(dev: CUdevice, pool: CUmemoryPool) CUresult;
pub extern fn cuDeviceGetMemPool(pool: [*c]CUmemoryPool, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetDefaultMemPool(pool_out: [*c]CUmemoryPool, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetExecAffinitySupport(pi: [*c]c_int, @"type": CUexecAffinityType, dev: CUdevice) CUresult;
pub extern fn cuFlushGPUDirectRDMAWrites(target: CUflushGPUDirectRDMAWritesTarget, scope: CUflushGPUDirectRDMAWritesScope) CUresult;
pub extern fn cuDeviceGetProperties(prop: [*c]CUdevprop, dev: CUdevice) CUresult;
pub extern fn cuDeviceComputeCapability(major: [*c]c_int, minor: [*c]c_int, dev: CUdevice) CUresult;
pub extern fn cuDevicePrimaryCtxRetain(pctx: [*c]CUcontext, dev: CUdevice) CUresult;
pub extern fn cuDevicePrimaryCtxRelease_v2(dev: CUdevice) CUresult;
pub extern fn cuDevicePrimaryCtxSetFlags_v2(dev: CUdevice, flags: c_uint) CUresult;
pub extern fn cuDevicePrimaryCtxGetState(dev: CUdevice, flags: [*c]c_uint, active: [*c]c_int) CUresult;
pub extern fn cuDevicePrimaryCtxReset_v2(dev: CUdevice) CUresult;
pub extern fn cuCtxCreate_v4(pctx: [*c]CUcontext, ctxCreateParams: [*c]CUctxCreateParams, flags: c_uint, dev: CUdevice) CUresult;
pub extern fn cuCtxDestroy_v2(ctx: CUcontext) CUresult;
pub extern fn cuCtxPushCurrent_v2(ctx: CUcontext) CUresult;
pub extern fn cuCtxPopCurrent_v2(pctx: [*c]CUcontext) CUresult;
pub extern fn cuCtxSetCurrent(ctx: CUcontext) CUresult;
pub extern fn cuCtxGetCurrent(pctx: [*c]CUcontext) CUresult;
pub extern fn cuCtxGetDevice(device: [*c]CUdevice) CUresult;
pub extern fn cuCtxGetDevice_v2(device: [*c]CUdevice, ctx: CUcontext) CUresult;
pub extern fn cuCtxGetFlags(flags: [*c]c_uint) CUresult;
pub extern fn cuCtxSetFlags(flags: c_uint) CUresult;
pub extern fn cuCtxGetId(ctx: CUcontext, ctxId: [*c]c_ulonglong) CUresult;
pub extern fn cuCtxSynchronize() CUresult;
pub extern fn cuCtxSynchronize_v2(ctx: CUcontext) CUresult;
pub extern fn cuCtxSetLimit(limit: CUlimit, value: usize) CUresult;
pub extern fn cuCtxGetLimit(pvalue: [*c]usize, limit: CUlimit) CUresult;
pub extern fn cuCtxGetCacheConfig(pconfig: [*c]CUfunc_cache) CUresult;
pub extern fn cuCtxSetCacheConfig(config: CUfunc_cache) CUresult;
pub extern fn cuCtxGetApiVersion(ctx: CUcontext, version: [*c]c_uint) CUresult;
pub extern fn cuCtxGetStreamPriorityRange(leastPriority: [*c]c_int, greatestPriority: [*c]c_int) CUresult;
pub extern fn cuCtxResetPersistingL2Cache() CUresult;
pub extern fn cuCtxGetExecAffinity(pExecAffinity: [*c]CUexecAffinityParam, @"type": CUexecAffinityType) CUresult;
pub extern fn cuCtxRecordEvent(hCtx: CUcontext, hEvent: CUevent) CUresult;
pub extern fn cuCtxWaitEvent(hCtx: CUcontext, hEvent: CUevent) CUresult;
pub extern fn cuCtxAttach(pctx: [*c]CUcontext, flags: c_uint) CUresult;
pub extern fn cuCtxDetach(ctx: CUcontext) CUresult;
pub extern fn cuCtxGetSharedMemConfig(pConfig: [*c]CUsharedconfig) CUresult;
pub extern fn cuCtxSetSharedMemConfig(config: CUsharedconfig) CUresult;
pub extern fn cuModuleLoad(module: [*c]CUmodule, fname: [*c]const u8) CUresult;
pub extern fn cuModuleLoadData(module: [*c]CUmodule, image: ?*const anyopaque) CUresult;
pub extern fn cuModuleLoadDataEx(module: [*c]CUmodule, image: ?*const anyopaque, numOptions: c_uint, options: [*c]CUjit_option, optionValues: [*c]?*anyopaque) CUresult;
pub extern fn cuModuleLoadFatBinary(module: [*c]CUmodule, fatCubin: ?*const anyopaque) CUresult;
pub extern fn cuModuleUnload(hmod: CUmodule) CUresult;
pub const CU_MODULE_EAGER_LOADING: c_int = 1;
pub const CU_MODULE_LAZY_LOADING: c_int = 2;
pub const enum_CUmoduleLoadingMode_enum = c_uint;
pub const CUmoduleLoadingMode = enum_CUmoduleLoadingMode_enum;
pub extern fn cuModuleGetLoadingMode(mode: [*c]CUmoduleLoadingMode) CUresult;
pub extern fn cuModuleGetFunction(hfunc: [*c]CUfunction, hmod: CUmodule, name: [*c]const u8) CUresult;
pub extern fn cuModuleGetFunctionCount(count: [*c]c_uint, mod: CUmodule) CUresult;
pub extern fn cuModuleEnumerateFunctions(functions: [*c]CUfunction, numFunctions: c_uint, mod: CUmodule) CUresult;
pub extern fn cuModuleGetGlobal_v2(dptr: [*c]CUdeviceptr, bytes: [*c]usize, hmod: CUmodule, name: [*c]const u8) CUresult;
pub extern fn cuLinkCreate_v2(numOptions: c_uint, options: [*c]CUjit_option, optionValues: [*c]?*anyopaque, stateOut: [*c]CUlinkState) CUresult;
pub extern fn cuLinkAddData_v2(state: CUlinkState, @"type": CUjitInputType, data: ?*anyopaque, size: usize, name: [*c]const u8, numOptions: c_uint, options: [*c]CUjit_option, optionValues: [*c]?*anyopaque) CUresult;
pub extern fn cuLinkAddFile_v2(state: CUlinkState, @"type": CUjitInputType, path: [*c]const u8, numOptions: c_uint, options: [*c]CUjit_option, optionValues: [*c]?*anyopaque) CUresult;
pub extern fn cuLinkComplete(state: CUlinkState, cubinOut: [*c]?*anyopaque, sizeOut: [*c]usize) CUresult;
pub extern fn cuLinkDestroy(state: CUlinkState) CUresult;
pub extern fn cuModuleGetTexRef(pTexRef: [*c]CUtexref, hmod: CUmodule, name: [*c]const u8) CUresult;
pub extern fn cuModuleGetSurfRef(pSurfRef: [*c]CUsurfref, hmod: CUmodule, name: [*c]const u8) CUresult;
pub extern fn cuLibraryLoadData(library: [*c]CUlibrary, code: ?*const anyopaque, jitOptions: [*c]CUjit_option, jitOptionsValues: [*c]?*anyopaque, numJitOptions: c_uint, libraryOptions: [*c]CUlibraryOption, libraryOptionValues: [*c]?*anyopaque, numLibraryOptions: c_uint) CUresult;
pub extern fn cuLibraryLoadFromFile(library: [*c]CUlibrary, fileName: [*c]const u8, jitOptions: [*c]CUjit_option, jitOptionsValues: [*c]?*anyopaque, numJitOptions: c_uint, libraryOptions: [*c]CUlibraryOption, libraryOptionValues: [*c]?*anyopaque, numLibraryOptions: c_uint) CUresult;
pub extern fn cuLibraryUnload(library: CUlibrary) CUresult;
pub extern fn cuLibraryGetKernel(pKernel: [*c]CUkernel, library: CUlibrary, name: [*c]const u8) CUresult;
pub extern fn cuLibraryGetKernelCount(count: [*c]c_uint, lib: CUlibrary) CUresult;
pub extern fn cuLibraryEnumerateKernels(kernels: [*c]CUkernel, numKernels: c_uint, lib: CUlibrary) CUresult;
pub extern fn cuLibraryGetModule(pMod: [*c]CUmodule, library: CUlibrary) CUresult;
pub extern fn cuKernelGetFunction(pFunc: [*c]CUfunction, kernel: CUkernel) CUresult;
pub extern fn cuKernelGetLibrary(pLib: [*c]CUlibrary, kernel: CUkernel) CUresult;
pub extern fn cuLibraryGetGlobal(dptr: [*c]CUdeviceptr, bytes: [*c]usize, library: CUlibrary, name: [*c]const u8) CUresult;
pub extern fn cuLibraryGetManaged(dptr: [*c]CUdeviceptr, bytes: [*c]usize, library: CUlibrary, name: [*c]const u8) CUresult;
pub extern fn cuLibraryGetUnifiedFunction(fptr: [*c]?*anyopaque, library: CUlibrary, symbol: [*c]const u8) CUresult;
pub extern fn cuKernelGetAttribute(pi: [*c]c_int, attrib: CUfunction_attribute, kernel: CUkernel, dev: CUdevice) CUresult;
pub extern fn cuKernelSetAttribute(attrib: CUfunction_attribute, val: c_int, kernel: CUkernel, dev: CUdevice) CUresult;
pub extern fn cuKernelSetCacheConfig(kernel: CUkernel, config: CUfunc_cache, dev: CUdevice) CUresult;
pub extern fn cuKernelGetName(name: [*c][*c]const u8, hfunc: CUkernel) CUresult;
pub extern fn cuKernelGetParamInfo(kernel: CUkernel, paramIndex: usize, paramOffset: [*c]usize, paramSize: [*c]usize) CUresult;
pub extern fn cuKernelGetParamCount(kernel: CUkernel, paramCount: [*c]usize) CUresult;
pub extern fn cuMemGetInfo_v2(free: [*c]usize, total: [*c]usize) CUresult;
pub extern fn cuMemAlloc_v2(dptr: [*c]CUdeviceptr, bytesize: usize) CUresult;
pub extern fn cuMemAllocPitch_v2(dptr: [*c]CUdeviceptr, pPitch: [*c]usize, WidthInBytes: usize, Height: usize, ElementSizeBytes: c_uint) CUresult;
pub extern fn cuMemFree_v2(dptr: CUdeviceptr) CUresult;
pub extern fn cuMemGetAddressRange_v2(pbase: [*c]CUdeviceptr, psize: [*c]usize, dptr: CUdeviceptr) CUresult;
pub extern fn cuMemAllocHost_v2(pp: [*c]?*anyopaque, bytesize: usize) CUresult;
pub extern fn cuMemFreeHost(p: ?*anyopaque) CUresult;
pub extern fn cuMemHostAlloc(pp: [*c]?*anyopaque, bytesize: usize, Flags: c_uint) CUresult;
pub extern fn cuMemHostGetDevicePointer_v2(pdptr: [*c]CUdeviceptr, p: ?*anyopaque, Flags: c_uint) CUresult;
pub extern fn cuMemHostGetFlags(pFlags: [*c]c_uint, p: ?*anyopaque) CUresult;
pub extern fn cuMemAllocManaged(dptr: [*c]CUdeviceptr, bytesize: usize, flags: c_uint) CUresult;
pub extern fn cuDeviceRegisterAsyncNotification(device: CUdevice, callbackFunc: CUasyncCallback, userData: ?*anyopaque, callback: [*c]CUasyncCallbackHandle) CUresult;
pub extern fn cuDeviceUnregisterAsyncNotification(device: CUdevice, callback: CUasyncCallbackHandle) CUresult;
pub extern fn cuDeviceGetByPCIBusId(dev: [*c]CUdevice, pciBusId: [*c]const u8) CUresult;
pub extern fn cuDeviceGetPCIBusId(pciBusId: [*c]u8, len: c_int, dev: CUdevice) CUresult;
pub extern fn cuIpcGetEventHandle(pHandle: [*c]CUipcEventHandle, event: CUevent) CUresult;
pub extern fn cuIpcOpenEventHandle(phEvent: [*c]CUevent, handle: CUipcEventHandle) CUresult;
pub extern fn cuIpcGetMemHandle(pHandle: [*c]CUipcMemHandle, dptr: CUdeviceptr) CUresult;
pub extern fn cuIpcOpenMemHandle_v2(pdptr: [*c]CUdeviceptr, handle: CUipcMemHandle, Flags: c_uint) CUresult;
pub extern fn cuIpcCloseMemHandle(dptr: CUdeviceptr) CUresult;
pub extern fn cuMemHostRegister_v2(p: ?*anyopaque, bytesize: usize, Flags: c_uint) CUresult;
pub extern fn cuMemHostUnregister(p: ?*anyopaque) CUresult;
pub extern fn cuMemcpy(dst: CUdeviceptr, src: CUdeviceptr, ByteCount: usize) CUresult;
pub extern fn cuMemcpyPeer(dstDevice: CUdeviceptr, dstContext: CUcontext, srcDevice: CUdeviceptr, srcContext: CUcontext, ByteCount: usize) CUresult;
pub extern fn cuMemcpyHtoD_v2(dstDevice: CUdeviceptr, srcHost: ?*const anyopaque, ByteCount: usize) CUresult;
pub extern fn cuMemcpyDtoH_v2(dstHost: ?*anyopaque, srcDevice: CUdeviceptr, ByteCount: usize) CUresult;
pub extern fn cuMemcpyDtoD_v2(dstDevice: CUdeviceptr, srcDevice: CUdeviceptr, ByteCount: usize) CUresult;
pub extern fn cuMemcpyDtoA_v2(dstArray: CUarray, dstOffset: usize, srcDevice: CUdeviceptr, ByteCount: usize) CUresult;
pub extern fn cuMemcpyAtoD_v2(dstDevice: CUdeviceptr, srcArray: CUarray, srcOffset: usize, ByteCount: usize) CUresult;
pub extern fn cuMemcpyHtoA_v2(dstArray: CUarray, dstOffset: usize, srcHost: ?*const anyopaque, ByteCount: usize) CUresult;
pub extern fn cuMemcpyAtoH_v2(dstHost: ?*anyopaque, srcArray: CUarray, srcOffset: usize, ByteCount: usize) CUresult;
pub extern fn cuMemcpyAtoA_v2(dstArray: CUarray, dstOffset: usize, srcArray: CUarray, srcOffset: usize, ByteCount: usize) CUresult;
pub extern fn cuMemcpy2D_v2(pCopy: [*c]const CUDA_MEMCPY2D) CUresult;
pub extern fn cuMemcpy2DUnaligned_v2(pCopy: [*c]const CUDA_MEMCPY2D) CUresult;
pub extern fn cuMemcpy3D_v2(pCopy: [*c]const CUDA_MEMCPY3D) CUresult;
pub extern fn cuMemcpy3DPeer(pCopy: [*c]const CUDA_MEMCPY3D_PEER) CUresult;
pub extern fn cuMemcpyAsync(dst: CUdeviceptr, src: CUdeviceptr, ByteCount: usize, hStream: CUstream) CUresult;
pub extern fn cuMemcpyPeerAsync(dstDevice: CUdeviceptr, dstContext: CUcontext, srcDevice: CUdeviceptr, srcContext: CUcontext, ByteCount: usize, hStream: CUstream) CUresult;
pub extern fn cuMemcpyHtoDAsync_v2(dstDevice: CUdeviceptr, srcHost: ?*const anyopaque, ByteCount: usize, hStream: CUstream) CUresult;
pub extern fn cuMemcpyDtoHAsync_v2(dstHost: ?*anyopaque, srcDevice: CUdeviceptr, ByteCount: usize, hStream: CUstream) CUresult;
pub extern fn cuMemcpyDtoDAsync_v2(dstDevice: CUdeviceptr, srcDevice: CUdeviceptr, ByteCount: usize, hStream: CUstream) CUresult;
pub extern fn cuMemcpyHtoAAsync_v2(dstArray: CUarray, dstOffset: usize, srcHost: ?*const anyopaque, ByteCount: usize, hStream: CUstream) CUresult;
pub extern fn cuMemcpyAtoHAsync_v2(dstHost: ?*anyopaque, srcArray: CUarray, srcOffset: usize, ByteCount: usize, hStream: CUstream) CUresult;
pub extern fn cuMemcpy2DAsync_v2(pCopy: [*c]const CUDA_MEMCPY2D, hStream: CUstream) CUresult;
pub extern fn cuMemcpy3DAsync_v2(pCopy: [*c]const CUDA_MEMCPY3D, hStream: CUstream) CUresult;
pub extern fn cuMemcpy3DPeerAsync(pCopy: [*c]const CUDA_MEMCPY3D_PEER, hStream: CUstream) CUresult;
pub extern fn cuMemcpyBatchAsync_v2(dsts: [*c]CUdeviceptr, srcs: [*c]CUdeviceptr, sizes: [*c]usize, count: usize, attrs: [*c]CUmemcpyAttributes, attrsIdxs: [*c]usize, numAttrs: usize, hStream: CUstream) CUresult;
pub extern fn cuMemcpy3DBatchAsync_v2(numOps: usize, opList: [*c]CUDA_MEMCPY3D_BATCH_OP, flags: c_ulonglong, hStream: CUstream) CUresult;
pub extern fn cuMemcpyWithAttributesAsync(dst: CUdeviceptr, src: CUdeviceptr, size: usize, attr: [*c]CUmemcpyAttributes, hStream: CUstream) CUresult;
pub extern fn cuMemcpy3DWithAttributesAsync(op: [*c]CUDA_MEMCPY3D_BATCH_OP, flags: c_ulonglong, hStream: CUstream) CUresult;
pub extern fn cuMemsetD8_v2(dstDevice: CUdeviceptr, uc: u8, N: usize) CUresult;
pub extern fn cuMemsetD16_v2(dstDevice: CUdeviceptr, us: c_ushort, N: usize) CUresult;
pub extern fn cuMemsetD32_v2(dstDevice: CUdeviceptr, ui: c_uint, N: usize) CUresult;
pub extern fn cuMemsetD2D8_v2(dstDevice: CUdeviceptr, dstPitch: usize, uc: u8, Width: usize, Height: usize) CUresult;
pub extern fn cuMemsetD2D16_v2(dstDevice: CUdeviceptr, dstPitch: usize, us: c_ushort, Width: usize, Height: usize) CUresult;
pub extern fn cuMemsetD2D32_v2(dstDevice: CUdeviceptr, dstPitch: usize, ui: c_uint, Width: usize, Height: usize) CUresult;
pub extern fn cuMemsetD8Async(dstDevice: CUdeviceptr, uc: u8, N: usize, hStream: CUstream) CUresult;
pub extern fn cuMemsetD16Async(dstDevice: CUdeviceptr, us: c_ushort, N: usize, hStream: CUstream) CUresult;
pub extern fn cuMemsetD32Async(dstDevice: CUdeviceptr, ui: c_uint, N: usize, hStream: CUstream) CUresult;
pub extern fn cuMemsetD2D8Async(dstDevice: CUdeviceptr, dstPitch: usize, uc: u8, Width: usize, Height: usize, hStream: CUstream) CUresult;
pub extern fn cuMemsetD2D16Async(dstDevice: CUdeviceptr, dstPitch: usize, us: c_ushort, Width: usize, Height: usize, hStream: CUstream) CUresult;
pub extern fn cuMemsetD2D32Async(dstDevice: CUdeviceptr, dstPitch: usize, ui: c_uint, Width: usize, Height: usize, hStream: CUstream) CUresult;
pub extern fn cuArrayCreate_v2(pHandle: [*c]CUarray, pAllocateArray: [*c]const CUDA_ARRAY_DESCRIPTOR) CUresult;
pub extern fn cuArrayGetDescriptor_v2(pArrayDescriptor: [*c]CUDA_ARRAY_DESCRIPTOR, hArray: CUarray) CUresult;
pub extern fn cuArrayGetSparseProperties(sparseProperties: [*c]CUDA_ARRAY_SPARSE_PROPERTIES, array: CUarray) CUresult;
pub extern fn cuMipmappedArrayGetSparseProperties(sparseProperties: [*c]CUDA_ARRAY_SPARSE_PROPERTIES, mipmap: CUmipmappedArray) CUresult;
pub extern fn cuArrayGetMemoryRequirements(memoryRequirements: [*c]CUDA_ARRAY_MEMORY_REQUIREMENTS, array: CUarray, device: CUdevice) CUresult;
pub extern fn cuMipmappedArrayGetMemoryRequirements(memoryRequirements: [*c]CUDA_ARRAY_MEMORY_REQUIREMENTS, mipmap: CUmipmappedArray, device: CUdevice) CUresult;
pub extern fn cuArrayGetPlane(pPlaneArray: [*c]CUarray, hArray: CUarray, planeIdx: c_uint) CUresult;
pub extern fn cuArrayDestroy(hArray: CUarray) CUresult;
pub extern fn cuArray3DCreate_v2(pHandle: [*c]CUarray, pAllocateArray: [*c]const CUDA_ARRAY3D_DESCRIPTOR) CUresult;
pub extern fn cuArray3DGetDescriptor_v2(pArrayDescriptor: [*c]CUDA_ARRAY3D_DESCRIPTOR, hArray: CUarray) CUresult;
pub extern fn cuMipmappedArrayCreate(pHandle: [*c]CUmipmappedArray, pMipmappedArrayDesc: [*c]const CUDA_ARRAY3D_DESCRIPTOR, numMipmapLevels: c_uint) CUresult;
pub extern fn cuMipmappedArrayGetLevel(pLevelArray: [*c]CUarray, hMipmappedArray: CUmipmappedArray, level: c_uint) CUresult;
pub extern fn cuMipmappedArrayDestroy(hMipmappedArray: CUmipmappedArray) CUresult;
pub extern fn cuMemGetHandleForAddressRange(handle: ?*anyopaque, dptr: CUdeviceptr, size: usize, handleType: CUmemRangeHandleType, flags: c_ulonglong) CUresult;
pub const CU_MEM_DECOMPRESS_UNSUPPORTED: c_int = 0;
pub const CU_MEM_DECOMPRESS_ALGORITHM_DEFLATE: c_int = 1;
pub const CU_MEM_DECOMPRESS_ALGORITHM_SNAPPY: c_int = 2;
pub const CU_MEM_DECOMPRESS_ALGORITHM_LZ4: c_int = 4;
pub const enum_CUmemDecompressAlgorithm_enum = c_uint;
pub const CUmemDecompressAlgorithm = enum_CUmemDecompressAlgorithm_enum;
pub const struct_CUmemDecompressParams_st = extern struct {
    srcNumBytes: usize = 0,
    dstNumBytes: usize = 0,
    dstActBytes: [*c]cuuint32_t = null,
    src: ?*const anyopaque = null,
    dst: ?*anyopaque = null,
    algo: CUmemDecompressAlgorithm = @import("std").mem.zeroes(CUmemDecompressAlgorithm),
    padding: [20]u8 = @import("std").mem.zeroes([20]u8),
    pub const cuMemBatchDecompressAsync = __root.cuMemBatchDecompressAsync;
};
pub const CUmemDecompressParams = struct_CUmemDecompressParams_st;
pub extern fn cuMemBatchDecompressAsync(paramsArray: [*c]CUmemDecompressParams, count: usize, flags: c_uint, errorIndex: [*c]usize, stream: CUstream) CUresult;
pub extern fn cuMemAddressReserve(ptr: [*c]CUdeviceptr, size: usize, alignment: usize, addr: CUdeviceptr, flags: c_ulonglong) CUresult;
pub extern fn cuMemAddressFree(ptr: CUdeviceptr, size: usize) CUresult;
pub extern fn cuMemCreate(handle: [*c]CUmemGenericAllocationHandle, size: usize, prop: [*c]const CUmemAllocationProp, flags: c_ulonglong) CUresult;
pub extern fn cuMemRelease(handle: CUmemGenericAllocationHandle) CUresult;
pub extern fn cuMemMap(ptr: CUdeviceptr, size: usize, offset: usize, handle: CUmemGenericAllocationHandle, flags: c_ulonglong) CUresult;
pub extern fn cuMemMapArrayAsync(mapInfoList: [*c]CUarrayMapInfo, count: c_uint, hStream: CUstream) CUresult;
pub extern fn cuMemUnmap(ptr: CUdeviceptr, size: usize) CUresult;
pub extern fn cuMemSetAccess(ptr: CUdeviceptr, size: usize, desc: [*c]const CUmemAccessDesc, count: usize) CUresult;
pub extern fn cuMemGetAccess(flags: [*c]c_ulonglong, location: [*c]const CUmemLocation, ptr: CUdeviceptr) CUresult;
pub extern fn cuMemExportToShareableHandle(shareableHandle: ?*anyopaque, handle: CUmemGenericAllocationHandle, handleType: CUmemAllocationHandleType, flags: c_ulonglong) CUresult;
pub extern fn cuMemImportFromShareableHandle(handle: [*c]CUmemGenericAllocationHandle, osHandle: ?*anyopaque, shHandleType: CUmemAllocationHandleType) CUresult;
pub extern fn cuMemGetAllocationGranularity(granularity: [*c]usize, prop: [*c]const CUmemAllocationProp, option: CUmemAllocationGranularity_flags) CUresult;
pub extern fn cuMemGetAllocationPropertiesFromHandle(prop: [*c]CUmemAllocationProp, handle: CUmemGenericAllocationHandle) CUresult;
pub extern fn cuMemRetainAllocationHandle(handle: [*c]CUmemGenericAllocationHandle, addr: ?*anyopaque) CUresult;
pub extern fn cuMemFreeAsync(dptr: CUdeviceptr, hStream: CUstream) CUresult;
pub extern fn cuMemAllocAsync(dptr: [*c]CUdeviceptr, bytesize: usize, hStream: CUstream) CUresult;
pub extern fn cuMemPoolTrimTo(pool: CUmemoryPool, minBytesToKeep: usize) CUresult;
pub extern fn cuMemPoolSetAttribute(pool: CUmemoryPool, attr: CUmemPool_attribute, value: ?*anyopaque) CUresult;
pub extern fn cuMemPoolGetAttribute(pool: CUmemoryPool, attr: CUmemPool_attribute, value: ?*anyopaque) CUresult;
pub extern fn cuMemPoolSetAccess(pool: CUmemoryPool, map: [*c]const CUmemAccessDesc, count: usize) CUresult;
pub extern fn cuMemPoolGetAccess(flags: [*c]CUmemAccess_flags, memPool: CUmemoryPool, location: [*c]CUmemLocation) CUresult;
pub extern fn cuMemPoolCreate(pool: [*c]CUmemoryPool, poolProps: [*c]const CUmemPoolProps) CUresult;
pub extern fn cuMemPoolDestroy(pool: CUmemoryPool) CUresult;
pub extern fn cuMemGetDefaultMemPool(pool_out: [*c]CUmemoryPool, location: [*c]CUmemLocation, @"type": CUmemAllocationType) CUresult;
pub extern fn cuMemGetMemPool(pool: [*c]CUmemoryPool, location: [*c]CUmemLocation, @"type": CUmemAllocationType) CUresult;
pub extern fn cuMemSetMemPool(location: [*c]CUmemLocation, @"type": CUmemAllocationType, pool: CUmemoryPool) CUresult;
pub extern fn cuMemAllocFromPoolAsync(dptr: [*c]CUdeviceptr, bytesize: usize, pool: CUmemoryPool, hStream: CUstream) CUresult;
pub extern fn cuMemPoolExportToShareableHandle(handle_out: ?*anyopaque, pool: CUmemoryPool, handleType: CUmemAllocationHandleType, flags: c_ulonglong) CUresult;
pub extern fn cuMemPoolImportFromShareableHandle(pool_out: [*c]CUmemoryPool, handle: ?*anyopaque, handleType: CUmemAllocationHandleType, flags: c_ulonglong) CUresult;
pub extern fn cuMemPoolExportPointer(shareData_out: [*c]CUmemPoolPtrExportData, ptr: CUdeviceptr) CUresult;
pub extern fn cuMemPoolImportPointer(ptr_out: [*c]CUdeviceptr, pool: CUmemoryPool, shareData: [*c]CUmemPoolPtrExportData) CUresult;
pub extern fn cuMulticastCreate(mcHandle: [*c]CUmemGenericAllocationHandle, prop: [*c]const CUmulticastObjectProp) CUresult;
pub extern fn cuMulticastAddDevice(mcHandle: CUmemGenericAllocationHandle, dev: CUdevice) CUresult;
pub extern fn cuMulticastBindMem(mcHandle: CUmemGenericAllocationHandle, mcOffset: usize, memHandle: CUmemGenericAllocationHandle, memOffset: usize, size: usize, flags: c_ulonglong) CUresult;
pub extern fn cuMulticastBindMem_v2(mcHandle: CUmemGenericAllocationHandle, dev: CUdevice, mcOffset: usize, memHandle: CUmemGenericAllocationHandle, memOffset: usize, size: usize, flags: c_ulonglong) CUresult;
pub extern fn cuMulticastBindAddr(mcHandle: CUmemGenericAllocationHandle, mcOffset: usize, memptr: CUdeviceptr, size: usize, flags: c_ulonglong) CUresult;
pub extern fn cuMulticastBindAddr_v2(mcHandle: CUmemGenericAllocationHandle, dev: CUdevice, mcOffset: usize, memptr: CUdeviceptr, size: usize, flags: c_ulonglong) CUresult;
pub extern fn cuMulticastUnbind(mcHandle: CUmemGenericAllocationHandle, dev: CUdevice, mcOffset: usize, size: usize) CUresult;
pub extern fn cuMulticastGetGranularity(granularity: [*c]usize, prop: [*c]const CUmulticastObjectProp, option: CUmulticastGranularity_flags) CUresult;
pub const CU_CLIQUE_TYPE_UNICAST_POINTER: c_int = 0;
pub const CU_CLIQUE_TYPE_MULTICAST_POINTER: c_int = 1;
pub const CU_CLIQUE_TYPE_UNICAST_LOGICAL_ENDPOINT: c_int = 2;
pub const CU_CLIQUE_TYPE_MULTICAST_LOGICAL_ENDPOINT: c_int = 3;
pub const enum_CUcliqueType_enum = c_uint;
pub const CUcliqueType = enum_CUcliqueType_enum;
pub const struct_CUcliqueInfo_st = extern struct {
    type: CUcliqueType = @import("std").mem.zeroes(CUcliqueType),
    id: c_uint = 0,
    pub const cuDeviceGetCliqueInfo = __root.cuDeviceGetCliqueInfo;
};
pub const CUcliqueInfo = struct_CUcliqueInfo_st;
pub extern fn cuDeviceGetFabricClusterUuid(uuid: [*c]CUuuid, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetCliqueCount(count: [*c]usize, dev: CUdevice) CUresult;
pub extern fn cuDeviceGetCliqueInfo(cliqueInfo: [*c]CUcliqueInfo, count: [*c]usize, dev: CUdevice) CUresult;
pub const CUlogicalEndpointId = cuuint32_t;
pub const CU_LOGICAL_ENDPOINT_IPC_HANDLE_TYPE_NONE: c_int = 0;
pub const CU_LOGICAL_ENDPOINT_IPC_HANDLE_TYPE_FABRIC: c_int = 1;
pub const enum_CUlogicalEndpointIpcHandleType_enum = c_uint;
pub const CUlogicalEndpointIpcHandleType = enum_CUlogicalEndpointIpcHandleType_enum;
pub const struct_CUlogicalEndpointFabricHandle_st = extern struct {
    data: [64]u8 = @import("std").mem.zeroes([64]u8),
};
pub const CUlogicalEndpointFabricHandle = struct_CUlogicalEndpointFabricHandle_st;
pub const CU_LOGICAL_ENDPOINT_TYPE_INVALID: c_int = 0;
pub const CU_LOGICAL_ENDPOINT_TYPE_UNICAST: c_int = 1;
pub const CU_LOGICAL_ENDPOINT_TYPE_MULTICAST: c_int = 2;
pub const enum_CUlogicalEndpointType_enum = c_uint;
pub const CUlogicalEndpointType = enum_CUlogicalEndpointType_enum;
pub const CU_LOGICAL_ENDPOINT_FLAG_NONE: c_int = 0;
pub const CU_LOGICAL_ENDPOINT_FLAG_COUNTED_OPS: c_int = 1;
pub const enum_CUlogicalEndpointFlag_enum = c_uint;
pub const CUlogicalEndpointFlag = enum_CUlogicalEndpointFlag_enum;
const struct_unnamed_53 = extern struct {
    device: CUdevice = 0,
};
const struct_unnamed_54 = extern struct {
    numDevices: c_uint = 0,
};
const union_unnamed_52 = extern union {
    unicast: struct_unnamed_53,
    multicast: struct_unnamed_54,
};
pub const struct_CUlogicalEndpointProp_struct = extern struct {
    type: CUlogicalEndpointType = @import("std").mem.zeroes(CUlogicalEndpointType),
    unnamed_0: union_unnamed_52 = @import("std").mem.zeroes(union_unnamed_52),
    size: c_ulonglong = 0,
    ipcHandleTypes: c_uint = 0,
    flags: c_uint = 0,
};
pub const CUlogicalEndpointProp = struct_CUlogicalEndpointProp_struct;
pub extern fn cuLogicalEndpointIdReserve(baseLeId: [*c]CUlogicalEndpointId, count: cuuint32_t) CUresult;
pub extern fn cuLogicalEndpointIdRelease(baseLeId: CUlogicalEndpointId, count: cuuint32_t) CUresult;
pub extern fn cuLogicalEndpointCreate(leId: CUlogicalEndpointId, prop: [*c]const CUlogicalEndpointProp) CUresult;
pub extern fn cuLogicalEndpointAddDevice(leId: CUlogicalEndpointId, dev: CUdevice) CUresult;
pub extern fn cuLogicalEndpointDestroy(leId: CUlogicalEndpointId) CUresult;
pub extern fn cuLogicalEndpointBindAddr(leId: CUlogicalEndpointId, dev: CUdevice, offset: cuuint64_t, ptr: ?*anyopaque, size: cuuint64_t, flags: c_ulonglong) CUresult;
pub extern fn cuLogicalEndpointBindMem(leId: CUlogicalEndpointId, dev: CUdevice, offset: cuuint64_t, memHandle: CUmemGenericAllocationHandle, memOffset: cuuint64_t, size: cuuint64_t, flags: c_ulonglong) CUresult;
pub extern fn cuLogicalEndpointUnbind(leId: CUlogicalEndpointId, dev: CUdevice, offset: cuuint64_t, size: cuuint64_t) CUresult;
pub extern fn cuLogicalEndpointExport(handle: ?*anyopaque, leId: CUlogicalEndpointId, handleType: CUlogicalEndpointIpcHandleType) CUresult;
pub extern fn cuLogicalEndpointImport(leId: CUlogicalEndpointId, handle: ?*const anyopaque, handleType: CUlogicalEndpointIpcHandleType) CUresult;
pub extern fn cuLogicalEndpointGetLimits(bindAlignment: [*c]cuuint64_t, maxSize: [*c]cuuint64_t, prop: [*c]const CUlogicalEndpointProp) CUresult;
pub extern fn cuLogicalEndpointQuery(leId: CUlogicalEndpointId, count: cuuint32_t, queryStatus: [*c]c_int) CUresult;
pub extern fn cuPointerGetAttribute(data: ?*anyopaque, attribute: CUpointer_attribute, ptr: CUdeviceptr) CUresult;
pub extern fn cuMemPrefetchAsync_v2(devPtr: CUdeviceptr, count: usize, location: CUmemLocation, flags: c_uint, hStream: CUstream) CUresult;
pub extern fn cuMemAdvise_v2(devPtr: CUdeviceptr, count: usize, advice: CUmem_advise, location: CUmemLocation) CUresult;
pub extern fn cuMemPrefetchBatchAsync(dptrs: [*c]CUdeviceptr, sizes: [*c]usize, count: usize, prefetchLocs: [*c]CUmemLocation, prefetchLocIdxs: [*c]usize, numPrefetchLocs: usize, flags: c_ulonglong, hStream: CUstream) CUresult;
pub extern fn cuMemDiscardBatchAsync(dptrs: [*c]CUdeviceptr, sizes: [*c]usize, count: usize, flags: c_ulonglong, hStream: CUstream) CUresult;
pub extern fn cuMemDiscardAndPrefetchBatchAsync(dptrs: [*c]CUdeviceptr, sizes: [*c]usize, count: usize, prefetchLocs: [*c]CUmemLocation, prefetchLocIdxs: [*c]usize, numPrefetchLocs: usize, flags: c_ulonglong, hStream: CUstream) CUresult;
pub extern fn cuMemGetLocationInfo(ptr: CUdeviceptr, size: usize, summaryGranularity: usize, samplingGranularity: usize, location_out: [*c]CUmemLocation) CUresult;
pub extern fn cuMemRangeGetAttribute(data: ?*anyopaque, dataSize: usize, attribute: CUmem_range_attribute, devPtr: CUdeviceptr, count: usize) CUresult;
pub extern fn cuMemRangeGetAttributes(data: [*c]?*anyopaque, dataSizes: [*c]usize, attributes: [*c]CUmem_range_attribute, numAttributes: usize, devPtr: CUdeviceptr, count: usize) CUresult;
pub extern fn cuPointerSetAttribute(value: ?*const anyopaque, attribute: CUpointer_attribute, ptr: CUdeviceptr) CUresult;
pub extern fn cuPointerGetAttributes(numAttributes: c_uint, attributes: [*c]CUpointer_attribute, data: [*c]?*anyopaque, ptr: CUdeviceptr) CUresult;
pub extern fn cuStreamCreate(phStream: [*c]CUstream, Flags: c_uint) CUresult;
pub extern fn cuStreamCreateWithPriority(phStream: [*c]CUstream, flags: c_uint, priority: c_int) CUresult;
pub extern fn cuStreamBeginCaptureToCig(hStream: CUstream, streamCigCaptureParams: [*c]CUstreamCigCaptureParams) CUresult;
pub extern fn cuStreamEndCaptureToCig(hStream: CUstream) CUresult;
pub extern fn cuStreamGetPriority(hStream: CUstream, priority: [*c]c_int) CUresult;
pub extern fn cuStreamGetDevice(hStream: CUstream, device: [*c]CUdevice) CUresult;
pub extern fn cuStreamGetFlags(hStream: CUstream, flags: [*c]c_uint) CUresult;
pub extern fn cuStreamGetId(hStream: CUstream, streamId: [*c]c_ulonglong) CUresult;
pub extern fn cuStreamGetCtx(hStream: CUstream, pctx: [*c]CUcontext) CUresult;
pub extern fn cuStreamGetCtx_v2(hStream: CUstream, pCtx: [*c]CUcontext, pGreenCtx: [*c]CUgreenCtx) CUresult;
pub extern fn cuStreamWaitEvent(hStream: CUstream, hEvent: CUevent, Flags: c_uint) CUresult;
pub extern fn cuStreamAddCallback(hStream: CUstream, callback: CUstreamCallback, userData: ?*anyopaque, flags: c_uint) CUresult;
pub extern fn cuStreamBeginCapture_v2(hStream: CUstream, mode: CUstreamCaptureMode) CUresult;
pub const CU_GRAPH_RECAPTURE_ELIGIBLE_FOR_UPDATE: c_int = 0;
pub const CU_GRAPH_RECAPTURE_INELIGIBLE_FOR_UPDATE: c_int = 1;
pub const CU_GRAPH_RECAPTURE_ERROR: c_int = 2;
pub const enum_CUgraphRecaptureStatus_enum = c_uint;
pub const CUgraphRecaptureStatus = enum_CUgraphRecaptureStatus_enum;
pub const CUgraphRecaptureCallback = ?*const fn (data: ?*anyopaque, node: CUgraphNode, originalParams: [*c]const CUgraphNodeParams, recaptureParams: [*c]const CUgraphNodeParams, status: CUgraphRecaptureStatus) callconv(.c) CUresult;
pub extern fn cuStreamBeginRecaptureToGraph(hStream: CUstream, mode: CUstreamCaptureMode, hGraph: CUgraph, callbackFunc: CUgraphRecaptureCallback, userData: ?*anyopaque) CUresult;
pub extern fn cuStreamBeginCaptureToGraph(hStream: CUstream, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, dependencyData: [*c]const CUgraphEdgeData, numDependencies: usize, mode: CUstreamCaptureMode) CUresult;
pub extern fn cuThreadExchangeStreamCaptureMode(mode: [*c]CUstreamCaptureMode) CUresult;
pub extern fn cuStreamEndCapture(hStream: CUstream, phGraph: [*c]CUgraph) CUresult;
pub extern fn cuStreamIsCapturing(hStream: CUstream, captureStatus: [*c]CUstreamCaptureStatus) CUresult;
pub extern fn cuStreamGetCaptureInfo_v3(hStream: CUstream, captureStatus_out: [*c]CUstreamCaptureStatus, id_out: [*c]cuuint64_t, graph_out: [*c]CUgraph, dependencies_out: [*c][*c]const CUgraphNode, edgeData_out: [*c][*c]const CUgraphEdgeData, numDependencies_out: [*c]usize) CUresult;
pub extern fn cuStreamUpdateCaptureDependencies_v2(hStream: CUstream, dependencies: [*c]CUgraphNode, dependencyData: [*c]const CUgraphEdgeData, numDependencies: usize, flags: c_uint) CUresult;
pub extern fn cuStreamAttachMemAsync(hStream: CUstream, dptr: CUdeviceptr, length: usize, flags: c_uint) CUresult;
pub extern fn cuStreamQuery(hStream: CUstream) CUresult;
pub extern fn cuStreamSynchronize(hStream: CUstream) CUresult;
pub extern fn cuStreamDestroy_v2(hStream: CUstream) CUresult;
pub extern fn cuStreamCopyAttributes(dst: CUstream, src: CUstream) CUresult;
pub extern fn cuStreamGetAttribute(hStream: CUstream, attr: CUstreamAttrID, value_out: [*c]CUstreamAttrValue) CUresult;
pub extern fn cuStreamSetAttribute(hStream: CUstream, attr: CUstreamAttrID, value: [*c]const CUstreamAttrValue) CUresult;
pub extern fn cuEventCreate(phEvent: [*c]CUevent, Flags: c_uint) CUresult;
pub extern fn cuEventRecord(hEvent: CUevent, hStream: CUstream) CUresult;
pub extern fn cuEventRecordWithFlags(hEvent: CUevent, hStream: CUstream, flags: c_uint) CUresult;
pub extern fn cuEventQuery(hEvent: CUevent) CUresult;
pub extern fn cuEventSynchronize(hEvent: CUevent) CUresult;
pub extern fn cuEventDestroy_v2(hEvent: CUevent) CUresult;
pub extern fn cuEventElapsedTime_v2(pMilliseconds: [*c]f32, hStart: CUevent, hEnd: CUevent) CUresult;
pub extern fn cuImportExternalMemory(extMem_out: [*c]CUexternalMemory, memHandleDesc: [*c]const CUDA_EXTERNAL_MEMORY_HANDLE_DESC) CUresult;
pub extern fn cuExternalMemoryGetMappedBuffer(devPtr: [*c]CUdeviceptr, extMem: CUexternalMemory, bufferDesc: [*c]const CUDA_EXTERNAL_MEMORY_BUFFER_DESC) CUresult;
pub extern fn cuExternalMemoryGetMappedMipmappedArray(mipmap: [*c]CUmipmappedArray, extMem: CUexternalMemory, mipmapDesc: [*c]const CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC) CUresult;
pub extern fn cuDestroyExternalMemory(extMem: CUexternalMemory) CUresult;
pub extern fn cuImportExternalSemaphore(extSem_out: [*c]CUexternalSemaphore, semHandleDesc: [*c]const CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC) CUresult;
pub extern fn cuSignalExternalSemaphoresAsync(extSemArray: [*c]const CUexternalSemaphore, paramsArray: [*c]const CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS, numExtSems: c_uint, stream: CUstream) CUresult;
pub extern fn cuWaitExternalSemaphoresAsync(extSemArray: [*c]const CUexternalSemaphore, paramsArray: [*c]const CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS, numExtSems: c_uint, stream: CUstream) CUresult;
pub extern fn cuDestroyExternalSemaphore(extSem: CUexternalSemaphore) CUresult;
pub extern fn cuStreamWaitValue32_v2(stream: CUstream, addr: CUdeviceptr, value: cuuint32_t, flags: c_uint) CUresult;
pub extern fn cuStreamWaitValue64_v2(stream: CUstream, addr: CUdeviceptr, value: cuuint64_t, flags: c_uint) CUresult;
pub extern fn cuStreamWriteValue32_v2(stream: CUstream, addr: CUdeviceptr, value: cuuint32_t, flags: c_uint) CUresult;
pub extern fn cuStreamWriteValue64_v2(stream: CUstream, addr: CUdeviceptr, value: cuuint64_t, flags: c_uint) CUresult;
pub extern fn cuStreamBatchMemOp_v2(stream: CUstream, count: c_uint, paramArray: [*c]CUstreamBatchMemOpParams, flags: c_uint) CUresult;
pub extern fn cuFuncGetAttribute(pi: [*c]c_int, attrib: CUfunction_attribute, hfunc: CUfunction) CUresult;
pub extern fn cuFuncSetAttribute(hfunc: CUfunction, attrib: CUfunction_attribute, value: c_int) CUresult;
pub extern fn cuFuncSetCacheConfig(hfunc: CUfunction, config: CUfunc_cache) CUresult;
pub extern fn cuFuncGetModule(hmod: [*c]CUmodule, hfunc: CUfunction) CUresult;
pub extern fn cuFuncGetName(name: [*c][*c]const u8, hfunc: CUfunction) CUresult;
pub extern fn cuFuncGetParamInfo(func: CUfunction, paramIndex: usize, paramOffset: [*c]usize, paramSize: [*c]usize) CUresult;
pub extern fn cuFuncGetParamCount(func: CUfunction, paramCount: [*c]usize) CUresult;
pub const CU_FUNCTION_LOADING_STATE_UNLOADED: c_int = 0;
pub const CU_FUNCTION_LOADING_STATE_LOADED: c_int = 1;
pub const CU_FUNCTION_LOADING_STATE_MAX: c_int = 2;
pub const enum_CUfunctionLoadingState_enum = c_uint;
pub const CUfunctionLoadingState = enum_CUfunctionLoadingState_enum;
pub extern fn cuFuncIsLoaded(state: [*c]CUfunctionLoadingState, function: CUfunction) CUresult;
pub extern fn cuFuncLoad(function: CUfunction) CUresult;
pub extern fn cuLaunchKernel(f: CUfunction, gridDimX: c_uint, gridDimY: c_uint, gridDimZ: c_uint, blockDimX: c_uint, blockDimY: c_uint, blockDimZ: c_uint, sharedMemBytes: c_uint, hStream: CUstream, kernelParams: [*c]?*anyopaque, extra: [*c]?*anyopaque) CUresult;
pub extern fn cuLaunchKernelEx(config: [*c]const CUlaunchConfig, f: CUfunction, kernelParams: [*c]?*anyopaque, extra: [*c]?*anyopaque) CUresult;
pub extern fn cuLaunchCooperativeKernel(f: CUfunction, gridDimX: c_uint, gridDimY: c_uint, gridDimZ: c_uint, blockDimX: c_uint, blockDimY: c_uint, blockDimZ: c_uint, sharedMemBytes: c_uint, hStream: CUstream, kernelParams: [*c]?*anyopaque) CUresult;
pub extern fn cuLaunchHostFunc(hStream: CUstream, @"fn": CUhostFn, userData: ?*anyopaque) CUresult;
pub extern fn cuLaunchHostFunc_v2(hStream: CUstream, @"fn": CUhostFn, userData: ?*anyopaque, syncMode: c_uint) CUresult;
pub extern fn cuFuncSetBlockShape(hfunc: CUfunction, x: c_int, y: c_int, z: c_int) CUresult;
pub extern fn cuFuncSetSharedSize(hfunc: CUfunction, bytes: c_uint) CUresult;
pub extern fn cuParamSetSize(hfunc: CUfunction, numbytes: c_uint) CUresult;
pub extern fn cuParamSeti(hfunc: CUfunction, offset: c_int, value: c_uint) CUresult;
pub extern fn cuParamSetf(hfunc: CUfunction, offset: c_int, value: f32) CUresult;
pub extern fn cuParamSetv(hfunc: CUfunction, offset: c_int, ptr: ?*anyopaque, numbytes: c_uint) CUresult;
pub extern fn cuLaunch(f: CUfunction) CUresult;
pub extern fn cuLaunchGrid(f: CUfunction, grid_width: c_int, grid_height: c_int) CUresult;
pub extern fn cuLaunchGridAsync(f: CUfunction, grid_width: c_int, grid_height: c_int, hStream: CUstream) CUresult;
pub extern fn cuLaunchCooperativeKernelMultiDevice(launchParamsList: [*c]CUDA_LAUNCH_PARAMS, numDevices: c_uint, flags: c_uint) CUresult;
pub extern fn cuParamSetTexRef(hfunc: CUfunction, texunit: c_int, hTexRef: CUtexref) CUresult;
pub extern fn cuFuncSetSharedMemConfig(hfunc: CUfunction, config: CUsharedconfig) CUresult;
pub extern fn cuGraphCreate(phGraph: [*c]CUgraph, flags: c_uint) CUresult;
pub extern fn cuGraphAddKernelNode_v2(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, nodeParams: [*c]const CUDA_KERNEL_NODE_PARAMS) CUresult;
pub extern fn cuGraphKernelNodeGetParams_v2(hNode: CUgraphNode, nodeParams: [*c]CUDA_KERNEL_NODE_PARAMS) CUresult;
pub extern fn cuGraphKernelNodeSetParams_v2(hNode: CUgraphNode, nodeParams: [*c]const CUDA_KERNEL_NODE_PARAMS) CUresult;
pub extern fn cuGraphAddMemcpyNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, copyParams: [*c]const CUDA_MEMCPY3D, ctx: CUcontext) CUresult;
pub extern fn cuGraphMemcpyNodeGetParams(hNode: CUgraphNode, nodeParams: [*c]CUDA_MEMCPY3D) CUresult;
pub extern fn cuGraphMemcpyNodeSetParams(hNode: CUgraphNode, nodeParams: [*c]const CUDA_MEMCPY3D) CUresult;
pub extern fn cuGraphAddMemsetNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, memsetParams: [*c]const CUDA_MEMSET_NODE_PARAMS, ctx: CUcontext) CUresult;
pub extern fn cuGraphMemsetNodeGetParams(hNode: CUgraphNode, nodeParams: [*c]CUDA_MEMSET_NODE_PARAMS) CUresult;
pub extern fn cuGraphMemsetNodeSetParams(hNode: CUgraphNode, nodeParams: [*c]const CUDA_MEMSET_NODE_PARAMS) CUresult;
pub extern fn cuGraphAddHostNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, nodeParams: [*c]const CUDA_HOST_NODE_PARAMS) CUresult;
pub extern fn cuGraphHostNodeGetParams(hNode: CUgraphNode, nodeParams: [*c]CUDA_HOST_NODE_PARAMS) CUresult;
pub extern fn cuGraphHostNodeSetParams(hNode: CUgraphNode, nodeParams: [*c]const CUDA_HOST_NODE_PARAMS) CUresult;
pub extern fn cuGraphAddChildGraphNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, childGraph: CUgraph) CUresult;
pub extern fn cuGraphChildGraphNodeGetGraph(hNode: CUgraphNode, phGraph: [*c]CUgraph) CUresult;
pub extern fn cuGraphAddEmptyNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize) CUresult;
pub extern fn cuGraphAddEventRecordNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, event: CUevent) CUresult;
pub extern fn cuGraphEventRecordNodeGetEvent(hNode: CUgraphNode, event_out: [*c]CUevent) CUresult;
pub extern fn cuGraphEventRecordNodeSetEvent(hNode: CUgraphNode, event: CUevent) CUresult;
pub extern fn cuGraphAddEventWaitNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, event: CUevent) CUresult;
pub extern fn cuGraphEventWaitNodeGetEvent(hNode: CUgraphNode, event_out: [*c]CUevent) CUresult;
pub extern fn cuGraphEventWaitNodeSetEvent(hNode: CUgraphNode, event: CUevent) CUresult;
pub extern fn cuGraphAddExternalSemaphoresSignalNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, nodeParams: [*c]const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS) CUresult;
pub extern fn cuGraphExternalSemaphoresSignalNodeGetParams(hNode: CUgraphNode, params_out: [*c]CUDA_EXT_SEM_SIGNAL_NODE_PARAMS) CUresult;
pub extern fn cuGraphExternalSemaphoresSignalNodeSetParams(hNode: CUgraphNode, nodeParams: [*c]const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS) CUresult;
pub extern fn cuGraphAddExternalSemaphoresWaitNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, nodeParams: [*c]const CUDA_EXT_SEM_WAIT_NODE_PARAMS) CUresult;
pub extern fn cuGraphExternalSemaphoresWaitNodeGetParams(hNode: CUgraphNode, params_out: [*c]CUDA_EXT_SEM_WAIT_NODE_PARAMS) CUresult;
pub extern fn cuGraphExternalSemaphoresWaitNodeSetParams(hNode: CUgraphNode, nodeParams: [*c]const CUDA_EXT_SEM_WAIT_NODE_PARAMS) CUresult;
pub extern fn cuGraphAddBatchMemOpNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, nodeParams: [*c]const CUDA_BATCH_MEM_OP_NODE_PARAMS) CUresult;
pub extern fn cuGraphBatchMemOpNodeGetParams(hNode: CUgraphNode, nodeParams_out: [*c]CUDA_BATCH_MEM_OP_NODE_PARAMS) CUresult;
pub extern fn cuGraphBatchMemOpNodeSetParams(hNode: CUgraphNode, nodeParams: [*c]const CUDA_BATCH_MEM_OP_NODE_PARAMS) CUresult;
pub extern fn cuGraphExecBatchMemOpNodeSetParams(hGraphExec: CUgraphExec, hNode: CUgraphNode, nodeParams: [*c]const CUDA_BATCH_MEM_OP_NODE_PARAMS) CUresult;
pub extern fn cuGraphAddMemAllocNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, nodeParams: [*c]CUDA_MEM_ALLOC_NODE_PARAMS) CUresult;
pub extern fn cuGraphMemAllocNodeGetParams(hNode: CUgraphNode, params_out: [*c]CUDA_MEM_ALLOC_NODE_PARAMS) CUresult;
pub extern fn cuGraphAddMemFreeNode(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, numDependencies: usize, dptr: CUdeviceptr) CUresult;
pub extern fn cuGraphMemFreeNodeGetParams(hNode: CUgraphNode, dptr_out: [*c]CUdeviceptr) CUresult;
pub extern fn cuDeviceGraphMemTrim(device: CUdevice) CUresult;
pub extern fn cuDeviceGetGraphMemAttribute(device: CUdevice, attr: CUgraphMem_attribute, value: ?*anyopaque) CUresult;
pub extern fn cuDeviceSetGraphMemAttribute(device: CUdevice, attr: CUgraphMem_attribute, value: ?*anyopaque) CUresult;
pub extern fn cuGraphClone(phGraphClone: [*c]CUgraph, originalGraph: CUgraph) CUresult;
pub extern fn cuGraphNodeFindInClone(phNode: [*c]CUgraphNode, hOriginalNode: CUgraphNode, hClonedGraph: CUgraph) CUresult;
pub extern fn cuGraphNodeGetType(hNode: CUgraphNode, @"type": [*c]CUgraphNodeType) CUresult;
pub extern fn cuGraphNodeGetContainingGraph(hNode: CUgraphNode, phGraph: [*c]CUgraph) CUresult;
pub extern fn cuGraphNodeGetLocalId(hNode: CUgraphNode, nodeId: [*c]c_uint) CUresult;
pub extern fn cuGraphNodeGetToolsId(hNode: CUgraphNode, toolsNodeId: [*c]c_ulonglong) CUresult;
pub extern fn cuGraphGetId(hGraph: CUgraph, graphId: [*c]c_uint) CUresult;
pub extern fn cuGraphExecGetId(hGraphExec: CUgraphExec, graphId: [*c]c_uint) CUresult;
pub extern fn cuGraphGetNodes(hGraph: CUgraph, nodes: [*c]CUgraphNode, numNodes: [*c]usize) CUresult;
pub extern fn cuGraphGetRootNodes(hGraph: CUgraph, rootNodes: [*c]CUgraphNode, numRootNodes: [*c]usize) CUresult;
pub extern fn cuGraphGetEdges_v2(hGraph: CUgraph, from: [*c]CUgraphNode, to: [*c]CUgraphNode, edgeData: [*c]CUgraphEdgeData, numEdges: [*c]usize) CUresult;
pub extern fn cuGraphNodeGetDependencies_v2(hNode: CUgraphNode, dependencies: [*c]CUgraphNode, edgeData: [*c]CUgraphEdgeData, numDependencies: [*c]usize) CUresult;
pub extern fn cuGraphNodeGetDependentNodes_v2(hNode: CUgraphNode, dependentNodes: [*c]CUgraphNode, edgeData: [*c]CUgraphEdgeData, numDependentNodes: [*c]usize) CUresult;
pub extern fn cuGraphAddDependencies_v2(hGraph: CUgraph, from: [*c]const CUgraphNode, to: [*c]const CUgraphNode, edgeData: [*c]const CUgraphEdgeData, numDependencies: usize) CUresult;
pub extern fn cuGraphRemoveDependencies_v2(hGraph: CUgraph, from: [*c]const CUgraphNode, to: [*c]const CUgraphNode, edgeData: [*c]const CUgraphEdgeData, numDependencies: usize) CUresult;
pub extern fn cuGraphDestroyNode(hNode: CUgraphNode) CUresult;
pub extern fn cuGraphInstantiateWithFlags(phGraphExec: [*c]CUgraphExec, hGraph: CUgraph, flags: c_ulonglong) CUresult;
pub extern fn cuGraphInstantiateWithParams(phGraphExec: [*c]CUgraphExec, hGraph: CUgraph, instantiateParams: [*c]CUDA_GRAPH_INSTANTIATE_PARAMS) CUresult;
pub extern fn cuGraphExecGetFlags(hGraphExec: CUgraphExec, flags: [*c]cuuint64_t) CUresult;
pub extern fn cuGraphExecKernelNodeSetParams_v2(hGraphExec: CUgraphExec, hNode: CUgraphNode, nodeParams: [*c]const CUDA_KERNEL_NODE_PARAMS) CUresult;
pub extern fn cuGraphExecMemcpyNodeSetParams(hGraphExec: CUgraphExec, hNode: CUgraphNode, copyParams: [*c]const CUDA_MEMCPY3D, ctx: CUcontext) CUresult;
pub extern fn cuGraphExecMemsetNodeSetParams(hGraphExec: CUgraphExec, hNode: CUgraphNode, memsetParams: [*c]const CUDA_MEMSET_NODE_PARAMS, ctx: CUcontext) CUresult;
pub extern fn cuGraphExecHostNodeSetParams(hGraphExec: CUgraphExec, hNode: CUgraphNode, nodeParams: [*c]const CUDA_HOST_NODE_PARAMS) CUresult;
pub extern fn cuGraphExecChildGraphNodeSetParams(hGraphExec: CUgraphExec, hNode: CUgraphNode, childGraph: CUgraph) CUresult;
pub extern fn cuGraphExecEventRecordNodeSetEvent(hGraphExec: CUgraphExec, hNode: CUgraphNode, event: CUevent) CUresult;
pub extern fn cuGraphExecEventWaitNodeSetEvent(hGraphExec: CUgraphExec, hNode: CUgraphNode, event: CUevent) CUresult;
pub extern fn cuGraphExecExternalSemaphoresSignalNodeSetParams(hGraphExec: CUgraphExec, hNode: CUgraphNode, nodeParams: [*c]const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS) CUresult;
pub extern fn cuGraphExecExternalSemaphoresWaitNodeSetParams(hGraphExec: CUgraphExec, hNode: CUgraphNode, nodeParams: [*c]const CUDA_EXT_SEM_WAIT_NODE_PARAMS) CUresult;
pub extern fn cuGraphNodeSetEnabled(hGraphExec: CUgraphExec, hNode: CUgraphNode, isEnabled: c_uint) CUresult;
pub extern fn cuGraphNodeGetEnabled(hGraphExec: CUgraphExec, hNode: CUgraphNode, isEnabled: [*c]c_uint) CUresult;
pub extern fn cuGraphUpload(hGraphExec: CUgraphExec, hStream: CUstream) CUresult;
pub extern fn cuGraphLaunch(hGraphExec: CUgraphExec, hStream: CUstream) CUresult;
pub extern fn cuGraphExecDestroy(hGraphExec: CUgraphExec) CUresult;
pub extern fn cuGraphDestroy(hGraph: CUgraph) CUresult;
pub extern fn cuGraphExecUpdate_v2(hGraphExec: CUgraphExec, hGraph: CUgraph, resultInfo: [*c]CUgraphExecUpdateResultInfo) CUresult;
pub extern fn cuGraphKernelNodeCopyAttributes(dst: CUgraphNode, src: CUgraphNode) CUresult;
pub extern fn cuGraphKernelNodeGetAttribute(hNode: CUgraphNode, attr: CUkernelNodeAttrID, value_out: [*c]CUkernelNodeAttrValue) CUresult;
pub extern fn cuGraphKernelNodeSetAttribute(hNode: CUgraphNode, attr: CUkernelNodeAttrID, value: [*c]const CUkernelNodeAttrValue) CUresult;
pub extern fn cuGraphDebugDotPrint(hGraph: CUgraph, path: [*c]const u8, flags: c_uint) CUresult;
pub extern fn cuUserObjectCreate(object_out: [*c]CUuserObject, ptr: ?*anyopaque, destroy: CUhostFn, initialRefcount: c_uint, flags: c_uint) CUresult;
pub extern fn cuUserObjectRetain(object: CUuserObject, count: c_uint) CUresult;
pub extern fn cuUserObjectRelease(object: CUuserObject, count: c_uint) CUresult;
pub extern fn cuGraphRetainUserObject(graph: CUgraph, object: CUuserObject, count: c_uint, flags: c_uint) CUresult;
pub extern fn cuGraphReleaseUserObject(graph: CUgraph, object: CUuserObject, count: c_uint) CUresult;
pub extern fn cuGraphAddNode_v2(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, dependencyData: [*c]const CUgraphEdgeData, numDependencies: usize, nodeParams: [*c]CUgraphNodeParams) CUresult;
pub extern fn cuGraphAddNode_v3(phGraphNode: [*c]CUgraphNode, hGraph: CUgraph, dependencies: [*c]const CUgraphNode, dependencyData: [*c]const CUgraphEdgeData, numDependencies: usize, nodeParams: [*c]CUgraphNodeParams) CUresult;
pub extern fn cuGraphNodeSetParams(hNode: CUgraphNode, nodeParams: [*c]CUgraphNodeParams) CUresult;
pub extern fn cuGraphNodeSetParams_v2(hNode: CUgraphNode, nodeParams: [*c]CUgraphNodeParams) CUresult;
pub extern fn cuGraphNodeGetParams(hNode: CUgraphNode, nodeParams: [*c]CUgraphNodeParams) CUresult;
pub extern fn cuGraphExecNodeSetParams(hGraphExec: CUgraphExec, hNode: CUgraphNode, nodeParams: [*c]CUgraphNodeParams) CUresult;
pub extern fn cuGraphConditionalHandleCreate(pHandle_out: [*c]CUgraphConditionalHandle, hGraph: CUgraph, ctx: CUcontext, defaultLaunchValue: c_uint, flags: c_uint) CUresult;
pub extern fn cuOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks: [*c]c_int, func: CUfunction, blockSize: c_int, dynamicSMemSize: usize) CUresult;
pub extern fn cuOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks: [*c]c_int, func: CUfunction, blockSize: c_int, dynamicSMemSize: usize, flags: c_uint) CUresult;
pub extern fn cuOccupancyMaxPotentialBlockSize(minGridSize: [*c]c_int, blockSize: [*c]c_int, func: CUfunction, blockSizeToDynamicSMemSize: CUoccupancyB2DSize, dynamicSMemSize: usize, blockSizeLimit: c_int) CUresult;
pub extern fn cuOccupancyMaxPotentialBlockSizeWithFlags(minGridSize: [*c]c_int, blockSize: [*c]c_int, func: CUfunction, blockSizeToDynamicSMemSize: CUoccupancyB2DSize, dynamicSMemSize: usize, blockSizeLimit: c_int, flags: c_uint) CUresult;
pub extern fn cuOccupancyAvailableDynamicSMemPerBlock(dynamicSmemSize: [*c]usize, func: CUfunction, numBlocks: c_int, blockSize: c_int) CUresult;
pub extern fn cuOccupancyMaxPotentialClusterSize(clusterSize: [*c]c_int, func: CUfunction, config: [*c]const CUlaunchConfig) CUresult;
pub extern fn cuOccupancyMaxActiveClusters(numClusters: [*c]c_int, func: CUfunction, config: [*c]const CUlaunchConfig) CUresult;
pub extern fn cuTexRefSetArray(hTexRef: CUtexref, hArray: CUarray, Flags: c_uint) CUresult;
pub extern fn cuTexRefSetMipmappedArray(hTexRef: CUtexref, hMipmappedArray: CUmipmappedArray, Flags: c_uint) CUresult;
pub extern fn cuTexRefSetAddress_v2(ByteOffset: [*c]usize, hTexRef: CUtexref, dptr: CUdeviceptr, bytes: usize) CUresult;
pub extern fn cuTexRefSetAddress2D_v3(hTexRef: CUtexref, desc: [*c]const CUDA_ARRAY_DESCRIPTOR, dptr: CUdeviceptr, Pitch: usize) CUresult;
pub extern fn cuTexRefSetFormat(hTexRef: CUtexref, fmt: CUarray_format, NumPackedComponents: c_int) CUresult;
pub extern fn cuTexRefSetAddressMode(hTexRef: CUtexref, dim: c_int, am: CUaddress_mode) CUresult;
pub extern fn cuTexRefSetFilterMode(hTexRef: CUtexref, fm: CUfilter_mode) CUresult;
pub extern fn cuTexRefSetMipmapFilterMode(hTexRef: CUtexref, fm: CUfilter_mode) CUresult;
pub extern fn cuTexRefSetMipmapLevelBias(hTexRef: CUtexref, bias: f32) CUresult;
pub extern fn cuTexRefSetMipmapLevelClamp(hTexRef: CUtexref, minMipmapLevelClamp: f32, maxMipmapLevelClamp: f32) CUresult;
pub extern fn cuTexRefSetMaxAnisotropy(hTexRef: CUtexref, maxAniso: c_uint) CUresult;
pub extern fn cuTexRefSetBorderColor(hTexRef: CUtexref, pBorderColor: [*c]f32) CUresult;
pub extern fn cuTexRefSetFlags(hTexRef: CUtexref, Flags: c_uint) CUresult;
pub extern fn cuTexRefGetAddress_v2(pdptr: [*c]CUdeviceptr, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetArray(phArray: [*c]CUarray, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetMipmappedArray(phMipmappedArray: [*c]CUmipmappedArray, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetAddressMode(pam: [*c]CUaddress_mode, hTexRef: CUtexref, dim: c_int) CUresult;
pub extern fn cuTexRefGetFilterMode(pfm: [*c]CUfilter_mode, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetFormat(pFormat: [*c]CUarray_format, pNumChannels: [*c]c_int, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetMipmapFilterMode(pfm: [*c]CUfilter_mode, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetMipmapLevelBias(pbias: [*c]f32, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetMipmapLevelClamp(pminMipmapLevelClamp: [*c]f32, pmaxMipmapLevelClamp: [*c]f32, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetMaxAnisotropy(pmaxAniso: [*c]c_int, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetBorderColor(pBorderColor: [*c]f32, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefGetFlags(pFlags: [*c]c_uint, hTexRef: CUtexref) CUresult;
pub extern fn cuTexRefCreate(pTexRef: [*c]CUtexref) CUresult;
pub extern fn cuTexRefDestroy(hTexRef: CUtexref) CUresult;
pub extern fn cuSurfRefSetArray(hSurfRef: CUsurfref, hArray: CUarray, Flags: c_uint) CUresult;
pub extern fn cuSurfRefGetArray(phArray: [*c]CUarray, hSurfRef: CUsurfref) CUresult;
pub extern fn cuTexObjectCreate(pTexObject: [*c]CUtexObject, pResDesc: [*c]const CUDA_RESOURCE_DESC, pTexDesc: [*c]const CUDA_TEXTURE_DESC, pResViewDesc: [*c]const CUDA_RESOURCE_VIEW_DESC) CUresult;
pub extern fn cuTexObjectDestroy(texObject: CUtexObject) CUresult;
pub extern fn cuTexObjectGetResourceDesc(pResDesc: [*c]CUDA_RESOURCE_DESC, texObject: CUtexObject) CUresult;
pub extern fn cuTexObjectGetTextureDesc(pTexDesc: [*c]CUDA_TEXTURE_DESC, texObject: CUtexObject) CUresult;
pub extern fn cuTexObjectGetResourceViewDesc(pResViewDesc: [*c]CUDA_RESOURCE_VIEW_DESC, texObject: CUtexObject) CUresult;
pub extern fn cuSurfObjectCreate(pSurfObject: [*c]CUsurfObject, pResDesc: [*c]const CUDA_RESOURCE_DESC) CUresult;
pub extern fn cuSurfObjectDestroy(surfObject: CUsurfObject) CUresult;
pub extern fn cuSurfObjectGetResourceDesc(pResDesc: [*c]CUDA_RESOURCE_DESC, surfObject: CUsurfObject) CUresult;
pub extern fn cuTensorMapEncodeTiled(tensorMap: [*c]CUtensorMap, tensorDataType: CUtensorMapDataType, tensorRank: cuuint32_t, globalAddress: ?*anyopaque, globalDim: [*c]const cuuint64_t, globalStrides: [*c]const cuuint64_t, boxDim: [*c]const cuuint32_t, elementStrides: [*c]const cuuint32_t, interleave: CUtensorMapInterleave, swizzle: CUtensorMapSwizzle, l2Promotion: CUtensorMapL2promotion, oobFill: CUtensorMapFloatOOBfill) CUresult;
pub extern fn cuTensorMapEncodeIm2col(tensorMap: [*c]CUtensorMap, tensorDataType: CUtensorMapDataType, tensorRank: cuuint32_t, globalAddress: ?*anyopaque, globalDim: [*c]const cuuint64_t, globalStrides: [*c]const cuuint64_t, pixelBoxLowerCorner: [*c]const c_int, pixelBoxUpperCorner: [*c]const c_int, channelsPerPixel: cuuint32_t, pixelsPerColumn: cuuint32_t, elementStrides: [*c]const cuuint32_t, interleave: CUtensorMapInterleave, swizzle: CUtensorMapSwizzle, l2Promotion: CUtensorMapL2promotion, oobFill: CUtensorMapFloatOOBfill) CUresult;
pub extern fn cuTensorMapEncodeIm2colWide(tensorMap: [*c]CUtensorMap, tensorDataType: CUtensorMapDataType, tensorRank: cuuint32_t, globalAddress: ?*anyopaque, globalDim: [*c]const cuuint64_t, globalStrides: [*c]const cuuint64_t, pixelBoxLowerCornerWidth: c_int, pixelBoxUpperCornerWidth: c_int, channelsPerPixel: cuuint32_t, pixelsPerColumn: cuuint32_t, elementStrides: [*c]const cuuint32_t, interleave: CUtensorMapInterleave, mode: CUtensorMapIm2ColWideMode, swizzle: CUtensorMapSwizzle, l2Promotion: CUtensorMapL2promotion, oobFill: CUtensorMapFloatOOBfill) CUresult;
pub extern fn cuTensorMapReplaceAddress(tensorMap: [*c]CUtensorMap, globalAddress: ?*anyopaque) CUresult;
pub extern fn cuDeviceCanAccessPeer(canAccessPeer: [*c]c_int, dev: CUdevice, peerDev: CUdevice) CUresult;
pub extern fn cuCtxEnablePeerAccess(peerContext: CUcontext, Flags: c_uint) CUresult;
pub extern fn cuCtxDisablePeerAccess(peerContext: CUcontext) CUresult;
pub extern fn cuDeviceGetP2PAttribute(value: [*c]c_int, attrib: CUdevice_P2PAttribute, srcDevice: CUdevice, dstDevice: CUdevice) CUresult;
pub extern fn cuDeviceGetP2PAtomicCapabilities(capabilities: [*c]c_uint, operations: [*c]const CUatomicOperation, count: c_uint, srcDevice: CUdevice, dstDevice: CUdevice) CUresult;
pub extern fn cuGraphicsUnregisterResource(resource: CUgraphicsResource) CUresult;
pub extern fn cuGraphicsSubResourceGetMappedArray(pArray: [*c]CUarray, resource: CUgraphicsResource, arrayIndex: c_uint, mipLevel: c_uint) CUresult;
pub extern fn cuGraphicsResourceGetMappedMipmappedArray(pMipmappedArray: [*c]CUmipmappedArray, resource: CUgraphicsResource) CUresult;
pub extern fn cuGraphicsResourceGetMappedPointer_v2(pDevPtr: [*c]CUdeviceptr, pSize: [*c]usize, resource: CUgraphicsResource) CUresult;
pub extern fn cuGraphicsResourceSetMapFlags_v2(resource: CUgraphicsResource, flags: c_uint) CUresult;
pub extern fn cuGraphicsMapResources(count: c_uint, resources: [*c]CUgraphicsResource, hStream: CUstream) CUresult;
pub extern fn cuGraphicsUnmapResources(count: c_uint, resources: [*c]CUgraphicsResource, hStream: CUstream) CUresult;
pub extern fn cuGetProcAddress_v2(symbol: [*c]const u8, pfn: [*c]?*anyopaque, cudaVersion: c_int, flags: cuuint64_t, symbolStatus: [*c]CUdriverProcAddressQueryResult) CUresult;
pub const CU_COREDUMP_ENABLE_ON_EXCEPTION: c_int = 1;
pub const CU_COREDUMP_TRIGGER_HOST: c_int = 2;
pub const CU_COREDUMP_LIGHTWEIGHT: c_int = 3;
pub const CU_COREDUMP_ENABLE_USER_TRIGGER: c_int = 4;
pub const CU_COREDUMP_FILE: c_int = 5;
pub const CU_COREDUMP_PIPE: c_int = 6;
pub const CU_COREDUMP_GENERATION_FLAGS: c_int = 7;
pub const CU_COREDUMP_MAX: c_int = 8;
pub const enum_CUcoredumpSettings_enum = c_uint;
pub const CUcoredumpSettings = enum_CUcoredumpSettings_enum;
pub const CU_COREDUMP_DEFAULT_FLAGS: c_int = 0;
pub const CU_COREDUMP_SKIP_NONRELOCATED_ELF_IMAGES: c_int = 1;
pub const CU_COREDUMP_SKIP_GLOBAL_MEMORY: c_int = 2;
pub const CU_COREDUMP_SKIP_SHARED_MEMORY: c_int = 4;
pub const CU_COREDUMP_SKIP_LOCAL_MEMORY: c_int = 8;
pub const CU_COREDUMP_SKIP_ABORT: c_int = 16;
pub const CU_COREDUMP_SKIP_CONSTBANK_MEMORY: c_int = 32;
pub const CU_COREDUMP_GZIP_COMPRESS: c_int = 64;
pub const CU_COREDUMP_FAULTED_CONTEXTS_ONLY: c_int = 128;
pub const CU_COREDUMP_NO_ERRBAR_AT_EXIT: c_int = 1073741824;
pub const CU_COREDUMP_LOG_ONLY: c_int = -2147483648;
pub const CU_COREDUMP_LIGHTWEIGHT_FLAGS: c_int = 47;
pub const enum_CUCoredumpGenerationFlags = c_int;
pub const CUCoredumpGenerationFlags = enum_CUCoredumpGenerationFlags;
pub extern fn cuCoredumpGetAttribute(attrib: CUcoredumpSettings, value: ?*anyopaque, size: [*c]usize) CUresult;
pub extern fn cuCoredumpGetAttributeGlobal(attrib: CUcoredumpSettings, value: ?*anyopaque, size: [*c]usize) CUresult;
pub extern fn cuCoredumpSetAttribute(attrib: CUcoredumpSettings, value: ?*anyopaque, size: [*c]usize) CUresult;
pub extern fn cuCoredumpSetAttributeGlobal(attrib: CUcoredumpSettings, value: ?*anyopaque, size: [*c]usize) CUresult;
pub const struct_CUcoredumpCallbackEntry_st = opaque {
    pub const cuCoredumpDeregisterStartCallback = __root.cuCoredumpDeregisterStartCallback;
    pub const cuCoredumpDeregisterCompleteCallback = __root.cuCoredumpDeregisterCompleteCallback;
};
pub const CUcoredumpCallbackHandle = ?*struct_CUcoredumpCallbackEntry_st;
pub const CUcoredumpStatusCallback = ?*const fn (userData: ?*anyopaque, pid: c_int, dev: CUdevice) callconv(.c) void;
pub extern fn cuCoredumpRegisterStartCallback(callback: CUcoredumpStatusCallback, userData: ?*anyopaque, callbackOut: [*c]CUcoredumpCallbackHandle) CUresult;
pub extern fn cuCoredumpRegisterCompleteCallback(callback: CUcoredumpStatusCallback, userData: ?*anyopaque, callbackOut: [*c]CUcoredumpCallbackHandle) CUresult;
pub extern fn cuCoredumpDeregisterStartCallback(callback: CUcoredumpCallbackHandle) CUresult;
pub extern fn cuCoredumpDeregisterCompleteCallback(callback: CUcoredumpCallbackHandle) CUresult;
pub extern fn cuGetExportTable(ppExportTable: [*c]?*const anyopaque, pExportTableId: [*c]const CUuuid) CUresult;
pub const struct_CUdevResourceDesc_st = opaque {};
pub const CUdevResourceDesc = ?*struct_CUdevResourceDesc_st;
pub const CU_GREEN_CTX_NONE: c_int = 0;
pub const CU_GREEN_CTX_DEFAULT_STREAM: c_int = 1;
pub const CUgreenCtxCreate_flags = c_uint;
pub const CU_DEV_SM_RESOURCE_GROUP_DEFAULT: c_int = 0;
pub const CU_DEV_SM_RESOURCE_GROUP_BACKFILL: c_int = 1;
pub const CU_DEV_SM_RESOURCE_GROUP_LOCALITY_DOMAIN_ID: c_int = 2;
pub const CUdevSmResourceGroup_flags = c_uint;
pub const CU_DEV_SM_RESOURCE_SPLIT_IGNORE_SM_COSCHEDULING: c_int = 1;
pub const CU_DEV_SM_RESOURCE_SPLIT_MAX_POTENTIAL_CLUSTER_SIZE: c_int = 2;
pub const CUdevSmResourceSplitByCount_flags = c_uint;
pub const CU_DEV_RESOURCE_TYPE_INVALID: c_int = 0;
pub const CU_DEV_RESOURCE_TYPE_SM: c_int = 1;
pub const CU_DEV_RESOURCE_TYPE_WORKQUEUE_CONFIG: c_int = 1000;
pub const CU_DEV_RESOURCE_TYPE_WORKQUEUE: c_int = 10000;
pub const CUdevResourceType = c_uint;
pub const struct_CUdevSmResource_st = extern struct {
    smCount: c_uint = 0,
    minSmPartitionSize: c_uint = 0,
    smCoscheduledAlignment: c_uint = 0,
    flags: c_uint = 0,
    localityDomainId: c_uint = 0,
};
pub const CUdevSmResource = struct_CUdevSmResource_st;
pub const CU_WORKQUEUE_SCOPE_DEVICE_CTX: c_int = 0;
pub const CU_WORKQUEUE_SCOPE_GREEN_CTX_BALANCED: c_int = 1;
pub const CUdevWorkqueueConfigScope = c_uint;
pub const struct_CUdevWorkqueueConfigResource_st = extern struct {
    device: CUdevice = 0,
    wqConcurrencyLimit: c_uint = 0,
    sharingScope: CUdevWorkqueueConfigScope = @import("std").mem.zeroes(CUdevWorkqueueConfigScope),
};
pub const CUdevWorkqueueConfigResource = struct_CUdevWorkqueueConfigResource_st;
pub const struct_CUdevWorkqueueResource_st = extern struct {
    reserved: [40]u8 = @import("std").mem.zeroes([40]u8),
};
pub const CUdevWorkqueueResource = struct_CUdevWorkqueueResource_st;
pub const struct_CU_DEV_SM_RESOURCE_GROUP_PARAMS_st = extern struct {
    smCount: c_uint = 0,
    coscheduledSmCount: c_uint = 0,
    preferredCoscheduledSmCount: c_uint = 0,
    flags: c_uint = 0,
    localityDomainId: c_uint = 0,
    reserved: [11]c_uint = @import("std").mem.zeroes([11]c_uint),
};
pub const CU_DEV_SM_RESOURCE_GROUP_PARAMS = struct_CU_DEV_SM_RESOURCE_GROUP_PARAMS_st;
const union_unnamed_55 = extern union {
    sm: CUdevSmResource,
    wqConfig: CUdevWorkqueueConfigResource,
    wq: CUdevWorkqueueResource,
    _oversize: [40]u8,
};
pub const struct_CUdevResource_st = extern struct {
    type: CUdevResourceType = @import("std").mem.zeroes(CUdevResourceType),
    _internal_padding: [92]u8 = @import("std").mem.zeroes([92]u8),
    unnamed_0: union_unnamed_55 = @import("std").mem.zeroes(union_unnamed_55),
    nextResource: [*c]struct_CUdevResource_st = null,
    pub const cuDevSmResourceSplitByCount = __root.cuDevSmResourceSplitByCount;
    pub const cuDevSmResourceSplit = __root.cuDevSmResourceSplit;
};
pub const CUdevResource_v1 = struct_CUdevResource_st;
pub const CUdevResource = CUdevResource_v1;
pub extern fn cuGreenCtxCreate(phCtx: [*c]CUgreenCtx, desc: CUdevResourceDesc, dev: CUdevice, flags: c_uint) CUresult;
pub extern fn cuGreenCtxDestroy(hCtx: CUgreenCtx) CUresult;
pub extern fn cuCtxFromGreenCtx(pContext: [*c]CUcontext, hCtx: CUgreenCtx) CUresult;
pub extern fn cuDeviceGetDevResource(device: CUdevice, resource: [*c]CUdevResource, @"type": CUdevResourceType) CUresult;
pub extern fn cuCtxGetDevResource(hCtx: CUcontext, resource: [*c]CUdevResource, @"type": CUdevResourceType) CUresult;
pub extern fn cuGreenCtxGetDevResource(hCtx: CUgreenCtx, resource: [*c]CUdevResource, @"type": CUdevResourceType) CUresult;
pub extern fn cuDevSmResourceSplitByCount(result: [*c]CUdevResource, nbGroups: [*c]c_uint, input: [*c]const CUdevResource, remainder: [*c]CUdevResource, flags: c_uint, minCount: c_uint) CUresult;
pub extern fn cuDevSmResourceSplit(result: [*c]CUdevResource, nbGroups: c_uint, input: [*c]const CUdevResource, remainder: [*c]CUdevResource, flags: c_uint, groupParams: [*c]CU_DEV_SM_RESOURCE_GROUP_PARAMS) CUresult;
pub extern fn cuDevResourceGenerateDesc(phDesc: [*c]CUdevResourceDesc, resources: [*c]CUdevResource, nbResources: c_uint) CUresult;
pub extern fn cuGreenCtxRecordEvent(hCtx: CUgreenCtx, hEvent: CUevent) CUresult;
pub extern fn cuGreenCtxWaitEvent(hCtx: CUgreenCtx, hEvent: CUevent) CUresult;
pub extern fn cuStreamGetGreenCtx(hStream: CUstream, phCtx: [*c]CUgreenCtx) CUresult;
pub extern fn cuGreenCtxStreamCreate(phStream: [*c]CUstream, greenCtx: CUgreenCtx, flags: c_uint, priority: c_int) CUresult;
pub extern fn cuGreenCtxGetId(greenCtx: CUgreenCtx, greenCtxId: [*c]c_ulonglong) CUresult;
pub extern fn cuStreamGetDevResource(hStream: CUstream, resource: [*c]CUdevResource, @"type": CUdevResourceType) CUresult;
pub const CU_LOG_LEVEL_ERROR: c_int = 0;
pub const CU_LOG_LEVEL_WARNING: c_int = 1;
pub const enum_CUlogLevel_enum = c_uint;
pub const CUlogLevel = enum_CUlogLevel_enum;
pub const struct_CUlogsCallbackEntry_st = opaque {
    pub const cuLogsUnregisterCallback = __root.cuLogsUnregisterCallback;
};
pub const CUlogsCallbackHandle = ?*struct_CUlogsCallbackEntry_st;
pub const CUlogsCallback = ?*const fn (data: ?*anyopaque, logLevel: CUlogLevel, message: [*c]u8, length: usize) callconv(.c) void;
pub const CUlogIterator = c_uint;
pub extern fn cuLogsRegisterCallback(callbackFunc: CUlogsCallback, userData: ?*anyopaque, callback_out: [*c]CUlogsCallbackHandle) CUresult;
pub extern fn cuLogsUnregisterCallback(callback: CUlogsCallbackHandle) CUresult;
pub extern fn cuLogsCurrent(iterator_out: [*c]CUlogIterator, flags: c_uint) CUresult;
pub extern fn cuLogsDumpToFile(iterator: [*c]CUlogIterator, pathToFile: [*c]const u8, flags: c_uint) CUresult;
pub extern fn cuLogsDumpToMemory(iterator: [*c]CUlogIterator, buffer: [*c]u8, size: [*c]usize, flags: c_uint) CUresult;
pub extern fn cuCheckpointProcessGetRestoreThreadId(pid: c_int, tid: [*c]c_int) CUresult;
pub extern fn cuCheckpointProcessGetState(pid: c_int, state: [*c]CUprocessState) CUresult;
pub extern fn cuCheckpointProcessLock(pid: c_int, args: [*c]CUcheckpointLockArgs) CUresult;
pub extern fn cuCheckpointProcessCheckpoint(pid: c_int, args: [*c]CUcheckpointCheckpointArgs) CUresult;
pub extern fn cuCheckpointProcessRestore(pid: c_int, args: [*c]CUcheckpointRestoreArgs) CUresult;
pub extern fn cuCheckpointOperationComplete(handle: CUcheckpointOperationHandle) CUresult;
pub extern fn cuCheckpointProcessUnlock(pid: c_int, args: [*c]CUcheckpointUnlockArgs) CUresult;
pub extern fn cuCtxCreate_v2(pctx: [*c]CUcontext, flags: c_uint, dev: CUdevice) CUresult;

pub const __VERSION__ = "Aro aro-zig";
pub const __Aro__ = "";
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __GNUC__ = @as(c_int, 7);
pub const __GNUC_MINOR__ = @as(c_int, 1);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 0);
pub const __ARO_EMULATE_NO__ = @as(c_int, 0);
pub const __ARO_EMULATE_CLANG__ = @as(c_int, 1);
pub const __ARO_EMULATE_GCC__ = @as(c_int, 2);
pub const __ARO_EMULATE_MSVC__ = @as(c_int, 3);
pub const __ARO_EMULATE__ = __ARO_EMULATE_GCC__;
pub inline fn __building_module(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`");
// <builtin>:33:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`");
// <builtin>:34:9
pub const __FXSR__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WINT_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SCHAR_WIDTH__ = @as(c_int, 8);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __LONG_LONG_WIDTH__ = @as(c_int, 64);
pub const __WCHAR_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIG_ATOMIC_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __BITINT_MAXWIDTH__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 10);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTPTR_TYPE__ = c_long;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// <builtin>:116:9
pub const __INTMAX_C = __helpers.L_SUFFIX;
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// <builtin>:119:9
pub const __UINTMAX_C = __helpers.UL_SUFFIX;
pub const __PTRDIFF_TYPE__ = c_long;
pub const __SIZE_TYPE__ = c_ulong;
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub inline fn __INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub inline fn __INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub inline fn __INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// <builtin>:145:9
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub inline fn __UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub inline fn __UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`");
// <builtin>:170:9
pub const __UINT32_C = __helpers.U_SUFFIX;
pub const __UINT32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// <builtin>:179:9
pub const __UINT64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const INT_LEAST8_FMTd__ = "hhd";
pub const INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const UINT_LEAST8_FMTo__ = "hho";
pub const UINT_LEAST8_FMTu__ = "hhu";
pub const UINT_LEAST8_FMTx__ = "hhx";
pub const UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const INT_FAST8_FMTd__ = "hhd";
pub const INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const UINT_FAST8_FMTo__ = "hho";
pub const UINT_FAST8_FMTu__ = "hhu";
pub const UINT_FAST8_FMTx__ = "hhx";
pub const UINT_FAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const INT_LEAST16_FMTd__ = "hd";
pub const INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST16_FMTo__ = "ho";
pub const UINT_LEAST16_FMTu__ = "hu";
pub const UINT_LEAST16_FMTx__ = "hx";
pub const UINT_LEAST16_FMTX__ = "hX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const INT_FAST16_FMTd__ = "hd";
pub const INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_FAST16_FMTo__ = "ho";
pub const UINT_FAST16_FMTu__ = "hu";
pub const UINT_FAST16_FMTx__ = "hx";
pub const UINT_FAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const INT_LEAST32_FMTd__ = "d";
pub const INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST32_FMTo__ = "o";
pub const UINT_LEAST32_FMTu__ = "u";
pub const UINT_LEAST32_FMTx__ = "x";
pub const UINT_LEAST32_FMTX__ = "X";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const INT_FAST32_FMTd__ = "d";
pub const INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_FAST32_FMTo__ = "o";
pub const UINT_FAST32_FMTu__ = "u";
pub const UINT_FAST32_FMTx__ = "x";
pub const UINT_FAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const INT_LEAST64_FMTd__ = "ld";
pub const INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_LEAST64_FMTo__ = "lo";
pub const UINT_LEAST64_FMTu__ = "lu";
pub const UINT_LEAST64_FMTx__ = "lx";
pub const UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const INT_FAST64_FMTd__ = "ld";
pub const INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_FMTo__ = "lo";
pub const UINT_FAST64_FMTu__ = "lu";
pub const UINT_FAST64_FMTx__ = "lx";
pub const UINT_FAST64_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = "";
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = "";
pub const __FLT16_HAS_QUIET_NAN__ = "";
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = "";
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = "";
pub const __FLT_HAS_QUIET_NAN__ = "";
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = "";
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = "";
pub const __DBL_HAS_QUIET_NAN__ = "";
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = "";
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = "";
pub const __LDBL_HAS_QUIET_NAN__ = "";
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __pic__ = @as(c_int, 2);
pub const __PIC__ = @as(c_int, 2);
pub const __GLIBC_MINOR__ = @as(c_int, 31);
pub const __cuda_cuda_h__ = "";
pub const _FEATURES_H = @as(c_int, 1);
pub const __KERNEL_STRICT_NAMES = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __glibc_clang_prereq(maj: anytype, min: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &maj;
    _ = &min;
    return @as(c_int, 0);
}
pub const __GLIBC_USE = @compileError("unable to translate macro: undefined identifier `__GLIBC_USE_`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/features.h:197:9
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const __GLIBC_USE_ISOC2Y = @as(c_int, 0);
pub const __GLIBC_USE_ISOC23 = @as(c_int, 0);
pub const __USE_ISOC11 = @as(c_int, 1);
pub const __USE_POSIX_IMPLICITLY = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 202405);
pub const __USE_POSIX = @as(c_int, 1);
pub const __USE_POSIX2 = @as(c_int, 1);
pub const __USE_POSIX199309 = @as(c_int, 1);
pub const __USE_POSIX199506 = @as(c_int, 1);
pub const __USE_XOPEN2K = @as(c_int, 1);
pub const __USE_ISOC95 = @as(c_int, 1);
pub const __USE_ISOC99 = @as(c_int, 1);
pub const __USE_XOPEN2K8 = @as(c_int, 1);
pub const _ATFILE_SOURCE = @as(c_int, 1);
pub const __USE_XOPEN2K24 = @as(c_int, 1);
pub const __WORDSIZE = @as(c_int, 64);
pub const __WORDSIZE_TIME64_COMPAT32 = @as(c_int, 1);
pub const __SYSCALL_WORDSIZE = @as(c_int, 64);
pub const __TIMESIZE = __WORDSIZE;
pub const __USE_TIME_BITS64 = @as(c_int, 1);
pub const __USE_MISC = @as(c_int, 1);
pub const __USE_ATFILE = @as(c_int, 1);
pub const __USE_FORTIFY_LEVEL = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_GETS = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_SCANF = @as(c_int, 0);
pub const __GLIBC_USE_C23_STRTOL = @as(c_int, 0);
pub const _STDC_PREDEF_H = @as(c_int, 1);
pub const __STDC_IEC_559__ = @as(c_int, 1);
pub const __STDC_IEC_60559_BFP__ = @as(c_long, 201404);
pub const __STDC_IEC_559_COMPLEX__ = @as(c_int, 1);
pub const __STDC_IEC_60559_COMPLEX__ = @as(c_long, 201404);
pub const __STDC_ISO_10646__ = @as(c_long, 201706);
pub const __GNU_LIBRARY__ = @as(c_int, 6);
pub const __GLIBC__ = @as(c_int, 2);
pub inline fn __GLIBC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub const _SYS_CDEFS_H = @as(c_int, 1);
pub const __glibc_has_attribute = @compileError("unable to translate macro: undefined identifier `__has_attribute`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:45:10
pub inline fn __glibc_has_builtin(name: anytype) @TypeOf(__builtin.has_builtin(name)) {
    _ = &name;
    return __builtin.has_builtin(name);
}
pub const __glibc_has_extension = @compileError("unable to translate macro: undefined identifier `__has_extension`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:55:10
pub const __LEAF = @compileError("unable to translate macro: undefined identifier `__leaf__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:65:11
pub const __LEAF_ATTR = @compileError("unable to translate macro: undefined identifier `__leaf__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:66:11
pub const __THROW = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:79:11
pub const __THROWNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:80:11
pub const __NTH = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:81:11
pub const __NTHNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:82:11
pub const __COLD = @compileError("unable to translate macro: undefined identifier `__cold__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:102:11
pub inline fn __P(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub inline fn __PMT(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:131:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token ''");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:132:9
pub const __ptr_t = ?*anyopaque;
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub const __attribute_overloadable__ = "";
pub inline fn __bos(ptr: anytype) @TypeOf(__builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1))) {
    _ = &ptr;
    return __builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1));
}
pub inline fn __bos0(ptr: anytype) @TypeOf(__builtin.object_size(ptr, @as(c_int, 0))) {
    _ = &ptr;
    return __builtin.object_size(ptr, @as(c_int, 0));
}
pub inline fn __glibc_objsize0(__o: anytype) @TypeOf(__bos0(__o)) {
    _ = &__o;
    return __bos0(__o);
}
pub inline fn __glibc_objsize(__o: anytype) @TypeOf(__bos(__o)) {
    _ = &__o;
    return __bos(__o);
}
pub const __warnattr = @compileError("unable to translate macro: undefined identifier `__warning__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:366:10
pub const __errordecl = @compileError("unable to translate macro: undefined identifier `__error__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:367:10
pub const __flexarr = @compileError("unable to translate C expr: unexpected token '['");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:379:10
pub const __glibc_c99_flexarr_available = @as(c_int, 1);
pub const __REDIRECT = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:410:10
pub const __REDIRECT_NTH = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:417:11
pub const __REDIRECT_NTHNL = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:419:11
pub const __ASMNAME = @compileError("unable to translate macro: undefined identifier `__USER_LABEL_PREFIX__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:422:10
pub inline fn __ASMNAME2(prefix: anytype, cname: anytype) @TypeOf(__STRING(prefix) ++ cname) {
    _ = &prefix;
    _ = &cname;
    return __STRING(prefix) ++ cname;
}
pub const __REDIRECT_FORTIFY = __REDIRECT;
pub const __REDIRECT_FORTIFY_NTH = __REDIRECT_NTH;
pub const __attribute_malloc__ = @compileError("unable to translate macro: undefined identifier `__malloc__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:452:10
pub const __attribute_alloc_size__ = @compileError("unable to translate macro: undefined identifier `__alloc_size__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:460:10
pub const __attribute_alloc_align__ = @compileError("unable to translate macro: undefined identifier `__alloc_align__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:469:10
pub const __attribute_pure__ = @compileError("unable to translate macro: undefined identifier `__pure__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:479:10
pub const __attribute_const__ = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:486:10
pub const __attribute_maybe_unused__ = @compileError("unable to translate macro: undefined identifier `__unused__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:492:10
pub const __attribute_used__ = @compileError("unable to translate macro: undefined identifier `__used__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:501:10
pub const __attribute_noinline__ = @compileError("unable to translate macro: undefined identifier `__noinline__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:502:10
pub const __attribute_deprecated__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:510:10
pub const __attribute_deprecated_msg__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:520:10
pub const __attribute_format_arg__ = @compileError("unable to translate macro: undefined identifier `__format_arg__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:533:10
pub const __attribute_format_strfmon__ = @compileError("unable to translate macro: undefined identifier `__format__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:543:10
pub const __attribute_nonnull__ = @compileError("unable to translate macro: undefined identifier `__nonnull__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:555:11
pub inline fn __nonnull(params: anytype) @TypeOf(__attribute_nonnull__(params)) {
    _ = &params;
    return __attribute_nonnull__(params);
}
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `__returns_nonnull__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:568:10
pub const __attribute_warn_unused_result__ = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:577:10
pub const __wur = "";
pub const __always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:595:10
pub const __attribute_artificial__ = @compileError("unable to translate macro: undefined identifier `__artificial__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:604:10
pub const __extern_inline = @compileError("unable to translate C expr: unexpected token 'extern'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:626:11
pub const __extern_always_inline = @compileError("unable to translate C expr: unexpected token 'extern'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:627:11
pub const __fortify_function = __extern_always_inline ++ __attribute_artificial__;
pub const __va_arg_pack = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:638:10
pub const __va_arg_pack_len = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack_len`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:639:10
pub const __restrict_arr = @compileError("unable to translate C expr: unexpected token '__restrict'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:666:10
pub inline fn __glibc_unlikely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 0))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 0));
}
pub inline fn __glibc_likely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 1))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 1));
}
pub const __attribute_nonstring__ = "";
pub inline fn __attribute_copy__(arg: anytype) void {
    _ = &arg;
    return;
}
pub const __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = @as(c_int, 0);
pub inline fn __LDBL_REDIR1(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR(name: anytype, proto: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR1_NTH(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR_NTH(name: anytype, proto: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR2_DECL(name: anytype) void {
    _ = &name;
    return;
}
pub inline fn __LDBL_REDIR_DECL(name: anytype) void {
    _ = &name;
    return;
}
pub inline fn __REDIRECT_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT(name, proto, alias);
}
pub inline fn __REDIRECT_NTH_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT_NTH(name, proto, alias);
}
pub const __glibc_macro_warning1 = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:807:10
pub const __glibc_macro_warning = @compileError("unable to translate macro: undefined identifier `GCC`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:808:10
pub const __HAVE_GENERIC_SELECTION = @as(c_int, 1);
pub const __glibc_const_generic = @compileError("unable to translate C expr: expected type instead got 'const'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:837:10
pub inline fn __fortified_attr_access(a: anytype, o: anytype, s: anytype) void {
    _ = &a;
    _ = &o;
    _ = &s;
    return;
}
pub inline fn __attr_access(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __attr_access_none(argno: anytype) void {
    _ = &argno;
    return;
}
pub inline fn __attr_dealloc(dealloc: anytype, argno: anytype) void {
    _ = &dealloc;
    _ = &argno;
    return;
}
pub const __attr_dealloc_free = "";
pub const __attribute_returns_twice__ = @compileError("unable to translate macro: undefined identifier `__returns_twice__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:884:10
pub const __attribute_struct_may_alias__ = @compileError("unable to translate macro: undefined identifier `__may_alias__`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/sys/cdefs.h:893:10
pub const __stub___compat_bdflush = "";
pub const __stub_chflags = "";
pub const __stub_fchflags = "";
pub const __stub_gtty = "";
pub const __stub_revoke = "";
pub const __stub_setlogin = "";
pub const __stub_sigreturn = "";
pub const __stub_stty = "";
pub const __need_size_t = "";
pub const __need_wchar_t = "";
pub const __need_NULL = "";
pub const __STDC_VERSION_STDDEF_H__ = @as(c_long, 202311);
pub const NULL = __helpers.cast(?*anyopaque, @as(c_int, 0));
pub const offsetof = @compileError("unable to translate macro: undefined identifier `__builtin_offsetof`");
// /home/beans/.zig-versions/nightly/lib/compiler/aro/include/stddef.h:18:9
pub const _STDLIB_H = @as(c_int, 1);
pub const WNOHANG = @as(c_int, 1);
pub const WUNTRACED = @as(c_int, 2);
pub const WSTOPPED = @as(c_int, 2);
pub const WEXITED = @as(c_int, 4);
pub const WCONTINUED = @as(c_int, 8);
pub const WNOWAIT = __helpers.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const __WNOTHREAD = __helpers.promoteIntLiteral(c_int, 0x20000000, .hex);
pub const __WALL = __helpers.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const __WCLONE = __helpers.promoteIntLiteral(c_int, 0x80000000, .hex);
pub inline fn __WEXITSTATUS(status: anytype) @TypeOf((status & __helpers.promoteIntLiteral(c_int, 0xff00, .hex)) >> @as(c_int, 8)) {
    _ = &status;
    return (status & __helpers.promoteIntLiteral(c_int, 0xff00, .hex)) >> @as(c_int, 8);
}
pub inline fn __WTERMSIG(status: anytype) @TypeOf(status & @as(c_int, 0x7f)) {
    _ = &status;
    return status & @as(c_int, 0x7f);
}
pub inline fn __WSTOPSIG(status: anytype) @TypeOf(__WEXITSTATUS(status)) {
    _ = &status;
    return __WEXITSTATUS(status);
}
pub inline fn __WIFEXITED(status: anytype) @TypeOf(__WTERMSIG(status) == @as(c_int, 0)) {
    _ = &status;
    return __WTERMSIG(status) == @as(c_int, 0);
}
pub inline fn __WIFSIGNALED(status: anytype) @TypeOf((__helpers.cast(i8, (status & @as(c_int, 0x7f)) + @as(c_int, 1)) >> @as(c_int, 1)) > @as(c_int, 0)) {
    _ = &status;
    return (__helpers.cast(i8, (status & @as(c_int, 0x7f)) + @as(c_int, 1)) >> @as(c_int, 1)) > @as(c_int, 0);
}
pub inline fn __WIFSTOPPED(status: anytype) @TypeOf((status & @as(c_int, 0xff)) == @as(c_int, 0x7f)) {
    _ = &status;
    return (status & @as(c_int, 0xff)) == @as(c_int, 0x7f);
}
pub inline fn __WIFCONTINUED(status: anytype) @TypeOf(status == __W_CONTINUED) {
    _ = &status;
    return status == __W_CONTINUED;
}
pub inline fn __WCOREDUMP(status: anytype) @TypeOf(status & __WCOREFLAG) {
    _ = &status;
    return status & __WCOREFLAG;
}
pub inline fn __W_EXITCODE(ret: anytype, sig: anytype) @TypeOf((ret << @as(c_int, 8)) | sig) {
    _ = &ret;
    _ = &sig;
    return (ret << @as(c_int, 8)) | sig;
}
pub inline fn __W_STOPCODE(sig: anytype) @TypeOf((sig << @as(c_int, 8)) | @as(c_int, 0x7f)) {
    _ = &sig;
    return (sig << @as(c_int, 8)) | @as(c_int, 0x7f);
}
pub const __W_CONTINUED = __helpers.promoteIntLiteral(c_int, 0xffff, .hex);
pub const __WCOREFLAG = @as(c_int, 0x80);
pub inline fn WEXITSTATUS(status: anytype) @TypeOf(__WEXITSTATUS(status)) {
    _ = &status;
    return __WEXITSTATUS(status);
}
pub inline fn WTERMSIG(status: anytype) @TypeOf(__WTERMSIG(status)) {
    _ = &status;
    return __WTERMSIG(status);
}
pub inline fn WSTOPSIG(status: anytype) @TypeOf(__WSTOPSIG(status)) {
    _ = &status;
    return __WSTOPSIG(status);
}
pub inline fn WIFEXITED(status: anytype) @TypeOf(__WIFEXITED(status)) {
    _ = &status;
    return __WIFEXITED(status);
}
pub inline fn WIFSIGNALED(status: anytype) @TypeOf(__WIFSIGNALED(status)) {
    _ = &status;
    return __WIFSIGNALED(status);
}
pub inline fn WIFSTOPPED(status: anytype) @TypeOf(__WIFSTOPPED(status)) {
    _ = &status;
    return __WIFSTOPPED(status);
}
pub inline fn WIFCONTINUED(status: anytype) @TypeOf(__WIFCONTINUED(status)) {
    _ = &status;
    return __WIFCONTINUED(status);
}
pub const _BITS_FLOATN_H = "";
pub const __HAVE_FLOAT128 = @as(c_int, 1);
pub const __HAVE_DISTINCT_FLOAT128 = @as(c_int, 1);
pub const __HAVE_FLOAT64X = @as(c_int, 1);
pub const __HAVE_FLOAT64X_LONG_DOUBLE = @as(c_int, 1);
pub const __f128 = @compileError("unable to translate macro: undefined identifier `f128`");
// /home/beans/.zig-versions/nightly/lib/libc/include/x86-linux-gnu/bits/floatn.h:72:12
pub const __CFLOAT128 = @compileError("unable to translate: invalid numeric type");
// /home/beans/.zig-versions/nightly/lib/libc/include/x86-linux-gnu/bits/floatn.h:86:12
pub const _BITS_FLOATN_COMMON_H = "";
pub const __HAVE_FLOAT16 = @as(c_int, 0);
pub const __HAVE_FLOAT32 = @as(c_int, 1);
pub const __HAVE_FLOAT64 = @as(c_int, 1);
pub const __HAVE_FLOAT32X = @as(c_int, 1);
pub const __HAVE_FLOAT128X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT16 = __HAVE_FLOAT16;
pub const __HAVE_DISTINCT_FLOAT32 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT64 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT32X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT64X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT128X = __HAVE_FLOAT128X;
pub const __HAVE_FLOAT128_UNLIKE_LDBL = (__HAVE_DISTINCT_FLOAT128 != 0) and (__LDBL_MANT_DIG__ != @as(c_int, 113));
pub const __HAVE_FLOATN_NOT_TYPEDEF = @as(c_int, 1);
pub const __f32 = @compileError("unable to translate macro: undefined identifier `f32`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/floatn-common.h:93:12
pub const __f64 = @compileError("unable to translate macro: undefined identifier `f64`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/floatn-common.h:105:12
pub const __f32x = @compileError("unable to translate macro: undefined identifier `f32x`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/floatn-common.h:113:12
pub const __f64x = @compileError("unable to translate macro: undefined identifier `f64x`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/floatn-common.h:125:12
pub const __CFLOAT32 = @compileError("unable to translate: invalid numeric type");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/floatn-common.h:151:12
pub const __CFLOAT64 = @compileError("unable to translate: invalid numeric type");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/floatn-common.h:163:12
pub const __CFLOAT32X = @compileError("unable to translate: invalid numeric type");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/floatn-common.h:171:12
pub const __CFLOAT64X = @compileError("unable to translate: invalid numeric type");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/floatn-common.h:183:12
pub const __ldiv_t_defined = @as(c_int, 1);
pub const __lldiv_t_defined = @as(c_int, 1);
pub const RAND_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const EXIT_FAILURE = @as(c_int, 1);
pub const EXIT_SUCCESS = @as(c_int, 0);
pub const MB_CUR_MAX = __ctype_get_mb_cur_max();
pub const _SYS_TYPES_H = @as(c_int, 1);
pub const _BITS_TYPES_H = @as(c_int, 1);
pub const __S16_TYPE = c_short;
pub const __U16_TYPE = c_ushort;
pub const __S32_TYPE = c_int;
pub const __U32_TYPE = c_uint;
pub const __SLONGWORD_TYPE = c_long;
pub const __ULONGWORD_TYPE = c_ulong;
pub const __SQUAD_TYPE = c_long;
pub const __UQUAD_TYPE = c_ulong;
pub const __SWORD_TYPE = c_long;
pub const __UWORD_TYPE = c_ulong;
pub const __SLONG32_TYPE = c_int;
pub const __ULONG32_TYPE = c_uint;
pub const __S64_TYPE = c_long;
pub const __U64_TYPE = c_ulong;
pub const _BITS_TYPESIZES_H = @as(c_int, 1);
pub const __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;
pub const __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;
pub const __DEV_T_TYPE = __UQUAD_TYPE;
pub const __UID_T_TYPE = __U32_TYPE;
pub const __GID_T_TYPE = __U32_TYPE;
pub const __INO_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __INO64_T_TYPE = __UQUAD_TYPE;
pub const __MODE_T_TYPE = __U32_TYPE;
pub const __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF64_T_TYPE = __SQUAD_TYPE;
pub const __PID_T_TYPE = __S32_TYPE;
pub const __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __RLIM64_T_TYPE = __UQUAD_TYPE;
pub const __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __BLKCNT64_T_TYPE = __SQUAD_TYPE;
pub const __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;
pub const __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSFILCNT64_T_TYPE = __UQUAD_TYPE;
pub const __ID_T_TYPE = __U32_TYPE;
pub const __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __USECONDS_T_TYPE = __U32_TYPE;
pub const __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __SUSECONDS64_T_TYPE = __SQUAD_TYPE;
pub const __DADDR_T_TYPE = __S32_TYPE;
pub const __KEY_T_TYPE = __S32_TYPE;
pub const __CLOCKID_T_TYPE = __S32_TYPE;
pub const __TIMER_T_TYPE = ?*anyopaque;
pub const __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __FSID_T_TYPE = @compileError("unable to translate macro: undefined identifier `__val`");
// /home/beans/.zig-versions/nightly/lib/libc/include/x86-linux-gnu/bits/typesizes.h:73:9
pub const __SSIZE_T_TYPE = __SWORD_TYPE;
pub const __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;
pub const __OFF_T_MATCHES_OFF64_T = @as(c_int, 1);
pub const __INO_T_MATCHES_INO64_T = @as(c_int, 1);
pub const __RLIM_T_MATCHES_RLIM64_T = @as(c_int, 1);
pub const __STATFS_MATCHES_STATFS64 = @as(c_int, 1);
pub const __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = @as(c_int, 1);
pub const __FD_SETSIZE = @as(c_int, 1024);
pub const _BITS_TIME64_H = @as(c_int, 1);
pub const __TIME64_T_TYPE = __TIME_T_TYPE;
pub const __u_char_defined = "";
pub const __ino_t_defined = "";
pub const __dev_t_defined = "";
pub const __gid_t_defined = "";
pub const __mode_t_defined = "";
pub const __nlink_t_defined = "";
pub const __uid_t_defined = "";
pub const __off_t_defined = "";
pub const __pid_t_defined = "";
pub const __id_t_defined = "";
pub const __ssize_t_defined = "";
pub const __daddr_t_defined = "";
pub const __key_t_defined = "";
pub const __clock_t_defined = @as(c_int, 1);
pub const __clockid_t_defined = @as(c_int, 1);
pub const __time_t_defined = @as(c_int, 1);
pub const __timer_t_defined = @as(c_int, 1);
pub const _BITS_STDINT_INTN_H = @as(c_int, 1);
pub const __BIT_TYPES_DEFINED__ = @as(c_int, 1);
pub const __CLANG_ENDIAN_H = "";
pub const _ENDIAN_H = @as(c_int, 1);
pub const _BITS_ENDIAN_H = @as(c_int, 1);
pub const __LITTLE_ENDIAN = @as(c_int, 1234);
pub const __BIG_ENDIAN = @as(c_int, 4321);
pub const __PDP_ENDIAN = @as(c_int, 3412);
pub const _BITS_ENDIANNESS_H = @as(c_int, 1);
pub const __BYTE_ORDER = __LITTLE_ENDIAN;
pub const __FLOAT_WORD_ORDER = __BYTE_ORDER;
pub inline fn __LONG_LONG_PAIR(HI: anytype, LO: anytype) @TypeOf(HI) {
    _ = &HI;
    _ = &LO;
    return blk: {
        _ = &LO;
        break :blk HI;
    };
}
pub const LITTLE_ENDIAN = __LITTLE_ENDIAN;
pub const BIG_ENDIAN = __BIG_ENDIAN;
pub const PDP_ENDIAN = __PDP_ENDIAN;
pub const BYTE_ORDER = __BYTE_ORDER;
pub const _BITS_BYTESWAP_H = @as(c_int, 1);
pub inline fn __bswap_constant_16(x: anytype) __uint16_t {
    _ = &x;
    return __helpers.cast(__uint16_t, ((x >> @as(c_int, 8)) & @as(c_int, 0xff)) | ((x & @as(c_int, 0xff)) << @as(c_int, 8)));
}
pub inline fn __bswap_constant_32(x: anytype) @TypeOf(((((x & __helpers.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & __helpers.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24))) {
    _ = &x;
    return ((((x & __helpers.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & __helpers.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24));
}
pub inline fn __bswap_constant_64(x: anytype) @TypeOf(((((((((x & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((x & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56))) {
    _ = &x;
    return ((((((((x & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((x & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56));
}
pub const _BITS_UINTN_IDENTITY_H = @as(c_int, 1);
pub inline fn htobe16(x: anytype) @TypeOf(__bswap_16(x)) {
    _ = &x;
    return __bswap_16(x);
}
pub inline fn htole16(x: anytype) @TypeOf(__uint16_identity(x)) {
    _ = &x;
    return __uint16_identity(x);
}
pub inline fn be16toh(x: anytype) @TypeOf(__bswap_16(x)) {
    _ = &x;
    return __bswap_16(x);
}
pub inline fn le16toh(x: anytype) @TypeOf(__uint16_identity(x)) {
    _ = &x;
    return __uint16_identity(x);
}
pub inline fn htobe32(x: anytype) @TypeOf(__bswap_32(x)) {
    _ = &x;
    return __bswap_32(x);
}
pub inline fn htole32(x: anytype) @TypeOf(__uint32_identity(x)) {
    _ = &x;
    return __uint32_identity(x);
}
pub inline fn be32toh(x: anytype) @TypeOf(__bswap_32(x)) {
    _ = &x;
    return __bswap_32(x);
}
pub inline fn le32toh(x: anytype) @TypeOf(__uint32_identity(x)) {
    _ = &x;
    return __uint32_identity(x);
}
pub inline fn htobe64(x: anytype) @TypeOf(__bswap_64(x)) {
    _ = &x;
    return __bswap_64(x);
}
pub inline fn htole64(x: anytype) @TypeOf(__uint64_identity(x)) {
    _ = &x;
    return __uint64_identity(x);
}
pub inline fn be64toh(x: anytype) @TypeOf(__bswap_64(x)) {
    _ = &x;
    return __bswap_64(x);
}
pub inline fn le64toh(x: anytype) @TypeOf(__uint64_identity(x)) {
    _ = &x;
    return __uint64_identity(x);
}
pub const _SYS_SELECT_H = @as(c_int, 1);
pub const __FD_ZERO = @compileError("unable to translate macro: undefined identifier `__i`");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/select.h:25:9
pub const __FD_SET = @compileError("unable to translate C expr: expected ')' instead got '|='");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/select.h:32:9
pub const __FD_CLR = @compileError("unable to translate C expr: expected ')' instead got '&='");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/select.h:34:9
pub inline fn __FD_ISSET(d: anytype, s: anytype) @TypeOf((__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0)) {
    _ = &d;
    _ = &s;
    return (__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0);
}
pub const __sigset_t_defined = @as(c_int, 1);
pub const ____sigset_t_defined = "";
pub const _SIGSET_NWORDS = __helpers.div(@as(c_int, 1024), @as(c_int, 8) * __helpers.sizeof(c_ulong));
pub const __timeval_defined = @as(c_int, 1);
pub const _STRUCT_TIMESPEC = @as(c_int, 1);
pub const __suseconds_t_defined = "";
pub const __NFDBITS = @as(c_int, 8) * __helpers.cast(c_int, __helpers.sizeof(__fd_mask));
pub inline fn __FD_ELT(d: anytype) @TypeOf(__helpers.div(d, __NFDBITS)) {
    _ = &d;
    return __helpers.div(d, __NFDBITS);
}
pub inline fn __FD_MASK(d: anytype) __fd_mask {
    _ = &d;
    return __helpers.cast(__fd_mask, @as(c_ulong, 1) << __helpers.rem(d, __NFDBITS));
}
pub inline fn __FDS_BITS(set: anytype) @TypeOf(set.*.__fds_bits) {
    _ = &set;
    return set.*.__fds_bits;
}
pub const FD_SETSIZE = __FD_SETSIZE;
pub const NFDBITS = __NFDBITS;
pub inline fn FD_SET(fd: anytype, fdsetp: anytype) @TypeOf(__FD_SET(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_SET(fd, fdsetp);
}
pub inline fn FD_CLR(fd: anytype, fdsetp: anytype) @TypeOf(__FD_CLR(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_CLR(fd, fdsetp);
}
pub inline fn FD_ISSET(fd: anytype, fdsetp: anytype) @TypeOf(__FD_ISSET(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_ISSET(fd, fdsetp);
}
pub inline fn FD_ZERO(fdsetp: anytype) @TypeOf(__FD_ZERO(fdsetp)) {
    _ = &fdsetp;
    return __FD_ZERO(fdsetp);
}
pub const __blksize_t_defined = "";
pub const __blkcnt_t_defined = "";
pub const __fsblkcnt_t_defined = "";
pub const __fsfilcnt_t_defined = "";
pub const _BITS_PTHREADTYPES_COMMON_H = @as(c_int, 1);
pub const _THREAD_SHARED_TYPES_H = @as(c_int, 1);
pub const _BITS_PTHREADTYPES_ARCH_H = @as(c_int, 1);
pub const __SIZEOF_PTHREAD_MUTEX_T = @as(c_int, 40);
pub const __SIZEOF_PTHREAD_ATTR_T = @as(c_int, 56);
pub const __SIZEOF_PTHREAD_RWLOCK_T = @as(c_int, 56);
pub const __SIZEOF_PTHREAD_BARRIER_T = @as(c_int, 32);
pub const __SIZEOF_PTHREAD_MUTEXATTR_T = @as(c_int, 4);
pub const __SIZEOF_PTHREAD_COND_T = @as(c_int, 48);
pub const __SIZEOF_PTHREAD_CONDATTR_T = @as(c_int, 4);
pub const __SIZEOF_PTHREAD_RWLOCKATTR_T = @as(c_int, 8);
pub const __SIZEOF_PTHREAD_BARRIERATTR_T = @as(c_int, 4);
pub const __LOCK_ALIGNMENT = "";
pub const __ONCE_ALIGNMENT = "";
pub const _BITS_ATOMIC_WIDE_COUNTER_H = "";
pub const _THREAD_MUTEX_INTERNAL_H = @as(c_int, 1);
pub const __PTHREAD_MUTEX_HAVE_PREV = @as(c_int, 1);
pub const __PTHREAD_MUTEX_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /home/beans/.zig-versions/nightly/lib/libc/include/x86-linux-gnu/bits/struct_mutex.h:55:10
pub const _RWLOCK_INTERNAL_H = "";
pub inline fn __PTHREAD_RWLOCK_INITIALIZER(__flags: anytype) @TypeOf(__flags) {
    _ = &__flags;
    return blk: {
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        break :blk __flags;
    };
}
pub const __ONCE_FLAG_INIT = @compileError("unable to translate C expr: unexpected token '{'");
// /home/beans/.zig-versions/nightly/lib/libc/include/generic-glibc/bits/thread-shared-types.h:114:9
pub const __have_pthread_attr_t = @as(c_int, 1);
pub const _ALLOCA_H = @as(c_int, 1);
pub const __COMPAR_FN_T = "";
pub const __CLANG_STDINT_H = "";
pub const _STDINT_H = @as(c_int, 1);
pub const __GLIBC_USE_LIB_EXT2 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT_C23 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT_C23 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_TYPES_EXT = @as(c_int, 0);
pub const _BITS_WCHAR_H = @as(c_int, 1);
pub const __WCHAR_MAX = __WCHAR_MAX__;
pub const __WCHAR_MIN = -__WCHAR_MAX - @as(c_int, 1);
pub const _BITS_STDINT_UINTN_H = @as(c_int, 1);
pub const _BITS_STDINT_LEAST_H = @as(c_int, 1);
pub const __intptr_t_defined = "";
pub const __INT64_C = __helpers.L_SUFFIX;
pub const __UINT64_C = __helpers.UL_SUFFIX;
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_LEAST8_MIN = -@as(c_int, 128);
pub const INT_LEAST16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT_LEAST32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT_LEAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_LEAST8_MAX = @as(c_int, 127);
pub const INT_LEAST16_MAX = @as(c_int, 32767);
pub const INT_LEAST32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT_LEAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_LEAST8_MAX = @as(c_int, 255);
pub const UINT_LEAST16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_FAST8_MIN = -@as(c_int, 128);
pub const INT_FAST16_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST32_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_FAST8_MAX = @as(c_int, 127);
pub const INT_FAST16_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST32_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_FAST8_MAX = @as(c_int, 255);
pub const UINT_FAST16_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST32_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTPTR_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INTPTR_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const UINTPTR_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INTMAX_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const PTRDIFF_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const PTRDIFF_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const SIG_ATOMIC_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const SIG_ATOMIC_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SIZE_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const WCHAR_MIN = __WCHAR_MIN;
pub const WCHAR_MAX = __WCHAR_MAX;
pub const WINT_MIN = @as(c_uint, 0);
pub const WINT_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub inline fn INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const INT64_C = __helpers.L_SUFFIX;
pub inline fn UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const UINT32_C = __helpers.U_SUFFIX;
pub const UINT64_C = __helpers.UL_SUFFIX;
pub const INTMAX_C = __helpers.L_SUFFIX;
pub const UINTMAX_C = __helpers.UL_SUFFIX;
pub inline fn __CUDA_API_PTDS(api: anytype) @TypeOf(api) {
    _ = &api;
    return api;
}
pub inline fn __CUDA_API_PTSZ(api: anytype) @TypeOf(api) {
    _ = &api;
    return api;
}
pub const cuDeviceTotalMem = cuDeviceTotalMem_v2;
pub const cuCtxCreate = cuCtxCreate_v4;
pub const cuModuleGetGlobal = cuModuleGetGlobal_v2;
pub const cuMemGetInfo = cuMemGetInfo_v2;
pub const cuMemAlloc = cuMemAlloc_v2;
pub const cuMemAllocPitch = cuMemAllocPitch_v2;
pub const cuMemFree = cuMemFree_v2;
pub const cuMemGetAddressRange = cuMemGetAddressRange_v2;
pub const cuMemAllocHost = cuMemAllocHost_v2;
pub const cuMemHostGetDevicePointer = cuMemHostGetDevicePointer_v2;
pub const cuMemAdvise = cuMemAdvise_v2;
pub const cuMemPrefetchAsync = __CUDA_API_PTSZ(cuMemPrefetchAsync_v2);
pub const cuMemcpyHtoD = __CUDA_API_PTDS(cuMemcpyHtoD_v2);
pub const cuMemcpyDtoH = __CUDA_API_PTDS(cuMemcpyDtoH_v2);
pub const cuMemcpyDtoD = __CUDA_API_PTDS(cuMemcpyDtoD_v2);
pub const cuMemcpyDtoA = __CUDA_API_PTDS(cuMemcpyDtoA_v2);
pub const cuMemcpyAtoD = __CUDA_API_PTDS(cuMemcpyAtoD_v2);
pub const cuMemcpyHtoA = __CUDA_API_PTDS(cuMemcpyHtoA_v2);
pub const cuMemcpyAtoH = __CUDA_API_PTDS(cuMemcpyAtoH_v2);
pub const cuMemcpyAtoA = __CUDA_API_PTDS(cuMemcpyAtoA_v2);
pub const cuMemcpyHtoAAsync = __CUDA_API_PTSZ(cuMemcpyHtoAAsync_v2);
pub const cuMemcpyAtoHAsync = __CUDA_API_PTSZ(cuMemcpyAtoHAsync_v2);
pub const cuMemcpy2D = __CUDA_API_PTDS(cuMemcpy2D_v2);
pub const cuMemcpy2DUnaligned = __CUDA_API_PTDS(cuMemcpy2DUnaligned_v2);
pub const cuMemcpy3D = __CUDA_API_PTDS(cuMemcpy3D_v2);
pub const cuMemcpyHtoDAsync = __CUDA_API_PTSZ(cuMemcpyHtoDAsync_v2);
pub const cuMemcpyDtoHAsync = __CUDA_API_PTSZ(cuMemcpyDtoHAsync_v2);
pub const cuMemcpyDtoDAsync = __CUDA_API_PTSZ(cuMemcpyDtoDAsync_v2);
pub const cuMemcpy2DAsync = __CUDA_API_PTSZ(cuMemcpy2DAsync_v2);
pub const cuMemcpy3DAsync = __CUDA_API_PTSZ(cuMemcpy3DAsync_v2);
pub const cuMemcpyBatchAsync = __CUDA_API_PTSZ(cuMemcpyBatchAsync_v2);
pub const cuMemcpy3DBatchAsync = __CUDA_API_PTSZ(cuMemcpy3DBatchAsync_v2);
pub const cuMemsetD8 = __CUDA_API_PTDS(cuMemsetD8_v2);
pub const cuMemsetD16 = __CUDA_API_PTDS(cuMemsetD16_v2);
pub const cuMemsetD32 = __CUDA_API_PTDS(cuMemsetD32_v2);
pub const cuMemsetD2D8 = __CUDA_API_PTDS(cuMemsetD2D8_v2);
pub const cuMemsetD2D16 = __CUDA_API_PTDS(cuMemsetD2D16_v2);
pub const cuMemsetD2D32 = __CUDA_API_PTDS(cuMemsetD2D32_v2);
pub const cuArrayCreate = cuArrayCreate_v2;
pub const cuArrayGetDescriptor = cuArrayGetDescriptor_v2;
pub const cuArray3DCreate = cuArray3DCreate_v2;
pub const cuArray3DGetDescriptor = cuArray3DGetDescriptor_v2;
pub const cuTexRefSetAddress = cuTexRefSetAddress_v2;
pub const cuTexRefGetAddress = cuTexRefGetAddress_v2;
pub const cuGraphicsResourceGetMappedPointer = cuGraphicsResourceGetMappedPointer_v2;
pub const cuCtxDestroy = cuCtxDestroy_v2;
pub const cuCtxPopCurrent = cuCtxPopCurrent_v2;
pub const cuCtxPushCurrent = cuCtxPushCurrent_v2;
pub const cuStreamDestroy = cuStreamDestroy_v2;
pub const cuEventDestroy = cuEventDestroy_v2;
pub const cuTexRefSetAddress2D = cuTexRefSetAddress2D_v3;
pub const cuLinkCreate = cuLinkCreate_v2;
pub const cuLinkAddData = cuLinkAddData_v2;
pub const cuLinkAddFile = cuLinkAddFile_v2;
pub const cuMemHostRegister = cuMemHostRegister_v2;
pub const cuGraphicsResourceSetMapFlags = cuGraphicsResourceSetMapFlags_v2;
pub const cuStreamBeginCapture = __CUDA_API_PTSZ(cuStreamBeginCapture_v2);
pub const cuDevicePrimaryCtxRelease = cuDevicePrimaryCtxRelease_v2;
pub const cuDevicePrimaryCtxReset = cuDevicePrimaryCtxReset_v2;
pub const cuDevicePrimaryCtxSetFlags = cuDevicePrimaryCtxSetFlags_v2;
pub const cuDeviceGetUuid = cuDeviceGetUuid_v2;
pub const cuIpcOpenMemHandle = cuIpcOpenMemHandle_v2;
pub const cuGraphInstantiate = cuGraphInstantiateWithFlags;
pub const cuGraphExecUpdate = cuGraphExecUpdate_v2;
pub const cuGetProcAddress = cuGetProcAddress_v2;
pub const cuGraphAddKernelNode = cuGraphAddKernelNode_v2;
pub const cuGraphKernelNodeGetParams = cuGraphKernelNodeGetParams_v2;
pub const cuGraphKernelNodeSetParams = cuGraphKernelNodeSetParams_v2;
pub const cuGraphExecKernelNodeSetParams = cuGraphExecKernelNodeSetParams_v2;
pub const cuGraphGetEdges = cuGraphGetEdges_v2;
pub const cuGraphNodeGetDependencies = cuGraphNodeGetDependencies_v2;
pub const cuGraphNodeGetDependentNodes = cuGraphNodeGetDependentNodes_v2;
pub const cuGraphAddDependencies = cuGraphAddDependencies_v2;
pub const cuGraphRemoveDependencies = cuGraphRemoveDependencies_v2;
pub const cuGraphAddNode = cuGraphAddNode_v2;
pub const cuEventElapsedTime = cuEventElapsedTime_v2;
pub const cuStreamWriteValue32 = __CUDA_API_PTSZ(cuStreamWriteValue32_v2);
pub const cuStreamWaitValue32 = __CUDA_API_PTSZ(cuStreamWaitValue32_v2);
pub const cuStreamWriteValue64 = __CUDA_API_PTSZ(cuStreamWriteValue64_v2);
pub const cuStreamWaitValue64 = __CUDA_API_PTSZ(cuStreamWaitValue64_v2);
pub const cuStreamBatchMemOp = __CUDA_API_PTSZ(cuStreamBatchMemOp_v2);
pub const cuStreamGetCaptureInfo = __CUDA_API_PTSZ(cuStreamGetCaptureInfo_v3);
pub const cuStreamUpdateCaptureDependencies = __CUDA_API_PTSZ(cuStreamUpdateCaptureDependencies_v2);
pub const CUDA_VERSION = @as(c_int, 13040);
pub const CU_UUID_HAS_BEEN_DEFINED = "";
pub const CU_IPC_HANDLE_SIZE = @as(c_int, 64);
pub const CU_STREAM_LEGACY = __helpers.cast(CUstream, @as(c_int, 0x1));
pub const CU_STREAM_PER_THREAD = __helpers.cast(CUstream, @as(c_int, 0x2));
pub const CU_COMPUTE_ACCELERATED_TARGET_BASE = __helpers.promoteIntLiteral(c_int, 0x10000, .hex);
pub const CU_COMPUTE_FAMILY_TARGET_BASE = __helpers.promoteIntLiteral(c_int, 0x20000, .hex);
pub const CUDA_CB = "";
pub const CU_GRAPH_COND_ASSIGN_DEFAULT = @as(c_int, 0x1);
pub const CU_GRAPH_KERNEL_NODE_PORT_DEFAULT = @as(c_int, 0);
pub const CU_GRAPH_KERNEL_NODE_PORT_PROGRAMMATIC = @as(c_int, 1);
pub const CU_GRAPH_KERNEL_NODE_PORT_LAUNCH_ORDER = @as(c_int, 2);
pub const CU_KERNEL_NODE_ATTRIBUTE_ACCESS_POLICY_WINDOW = CU_LAUNCH_ATTRIBUTE_ACCESS_POLICY_WINDOW;
pub const CU_KERNEL_NODE_ATTRIBUTE_COOPERATIVE = CU_LAUNCH_ATTRIBUTE_COOPERATIVE;
pub const CU_KERNEL_NODE_ATTRIBUTE_CLUSTER_DIMENSION = CU_LAUNCH_ATTRIBUTE_CLUSTER_DIMENSION;
pub const CU_KERNEL_NODE_ATTRIBUTE_CLUSTER_SCHEDULING_POLICY_PREFERENCE = CU_LAUNCH_ATTRIBUTE_CLUSTER_SCHEDULING_POLICY_PREFERENCE;
pub const CU_KERNEL_NODE_ATTRIBUTE_PRIORITY = CU_LAUNCH_ATTRIBUTE_PRIORITY;
pub const CU_KERNEL_NODE_ATTRIBUTE_MEM_SYNC_DOMAIN_MAP = CU_LAUNCH_ATTRIBUTE_MEM_SYNC_DOMAIN_MAP;
pub const CU_KERNEL_NODE_ATTRIBUTE_MEM_SYNC_DOMAIN = CU_LAUNCH_ATTRIBUTE_MEM_SYNC_DOMAIN;
pub const CU_KERNEL_NODE_ATTRIBUTE_PREFERRED_CLUSTER_DIMENSION = CU_LAUNCH_ATTRIBUTE_PREFERRED_CLUSTER_DIMENSION;
pub const CU_KERNEL_NODE_ATTRIBUTE_DEVICE_UPDATABLE_KERNEL_NODE = CU_LAUNCH_ATTRIBUTE_DEVICE_UPDATABLE_KERNEL_NODE;
pub const CU_KERNEL_NODE_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT = CU_LAUNCH_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT;
pub const CU_STREAM_ATTRIBUTE_ACCESS_POLICY_WINDOW = CU_LAUNCH_ATTRIBUTE_ACCESS_POLICY_WINDOW;
pub const CU_STREAM_ATTRIBUTE_SYNCHRONIZATION_POLICY = CU_LAUNCH_ATTRIBUTE_SYNCHRONIZATION_POLICY;
pub const CU_STREAM_ATTRIBUTE_PRIORITY = CU_LAUNCH_ATTRIBUTE_PRIORITY;
pub const CU_STREAM_ATTRIBUTE_MEM_SYNC_DOMAIN_MAP = CU_LAUNCH_ATTRIBUTE_MEM_SYNC_DOMAIN_MAP;
pub const CU_STREAM_ATTRIBUTE_MEM_SYNC_DOMAIN = CU_LAUNCH_ATTRIBUTE_MEM_SYNC_DOMAIN;
pub const CU_MEMHOSTALLOC_PORTABLE = @as(c_int, 0x01);
pub const CU_MEMHOSTALLOC_DEVICEMAP = @as(c_int, 0x02);
pub const CU_MEMHOSTALLOC_WRITECOMBINED = @as(c_int, 0x04);
pub const CU_MEMHOSTREGISTER_PORTABLE = @as(c_int, 0x01);
pub const CU_MEMHOSTREGISTER_DEVICEMAP = @as(c_int, 0x02);
pub const CU_MEMHOSTREGISTER_IOMEMORY = @as(c_int, 0x04);
pub const CU_MEMHOSTREGISTER_READ_ONLY = @as(c_int, 0x08);
pub const CU_ARRAY_SPARSE_PROPERTIES_SINGLE_MIPTAIL = @as(c_int, 0x1);
pub const CU_TENSOR_MAP_NUM_QWORDS = @as(c_int, 16);
pub const CUDA_EXTERNAL_MEMORY_DEDICATED = @as(c_int, 0x1);
pub const CUDA_EXTERNAL_SEMAPHORE_SIGNAL_SKIP_NVSCIBUF_MEMSYNC = @as(c_int, 0x01);
pub const CUDA_EXTERNAL_SEMAPHORE_WAIT_SKIP_NVSCIBUF_MEMSYNC = @as(c_int, 0x02);
pub const CUDA_NVSCISYNC_ATTR_SIGNAL = @as(c_int, 0x1);
pub const CUDA_NVSCISYNC_ATTR_WAIT = @as(c_int, 0x2);
pub const CU_MEM_CREATE_USAGE_TILE_POOL = @as(c_int, 0x1);
pub const CU_MEM_CREATE_USAGE_HW_DECOMPRESS = @as(c_int, 0x2);
pub const CU_MEM_CREATE_USAGE_GPU_DIRECT_RDMA_OVER_PCIE = @as(c_int, 0x4);
pub const CU_MEM_POOL_CREATE_USAGE_HW_DECOMPRESS = @as(c_int, 0x2);
pub const CUDA_COOPERATIVE_LAUNCH_MULTI_DEVICE_NO_PRE_LAUNCH_SYNC = @as(c_int, 0x01);
pub const CUDA_COOPERATIVE_LAUNCH_MULTI_DEVICE_NO_POST_LAUNCH_SYNC = @as(c_int, 0x02);
pub const CUDA_ARRAY3D_LAYERED = @as(c_int, 0x01);
pub const CUDA_ARRAY3D_2DARRAY = @as(c_int, 0x01);
pub const CUDA_ARRAY3D_SURFACE_LDST = @as(c_int, 0x02);
pub const CUDA_ARRAY3D_CUBEMAP = @as(c_int, 0x04);
pub const CUDA_ARRAY3D_TEXTURE_GATHER = @as(c_int, 0x08);
pub const CUDA_ARRAY3D_DEPTH_TEXTURE = @as(c_int, 0x10);
pub const CUDA_ARRAY3D_COLOR_ATTACHMENT = @as(c_int, 0x20);
pub const CUDA_ARRAY3D_SPARSE = @as(c_int, 0x40);
pub const CUDA_ARRAY3D_DEFERRED_MAPPING = @as(c_int, 0x80);
pub const CUDA_ARRAY3D_VIDEO_ENCODE_DECODE = @as(c_int, 0x100);
pub const CU_TRSA_OVERRIDE_FORMAT = @as(c_int, 0x01);
pub const CU_TRSF_READ_AS_INTEGER = @as(c_int, 0x01);
pub const CU_TRSF_NORMALIZED_COORDINATES = @as(c_int, 0x02);
pub const CU_TRSF_SRGB = @as(c_int, 0x10);
pub const CU_TRSF_DISABLE_TRILINEAR_OPTIMIZATION = @as(c_int, 0x20);
pub const CU_TRSF_SEAMLESS_CUBEMAP = @as(c_int, 0x40);
pub const CU_LAUNCH_KERNEL_REQUIRED_BLOCK_DIM = @as(c_int, 1);
pub const CU_LAUNCH_PARAM_END_AS_INT = @as(c_int, 0x00);
pub const CU_LAUNCH_PARAM_END = __helpers.cast(?*anyopaque, CU_LAUNCH_PARAM_END_AS_INT);
pub const CU_LAUNCH_PARAM_BUFFER_POINTER_AS_INT = @as(c_int, 0x01);
pub const CU_LAUNCH_PARAM_BUFFER_POINTER = __helpers.cast(?*anyopaque, CU_LAUNCH_PARAM_BUFFER_POINTER_AS_INT);
pub const CU_LAUNCH_PARAM_BUFFER_SIZE_AS_INT = @as(c_int, 0x02);
pub const CU_LAUNCH_PARAM_BUFFER_SIZE = __helpers.cast(?*anyopaque, CU_LAUNCH_PARAM_BUFFER_SIZE_AS_INT);
pub const CU_PARAM_TR_DEFAULT = -@as(c_int, 1);
pub const CU_DEVICE_CPU = __helpers.cast(CUdevice, -@as(c_int, 1));
pub const CU_DEVICE_INVALID = __helpers.cast(CUdevice, -@as(c_int, 2));
pub const CUDAAPI = "";
pub const timeval = struct_timeval;
pub const timespec = struct_timespec;
pub const __pthread_internal_list = struct___pthread_internal_list;
pub const __pthread_internal_slist = struct___pthread_internal_slist;
pub const __pthread_mutex_s = struct___pthread_mutex_s;
pub const __pthread_rwlock_arch_t = struct___pthread_rwlock_arch_t;
pub const __pthread_cond_s = struct___pthread_cond_s;
pub const random_data = struct_random_data;
pub const drand48_data = struct_drand48_data;
pub const CUctx_st = struct_CUctx_st;
pub const CUmod_st = struct_CUmod_st;
pub const CUfunc_st = struct_CUfunc_st;
pub const CUlib_st = struct_CUlib_st;
pub const CUkern_st = struct_CUkern_st;
pub const CUarray_st = struct_CUarray_st;
pub const CUmipmappedArray_st = struct_CUmipmappedArray_st;
pub const CUtexref_st = struct_CUtexref_st;
pub const CUsurfref_st = struct_CUsurfref_st;
pub const CUevent_st = struct_CUevent_st;
pub const CUstream_st = struct_CUstream_st;
pub const CUgraphicsResource_st = struct_CUgraphicsResource_st;
pub const CUextMemory_st = struct_CUextMemory_st;
pub const CUextSemaphore_st = struct_CUextSemaphore_st;
pub const CUgraph_st = struct_CUgraph_st;
pub const CUgraphNode_st = struct_CUgraphNode_st;
pub const CUgraphExec_st = struct_CUgraphExec_st;
pub const CUmemPoolHandle_st = struct_CUmemPoolHandle_st;
pub const CUuserObject_st = struct_CUuserObject_st;
pub const CUgraphDeviceUpdatableNode_st = struct_CUgraphDeviceUpdatableNode_st;
pub const CUasyncCallbackEntry_st = struct_CUasyncCallbackEntry_st;
pub const CUgreenCtx_st = struct_CUgreenCtx_st;
pub const CUuuid_st = struct_CUuuid_st;
pub const CUmemFabricHandle_st = struct_CUmemFabricHandle_st;
pub const CUipcEventHandle_st = struct_CUipcEventHandle_st;
pub const CUipcMemHandle_st = struct_CUipcMemHandle_st;
pub const CUipcMem_flags_enum = enum_CUipcMem_flags_enum;
pub const CUmemAttach_flags_enum = enum_CUmemAttach_flags_enum;
pub const CUctx_flags_enum = enum_CUctx_flags_enum;
pub const CUevent_sched_flags_enum = enum_CUevent_sched_flags_enum;
pub const cl_event_flags_enum = enum_cl_event_flags_enum;
pub const cl_context_flags_enum = enum_cl_context_flags_enum;
pub const CUhostTaskSyncMode_enum = enum_CUhostTaskSyncMode_enum;
pub const CUstream_flags_enum = enum_CUstream_flags_enum;
pub const CUevent_flags_enum = enum_CUevent_flags_enum;
pub const CUevent_record_flags_enum = enum_CUevent_record_flags_enum;
pub const CUevent_wait_flags_enum = enum_CUevent_wait_flags_enum;
pub const CUatomicOperation_enum = enum_CUatomicOperation_enum;
pub const CUatomicOperationCapability_enum = enum_CUatomicOperationCapability_enum;
pub const CUstreamWaitValue_flags_enum = enum_CUstreamWaitValue_flags_enum;
pub const CUstreamWriteValue_flags_enum = enum_CUstreamWriteValue_flags_enum;
pub const CUstreamBatchMemOpType_enum = enum_CUstreamBatchMemOpType_enum;
pub const CUstreamMemoryBarrier_flags_enum = enum_CUstreamMemoryBarrier_flags_enum;
pub const CUstreamAtomicReductionOpType_enum = enum_CUstreamAtomicReductionOpType_enum;
pub const CUstreamAtomicReductionDataType_enum = enum_CUstreamAtomicReductionDataType_enum;
pub const CUstreamBatchMemOpParams_union = union_CUstreamBatchMemOpParams_union;
pub const CUDA_BATCH_MEM_OP_NODE_PARAMS_v1_st = struct_CUDA_BATCH_MEM_OP_NODE_PARAMS_v1_st;
pub const CUDA_BATCH_MEM_OP_NODE_PARAMS_v2_st = struct_CUDA_BATCH_MEM_OP_NODE_PARAMS_v2_st;
pub const CUoccupancy_flags_enum = enum_CUoccupancy_flags_enum;
pub const CUstreamUpdateCaptureDependencies_flags_enum = enum_CUstreamUpdateCaptureDependencies_flags_enum;
pub const CUasyncNotificationType_enum = enum_CUasyncNotificationType_enum;
pub const CUasyncNotificationInfo_st = struct_CUasyncNotificationInfo_st;
pub const CUarray_format_enum = enum_CUarray_format_enum;
pub const CUaddress_mode_enum = enum_CUaddress_mode_enum;
pub const CUfilter_mode_enum = enum_CUfilter_mode_enum;
pub const CUdevice_attribute_enum = enum_CUdevice_attribute_enum;
pub const CUdevprop_st = struct_CUdevprop_st;
pub const CUpointer_attribute_enum = enum_CUpointer_attribute_enum;
pub const CUfunction_attribute_enum = enum_CUfunction_attribute_enum;
pub const CUfunc_cache_enum = enum_CUfunc_cache_enum;
pub const CUsharedconfig_enum = enum_CUsharedconfig_enum;
pub const CUshared_carveout_enum = enum_CUshared_carveout_enum;
pub const CUmemorytype_enum = enum_CUmemorytype_enum;
pub const CUcomputemode_enum = enum_CUcomputemode_enum;
pub const CUmem_advise_enum = enum_CUmem_advise_enum;
pub const CUmem_range_attribute_enum = enum_CUmem_range_attribute_enum;
pub const CUjit_option_enum = enum_CUjit_option_enum;
pub const CUjit_target_enum = enum_CUjit_target_enum;
pub const CUjit_fallback_enum = enum_CUjit_fallback_enum;
pub const CUjit_cacheMode_enum = enum_CUjit_cacheMode_enum;
pub const CUjitInputType_enum = enum_CUjitInputType_enum;
pub const CUlinkState_st = struct_CUlinkState_st;
pub const CUgraphicsRegisterFlags_enum = enum_CUgraphicsRegisterFlags_enum;
pub const CUgraphicsMapResourceFlags_enum = enum_CUgraphicsMapResourceFlags_enum;
pub const CUarray_cubemap_face_enum = enum_CUarray_cubemap_face_enum;
pub const CUlimit_enum = enum_CUlimit_enum;
pub const CUresourcetype_enum = enum_CUresourcetype_enum;
pub const CUaccessProperty_enum = enum_CUaccessProperty_enum;
pub const CUaccessPolicyWindow_st = struct_CUaccessPolicyWindow_st;
pub const CUDA_KERNEL_NODE_PARAMS_st = struct_CUDA_KERNEL_NODE_PARAMS_st;
pub const CUDA_KERNEL_NODE_PARAMS_v2_st = struct_CUDA_KERNEL_NODE_PARAMS_v2_st;
pub const CUDA_KERNEL_NODE_PARAMS_v3_st = struct_CUDA_KERNEL_NODE_PARAMS_v3_st;
pub const CUDA_MEMSET_NODE_PARAMS_st = struct_CUDA_MEMSET_NODE_PARAMS_st;
pub const CUDA_MEMSET_NODE_PARAMS_v2_st = struct_CUDA_MEMSET_NODE_PARAMS_v2_st;
pub const CUDA_HOST_NODE_PARAMS_st = struct_CUDA_HOST_NODE_PARAMS_st;
pub const CUDA_HOST_NODE_PARAMS_v2_st = struct_CUDA_HOST_NODE_PARAMS_v2_st;
pub const CUgraphConditionalNodeType_enum = enum_CUgraphConditionalNodeType_enum;
pub const CUgraphNodeType_enum = enum_CUgraphNodeType_enum;
pub const CUgraphDependencyType_enum = enum_CUgraphDependencyType_enum;
pub const CUgraphEdgeData_st = struct_CUgraphEdgeData_st;
pub const CUgraphInstantiateResult_enum = enum_CUgraphInstantiateResult_enum;
pub const CUDA_GRAPH_INSTANTIATE_PARAMS_st = struct_CUDA_GRAPH_INSTANTIATE_PARAMS_st;
pub const CUsynchronizationPolicy_enum = enum_CUsynchronizationPolicy_enum;
pub const CUclusterSchedulingPolicy_enum = enum_CUclusterSchedulingPolicy_enum;
pub const CUlaunchMemSyncDomain_enum = enum_CUlaunchMemSyncDomain_enum;
pub const CUlaunchMemSyncDomainMap_st = struct_CUlaunchMemSyncDomainMap_st;
pub const CUlaunchAttributePortableClusterMode_enum = enum_CUlaunchAttributePortableClusterMode_enum;
pub const CUsharedMemoryMode_enum = enum_CUsharedMemoryMode_enum;
pub const CUlaunchAttributeID_enum = enum_CUlaunchAttributeID_enum;
pub const CUlaunchAttributeValue_union = union_CUlaunchAttributeValue_union;
pub const CUlaunchAttribute_st = struct_CUlaunchAttribute_st;
pub const CUlaunchConfig_st = struct_CUlaunchConfig_st;
pub const CUstreamCaptureStatus_enum = enum_CUstreamCaptureStatus_enum;
pub const CUstreamCaptureMode_enum = enum_CUstreamCaptureMode_enum;
pub const CUdriverProcAddress_flags_enum = enum_CUdriverProcAddress_flags_enum;
pub const CUdriverProcAddressQueryResult_enum = enum_CUdriverProcAddressQueryResult_enum;
pub const CUexecAffinityType_enum = enum_CUexecAffinityType_enum;
pub const CUexecAffinitySmCount_st = struct_CUexecAffinitySmCount_st;
pub const CUexecAffinityParam_st = struct_CUexecAffinityParam_st;
pub const CUcigDataType_enum = enum_CUcigDataType_enum;
pub const CUctxCigParam_st = struct_CUctxCigParam_st;
pub const CUctxCreateParams_st = struct_CUctxCreateParams_st;
pub const CUstreamCigDataType_enum = enum_CUstreamCigDataType_enum;
pub const CUstreamCigParam_st = struct_CUstreamCigParam_st;
pub const CUstreamCigCaptureParams_st = struct_CUstreamCigCaptureParams_st;
pub const CUlibraryOption_enum = enum_CUlibraryOption_enum;
pub const CUlibraryHostUniversalFunctionAndDataTable_st = struct_CUlibraryHostUniversalFunctionAndDataTable_st;
pub const cudaError_enum = enum_cudaError_enum;
pub const CUdevice_P2PAttribute_enum = enum_CUdevice_P2PAttribute_enum;
pub const CUDA_MEMCPY2D_st = struct_CUDA_MEMCPY2D_st;
pub const CUDA_MEMCPY3D_st = struct_CUDA_MEMCPY3D_st;
pub const CUDA_MEMCPY3D_PEER_st = struct_CUDA_MEMCPY3D_PEER_st;
pub const CUDA_MEMCPY_NODE_PARAMS_st = struct_CUDA_MEMCPY_NODE_PARAMS_st;
pub const CUDA_ARRAY_DESCRIPTOR_st = struct_CUDA_ARRAY_DESCRIPTOR_st;
pub const CUDA_ARRAY3D_DESCRIPTOR_st = struct_CUDA_ARRAY3D_DESCRIPTOR_st;
pub const CUDA_ARRAY_SPARSE_PROPERTIES_st = struct_CUDA_ARRAY_SPARSE_PROPERTIES_st;
pub const CUDA_ARRAY_MEMORY_REQUIREMENTS_st = struct_CUDA_ARRAY_MEMORY_REQUIREMENTS_st;
pub const CUDA_RESOURCE_DESC_st = struct_CUDA_RESOURCE_DESC_st;
pub const CUDA_TEXTURE_DESC_st = struct_CUDA_TEXTURE_DESC_st;
pub const CUresourceViewFormat_enum = enum_CUresourceViewFormat_enum;
pub const CUDA_RESOURCE_VIEW_DESC_st = struct_CUDA_RESOURCE_VIEW_DESC_st;
pub const CUtensorMap_st = struct_CUtensorMap_st;
pub const CUtensorMapDataType_enum = enum_CUtensorMapDataType_enum;
pub const CUtensorMapInterleave_enum = enum_CUtensorMapInterleave_enum;
pub const CUtensorMapSwizzle_enum = enum_CUtensorMapSwizzle_enum;
pub const CUtensorMapL2promotion_enum = enum_CUtensorMapL2promotion_enum;
pub const CUtensorMapFloatOOBfill_enum = enum_CUtensorMapFloatOOBfill_enum;
pub const CUtensorMapIm2ColWideMode_enum = enum_CUtensorMapIm2ColWideMode_enum;
pub const CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_st = struct_CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_st;
pub const CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS_enum = enum_CUDA_POINTER_ATTRIBUTE_ACCESS_FLAGS_enum;
pub const CUDA_LAUNCH_PARAMS_st = struct_CUDA_LAUNCH_PARAMS_st;
pub const CUexternalMemoryHandleType_enum = enum_CUexternalMemoryHandleType_enum;
pub const CUDA_EXTERNAL_MEMORY_HANDLE_DESC_st = struct_CUDA_EXTERNAL_MEMORY_HANDLE_DESC_st;
pub const CUDA_EXTERNAL_MEMORY_BUFFER_DESC_st = struct_CUDA_EXTERNAL_MEMORY_BUFFER_DESC_st;
pub const CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_st = struct_CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_st;
pub const CUexternalSemaphoreHandleType_enum = enum_CUexternalSemaphoreHandleType_enum;
pub const CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_st = struct_CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_st;
pub const CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_st = struct_CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_st;
pub const CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_st = struct_CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_st;
pub const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_st = struct_CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_st;
pub const CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v2_st = struct_CUDA_EXT_SEM_SIGNAL_NODE_PARAMS_v2_st;
pub const CUDA_EXT_SEM_WAIT_NODE_PARAMS_st = struct_CUDA_EXT_SEM_WAIT_NODE_PARAMS_st;
pub const CUDA_EXT_SEM_WAIT_NODE_PARAMS_v2_st = struct_CUDA_EXT_SEM_WAIT_NODE_PARAMS_v2_st;
pub const CUmemAllocationHandleType_enum = enum_CUmemAllocationHandleType_enum;
pub const CUmemAccess_flags_enum = enum_CUmemAccess_flags_enum;
pub const CUmemLocationType_enum = enum_CUmemLocationType_enum;
pub const CUmemAllocationType_enum = enum_CUmemAllocationType_enum;
pub const CUmemAllocationGranularity_flags_enum = enum_CUmemAllocationGranularity_flags_enum;
pub const CUmemRangeHandleType_enum = enum_CUmemRangeHandleType_enum;
pub const CUmemRangeFlags_enum = enum_CUmemRangeFlags_enum;
pub const CUarraySparseSubresourceType_enum = enum_CUarraySparseSubresourceType_enum;
pub const CUmemOperationType_enum = enum_CUmemOperationType_enum;
pub const CUmemHandleType_enum = enum_CUmemHandleType_enum;
pub const CUarrayMapInfo_st = struct_CUarrayMapInfo_st;
pub const CUmemLocation_st = struct_CUmemLocation_st;
pub const CUmemAllocationCompType_enum = enum_CUmemAllocationCompType_enum;
pub const CUmemAllocationProp_st = struct_CUmemAllocationProp_st;
pub const CUmulticastGranularity_flags_enum = enum_CUmulticastGranularity_flags_enum;
pub const CUmulticastObjectProp_st = struct_CUmulticastObjectProp_st;
pub const CUmemAccessDesc_st = struct_CUmemAccessDesc_st;
pub const CUgraphExecUpdateResult_enum = enum_CUgraphExecUpdateResult_enum;
pub const CUgraphExecUpdateResultInfo_st = struct_CUgraphExecUpdateResultInfo_st;
pub const CUmemPool_attribute_enum = enum_CUmemPool_attribute_enum;
pub const CUmemPoolProps_st = struct_CUmemPoolProps_st;
pub const CUmemPoolPtrExportData_st = struct_CUmemPoolPtrExportData_st;
pub const CUmemcpyFlags_enum = enum_CUmemcpyFlags_enum;
pub const CUmemcpySrcAccessOrder_enum = enum_CUmemcpySrcAccessOrder_enum;
pub const CUmemcpyAttributes_st = struct_CUmemcpyAttributes_st;
pub const CUmemcpy3DOperandType_enum = enum_CUmemcpy3DOperandType_enum;
pub const CUoffset3D_st = struct_CUoffset3D_st;
pub const CUextent3D_st = struct_CUextent3D_st;
pub const CUmemcpy3DOperand_st = struct_CUmemcpy3DOperand_st;
pub const CUDA_MEMCPY3D_BATCH_OP_st = struct_CUDA_MEMCPY3D_BATCH_OP_st;
pub const CUDA_MEM_ALLOC_NODE_PARAMS_v1_st = struct_CUDA_MEM_ALLOC_NODE_PARAMS_v1_st;
pub const CUDA_MEM_ALLOC_NODE_PARAMS_v2_st = struct_CUDA_MEM_ALLOC_NODE_PARAMS_v2_st;
pub const CUDA_MEM_FREE_NODE_PARAMS_st = struct_CUDA_MEM_FREE_NODE_PARAMS_st;
pub const CUgraphMem_attribute_enum = enum_CUgraphMem_attribute_enum;
pub const CUgraphChildGraphNodeOwnership_enum = enum_CUgraphChildGraphNodeOwnership_enum;
pub const CUDA_CHILD_GRAPH_NODE_PARAMS_st = struct_CUDA_CHILD_GRAPH_NODE_PARAMS_st;
pub const CUDA_EVENT_RECORD_NODE_PARAMS_st = struct_CUDA_EVENT_RECORD_NODE_PARAMS_st;
pub const CUDA_EVENT_WAIT_NODE_PARAMS_st = struct_CUDA_EVENT_WAIT_NODE_PARAMS_st;
pub const CUgraphNodeParams_st = struct_CUgraphNodeParams_st;
pub const CUflushGPUDirectRDMAWritesOptions_enum = enum_CUflushGPUDirectRDMAWritesOptions_enum;
pub const CUGPUDirectRDMAWritesOrdering_enum = enum_CUGPUDirectRDMAWritesOrdering_enum;
pub const CUflushGPUDirectRDMAWritesScope_enum = enum_CUflushGPUDirectRDMAWritesScope_enum;
pub const CUflushGPUDirectRDMAWritesTarget_enum = enum_CUflushGPUDirectRDMAWritesTarget_enum;
pub const CUgraphDebugDot_flags_enum = enum_CUgraphDebugDot_flags_enum;
pub const CUuserObject_flags_enum = enum_CUuserObject_flags_enum;
pub const CUuserObjectRetain_flags_enum = enum_CUuserObjectRetain_flags_enum;
pub const CUgraphInstantiate_flags_enum = enum_CUgraphInstantiate_flags_enum;
pub const CUdeviceNumaConfig_enum = enum_CUdeviceNumaConfig_enum;
pub const CUprocessState_enum = enum_CUprocessState_enum;
pub const CUcheckpointCustomStoragePerDeviceData_st = struct_CUcheckpointCustomStoragePerDeviceData_st;
pub const CUIcheckpointOperation_st = struct_CUIcheckpointOperation_st;
pub const CUcheckpointCustomStorageInfo_st = struct_CUcheckpointCustomStorageInfo_st;
pub const CUcheckpointLockArgs_st = struct_CUcheckpointLockArgs_st;
pub const CUcheckpointCheckpointArgs_st = struct_CUcheckpointCheckpointArgs_st;
pub const CUcheckpointGpuPair_st = struct_CUcheckpointGpuPair_st;
pub const CUcheckpointRestoreArgs_st = struct_CUcheckpointRestoreArgs_st;
pub const CUcheckpointUnlockArgs_st = struct_CUcheckpointUnlockArgs_st;
pub const CUmoduleLoadingMode_enum = enum_CUmoduleLoadingMode_enum;
pub const CUmemDecompressAlgorithm_enum = enum_CUmemDecompressAlgorithm_enum;
pub const CUmemDecompressParams_st = struct_CUmemDecompressParams_st;
pub const CUcliqueType_enum = enum_CUcliqueType_enum;
pub const CUcliqueInfo_st = struct_CUcliqueInfo_st;
pub const CUlogicalEndpointIpcHandleType_enum = enum_CUlogicalEndpointIpcHandleType_enum;
pub const CUlogicalEndpointFabricHandle_st = struct_CUlogicalEndpointFabricHandle_st;
pub const CUlogicalEndpointType_enum = enum_CUlogicalEndpointType_enum;
pub const CUlogicalEndpointFlag_enum = enum_CUlogicalEndpointFlag_enum;
pub const CUlogicalEndpointProp_struct = struct_CUlogicalEndpointProp_struct;
pub const CUgraphRecaptureStatus_enum = enum_CUgraphRecaptureStatus_enum;
pub const CUfunctionLoadingState_enum = enum_CUfunctionLoadingState_enum;
pub const CUcoredumpSettings_enum = enum_CUcoredumpSettings_enum;
pub const CUcoredumpCallbackEntry_st = struct_CUcoredumpCallbackEntry_st;
pub const CUdevResourceDesc_st = struct_CUdevResourceDesc_st;
pub const CUdevSmResource_st = struct_CUdevSmResource_st;
pub const CUdevWorkqueueConfigResource_st = struct_CUdevWorkqueueConfigResource_st;
pub const CUdevWorkqueueResource_st = struct_CUdevWorkqueueResource_st;
pub const CU_DEV_SM_RESOURCE_GROUP_PARAMS_st = struct_CU_DEV_SM_RESOURCE_GROUP_PARAMS_st;
pub const CUdevResource_st = struct_CUdevResource_st;
pub const CUlogLevel_enum = enum_CUlogLevel_enum;
pub const CUlogsCallbackEntry_st = struct_CUlogsCallbackEntry_st;
