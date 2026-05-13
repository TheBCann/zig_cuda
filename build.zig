const std = @import("std");
const Target = std.Target;

pub fn build(b: *std.Build) void {
    // Pin glibc to 2.38 to bypass GCC 15's .sframe relocations that
    // Zig's bundled LLD doesn't yet handle. Forces hermetic crt1.o.
    const target = b.standardTargetOptions(.{
        .default_target = .{
            .os_tag = .linux,
            .abi = .gnu,
            .glibc_version = .{ .major = 2, .minor = 38, .patch = 0 },
        },
    });
    const optimize = b.standardOptimizeOption(.{});

    // Public library module. Consumers `@import("cuda")` to get this.
    const cuda_mod = b.addModule("cuda", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
    });

    // Build all examples under examples/
    buildExample(b, cuda_mod, target, optimize, "01_vector_add");
    buildExample(b, cuda_mod, target, optimize, "02_timed_vector_add");
    buildExample(b, cuda_mod, target, optimize, "03_pcie_truth");
    buildExample(b, cuda_mod, target, optimize, "04_reduction");
    buildExample(b, cuda_mod, target, optimize, "05_matmul");
    buildExample(b, cuda_mod, target, optimize, "06_reduction_v2");
    buildExample(b, cuda_mod, target, optimize, "07_reduction_v3");
    buildExample(b, cuda_mod, target, optimize, "08_streams");
    buildExample(b, cuda_mod, target, optimize, "09_comptime_matmul");
}

fn buildExample(
    b: *std.Build,
    cuda_mod: *std.Build.Module,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    comptime name: []const u8,
) void {
    const dir = "examples/" ++ name;

    // Device side: compile kernel.zig to PTX for sm_75.
    const ptx_target = b.resolveTargetQuery(.{
        .cpu_arch = .nvptx64,
        .os_tag = .cuda,
        .cpu_model = .{ .explicit = &Target.nvptx.cpu.sm_75 },
    });

    const kernel = b.addObject(.{
        .name = name ++ "_kernel",
        .root_module = b.createModule(.{
            .root_source_file = b.path(dir ++ "/kernel.zig"),
            .target = ptx_target,
            .optimize = .ReleaseFast,
        }),
        .use_llvm = true,
    });
    kernel.bundle_ubsan_rt = false;

    const ptx = kernel.getEmittedAsm();

    // Host side: regular executable that embeds the PTX.
    const exe = b.addExecutable(.{
        .name = name,
        .root_module = b.createModule(.{
            .root_source_file = b.path(dir ++ "/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "cuda", .module = cuda_mod },
            },
        }),
    });

    exe.root_module.addAnonymousImport("kernel_ptx", .{
        .root_source_file = ptx,
    });

    exe.root_module.linkSystemLibrary("cuda", .{});
    exe.root_module.linkSystemLibrary("c", .{});

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_cmd.addArgs(args);

    const run_step = b.step("run-" ++ name, "Run the " ++ name ++ " example");
    run_step.dependOn(&run_cmd.step);
}
