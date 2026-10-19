const std = @import("std");

// ════════════════════════════════════════════════════════════════════
//
//   PUBLIC BUILD HELPERS
//
//   External consumers use these via `const cuda = @import("cuda");`
//   in their own build.zig.
//
// ════════════════════════════════════════════════════════════════════

/// Compute capability of the target GPU.
///   sm_60-62: Pascal           (GTX 10-series)
///   sm_70/72: Volta/Xavier     (V100, Tegra Xavier)
///   sm_75:    Turing           (GTX 16-series, RTX 20-series, T4)
///   sm_80:    Ampere           (A100)
///   sm_86/87: Ampere           (RTX 30-series, A40, Tegra Orin)
///   sm_89:    Ada              (RTX 40-series)
///   sm_90/90a: Hopper          (H100, H200)
/// Zig generates PTX for all of these, but NVIDIA's R590+ drivers (CUDA 13.1
/// and newer) only run sm_75 and newer; Pascal and Volta need an R580 or
/// older driver.
pub const SmArch = enum {
    sm_60,
    sm_61,
    sm_62,
    sm_70,
    sm_72,
    sm_75,
    sm_80,
    sm_86,
    sm_87,
    sm_89,
    sm_90,
    sm_90a,
};

pub const KernelOptions = struct {
    /// Identifier for the kernel object (used in cache paths).
    name: []const u8,
    /// Path to the kernel .zig source file.
    source: std.Build.LazyPath,
    /// Target compute capability. Default: sm_75 (Turing).
    sm: SmArch = .sm_75,
    /// Optimization level. Default: .fast (kernels are pure compute).
    optimize: std.lang.Optimize = .fast,
};

/// Compile a Zig kernel to PTX. Returns the Compile step; call
/// `kernel.getEmittedAsm()` to get the LazyPath for `addAnonymousImport`.
///
/// Declare kernels as `export fn name(...) callconv(.kernel)`; the PTX entry
/// is then `name`, the string to pass to `Module.getFunction`. Give each
/// kernel a single export name: on NVPTX every export renames the same
/// symbol, so only one of several names survives, and source order does
/// not decide which.
pub fn addKernel(b: *std.Build, opts: KernelOptions) *std.Build.Step.Compile {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .nvptx64,
        .os_tag = .cuda,
        .cpu_model = .{ .explicit = smToCpu(opts.sm) },
        // LLVM emits the lowest PTX ISA an SM allows: 5.0 for sm_60-62, which
        // lacks the shfl.sync warp shuffles some kernels use (they need 6.0).
        // Newer SMs already default to 6.0 or later.
        .cpu_features_add = switch (opts.sm) {
            .sm_60, .sm_61, .sm_62 => std.Target.nvptx.featureSet(&.{.ptx60}),
            else => .empty,
        },
    });

    return b.addObject(.{
        .name = opts.name,
        .root_module = b.createModule(.{
            .root_source_file = opts.source,
            .target = target,
            .optimize = opts.optimize,
        }),
    });
}

pub const LinkOptions = struct {
    /// CUDA installation whose `lib/stubs/libcuda.so` satisfies the link; at
    /// runtime the driver's own libcuda.so.1 is loaded instead. Absolute, or
    /// relative to the directory `zig build` runs in. If null, pkg-config's
    /// `cuda` package is used when one exists, else /opt/cuda (the Arch
    /// Linux layout). For NVIDIA's installer layout pass
    /// /usr/local/cuda/targets/x86_64-linux, whose lib/stubs holds the stub.
    /// Override with `-Dcuda-path=...` build option in your project.
    cuda_path: ?[]const u8 = null,
};

/// Configure an executable to link against libcuda (the CUDA Driver API):
/// the system library, the stubs search path, and libc. An explicit
/// `cuda_path` turns pkg-config off for libcuda, because pkg-config's -L
/// would otherwise be searched first and silently win.
pub fn linkCuda(exe: *std.Build.Step.Compile, opts: LinkOptions) void {
    const b = exe.step.owner;
    const cuda_path = opts.cuda_path orelse "/opt/cuda";

    exe.root_module.linkSystemLibrary("cuda", .{
        .use_pkg_config = if (opts.cuda_path != null) .no else .yes,
    });
    exe.root_module.addLibraryPath(b.graph.cwdRelativePath(b.fmt("{s}/lib/stubs", .{cuda_path})));
    exe.root_module.link_libc = true;
}

// ════════════════════════════════════════════════════════════════════
//
//   BUILD FUNCTION
//
//   Builds the internal examples. External consumers don't run this;
//   they just import addKernel / linkCuda above.
//
// ════════════════════════════════════════════════════════════════════

pub fn build(b: *std.Build) void {
    // Native CPU so the CPU reference loops use the host's SIMD (AVX2 etc.);
    // naming linux-gnu explicitly keeps the link hermetic (Zig-built crt
    // files and glibc stubs, not the host's) and keeps Linux the default
    // when configuring from another OS. Without the explicit .native, a
    // partial query like this one compiles for baseline x86-64.
    const host_target = b.standardTargetOptions(.{
        .default_target = .{
            .cpu_model = .native,
            .os_tag = .linux,
            .abi = .gnu,
        },
    });
    const optimize = b.standardOptimizeOption(.{});
    const cuda_path = b.option(
        []const u8,
        "cuda-path",
        "Directory whose lib/stubs/ holds libcuda.so, e.g. /usr/local/cuda/targets/x86_64-linux (default: pkg-config 'cuda', else /opt/cuda)",
    );

    // Expose the runtime cuda module so external consumers can pick it up
    // via `cuda_dep.module("cuda")` from their build.zig, and so our own
    // examples can import it.
    const cuda_module = b.addModule("cuda", .{
        .root_source_file = b.path("src/root.zig"),
        // The bindings are `extern "cuda" fn`, and Zig only lets a PIC module
        // depend on a dynamic library by name. Executables stopped defaulting
        // to PIC in 0.18.0-dev (Zig PR #36532), and `-lcuda` alone does not
        // satisfy the check, so request PIC for this module explicitly.
        .pic = true,
    });

    // Every example follows the same shape: kernel.zig (compiled to PTX),
    // main.zig (host code), embed the PTX, link libcuda. The buildExample
    // helper handles the wiring; just enumerate them here.
    const examples = [_][]const u8{
        "01_vector_add",
        "02_timed_vector_add",
        "03_pcie_truth",
        "04_reduction",
        "05_matmul",
        "06_reduction_v2",
        "07_reduction_v3",
        "08_streams",
        "09_comptime_matmul",
        "10_vectorized_matmul",
        "11_register_blocked_matmul",
        "12_softmax",
        "13_attention_scores",
        "14_attention_output",
        "15_attention_forward",
    };

    // `zig build run-all` runs every example; each one exits nonzero if its
    // GPU result fails verification, so this doubles as the regression suite.
    const run_all = b.step("run-all", "Run and verify every example (needs a GPU)");

    for (examples) |name| {
        buildExample(b, .{
            .host_target = host_target,
            .optimize = optimize,
            .cuda_module = cuda_module,
            .cuda_path = cuda_path,
            .name = name,
            .run_all = run_all,
        });
    }
}

// ─── Internal: per-example build wiring ─────────────────────────────────

const ExampleBuildOpts = struct {
    host_target: std.Build.ResolvedTarget,
    /// null when no -Doptimize/--release was given; Zig then picks the default.
    optimize: ?std.lang.Optimize,
    cuda_module: *std.Build.Module,
    cuda_path: ?[]const u8,
    name: []const u8,
    run_all: *std.Build.Step,
};

fn buildExample(b: *std.Build, opts: ExampleBuildOpts) void {
    // ── Compile the kernel ──────────────────────────────────────────
    const kernel = addKernel(b, .{
        .name = b.fmt("{s}_kernel", .{opts.name}),
        .source = b.path(b.fmt("examples/{s}/kernel.zig", .{opts.name})),
        .sm = .sm_75,
    });

    // ── Host executable ─────────────────────────────────────────────
    const exe = b.addExecutable(.{
        .name = opts.name,
        .root_module = b.createModule(.{
            .root_source_file = b.path(b.fmt("examples/{s}/main.zig", .{opts.name})),
            .target = opts.host_target,
            .optimize = opts.optimize,
        }),
    });

    // Wire up the runtime cuda module + the embedded PTX.
    exe.root_module.addImport("cuda", opts.cuda_module);
    exe.root_module.addAnonymousImport("kernel_ptx", .{
        .root_source_file = kernel.getEmittedAsm(),
    });

    // Link libcuda.
    linkCuda(exe, .{ .cuda_path = opts.cuda_path });

    // Install + register a `run-NN_example` step.
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step(
        b.fmt("run-{s}", .{opts.name}),
        b.fmt("Run the {s} example", .{opts.name}),
    );
    run_step.dependOn(&run_cmd.step);

    // Each example gets its own Run step in run-all so one failure doesn't
    // hide the rest.
    const run_all_cmd = b.addRunArtifact(exe);
    opts.run_all.dependOn(&run_all_cmd.step);
}

// ─── Internal: SmArch → std.Target.nvptx.Feature mapping ────────────────
fn smToCpu(sm: SmArch) *const std.Target.Cpu.Model {
    return switch (sm) {
        .sm_60 => &std.Target.nvptx.cpu.sm_60,
        .sm_61 => &std.Target.nvptx.cpu.sm_61,
        .sm_62 => &std.Target.nvptx.cpu.sm_62,
        .sm_70 => &std.Target.nvptx.cpu.sm_70,
        .sm_72 => &std.Target.nvptx.cpu.sm_72,
        .sm_75 => &std.Target.nvptx.cpu.sm_75,
        .sm_80 => &std.Target.nvptx.cpu.sm_80,
        .sm_86 => &std.Target.nvptx.cpu.sm_86,
        .sm_87 => &std.Target.nvptx.cpu.sm_87,
        .sm_89 => &std.Target.nvptx.cpu.sm_89,
        .sm_90 => &std.Target.nvptx.cpu.sm_90,
        .sm_90a => &std.Target.nvptx.cpu.sm_90a,
    };
}
