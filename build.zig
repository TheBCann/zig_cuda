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
pub const SmArch = enum {
    sm_60, sm_61, sm_62,
    sm_70, sm_72, sm_75,
    sm_80, sm_86, sm_87, sm_89,
    sm_90, sm_90a,
};

pub const KernelOptions = struct {
    /// Identifier for the kernel object (used in cache paths).
    name: []const u8,
    /// Path to the kernel .zig source file.
    source: std.Build.LazyPath,
    /// Target compute capability. Default: sm_75 (Turing).
    sm: SmArch = .sm_75,
    /// Optimization level. Default: ReleaseFast (kernels are pure compute).
    optimize: std.builtin.OptimizeMode = .ReleaseFast,
};

/// Compile a Zig kernel to PTX. Returns the Compile step; call
/// `kernel.getEmittedAsm()` to get the LazyPath for `addAnonymousImport`.
///
/// Applies the workarounds documented in the README:
///   - bundle_ubsan_rt = false   (UBSan creates LLVM aliases NVPTX rejects)
///   - use_llvm = true           (NVPTX backend requires LLVM)
///   - Targets nvptx64-cuda with the requested SM features
pub fn addKernel(b: *std.Build, opts: KernelOptions) *std.Build.Step.Compile {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .nvptx64,
        .os_tag = .cuda,
        .cpu_model = .{ .explicit = smToCpu(opts.sm) },
    });

    const obj = b.addObject(.{
        .name = opts.name,
        .root_module = b.createModule(.{
            .root_source_file = opts.source,
            .target = target,
            .optimize = opts.optimize,
        }),
    });
    obj.bundle_ubsan_rt = false;
    obj.use_llvm = true;

    return obj;
}



pub const LinkOptions = struct {
    /// Path to the CUDA installation. If null, defaults to /opt/cuda
    /// (Arch Linux convention). Common alternatives:
    ///   /usr/local/cuda    — most distros, NVIDIA's official installer
    ///   /usr/lib/cuda      — some Debian/Ubuntu setups
    /// Override with `-Dcuda-path=...` build option in your project.
    cuda_path: ?[]const u8 = null,
};

/// Configure an executable to link against libcuda (the CUDA Driver API).
/// Adds the include path, library path (stubs/), system library, and
/// libc dependency.
pub fn linkCuda(exe: *std.Build.Step.Compile, opts: LinkOptions) void {
    const b = exe.step.owner;
    const cuda_path = opts.cuda_path orelse "/opt/cuda";

    exe.root_module.linkSystemLibrary("cuda", .{});
    exe.root_module.addIncludePath(.{ .cwd_relative = b.fmt("{s}/include", .{cuda_path}) });
    exe.root_module.addLibraryPath(.{ .cwd_relative = b.fmt("{s}/lib/stubs", .{cuda_path}) });
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
    const host_target = b.standardTargetOptions(.{
        .default_target = .{
            .os_tag = .linux,
            .abi = .gnu,
            .glibc_version = .{ .major = 2, .minor = 38, .patch = 0 },
        },
    });
    const optimize = b.standardOptimizeOption(.{});
    const cuda_path = b.option(
        []const u8,
        "cuda-path",
        "Path to CUDA installation (default: /opt/cuda)",
    );

    // Expose the runtime cuda module so external consumers can pick it up
    // via `cuda_dep.module("cuda")` from their build.zig, and so our own
    // examples can import it.
    const cuda_module = b.addModule("cuda", .{
        .root_source_file = b.path("src/root.zig"),
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
        "15_attention_forward"
    };

    for (examples) |name| {
        buildExample(b, .{
            .host_target = host_target,
            .optimize = optimize,
            .cuda_module = cuda_module,
            .cuda_path = cuda_path,
            .name = name,
        });
    }
}

// ─── Internal: per-example build wiring ─────────────────────────────────

const ExampleBuildOpts = struct {
    host_target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    cuda_module: *std.Build.Module,
    cuda_path: ?[]const u8,
    name: []const u8,
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
