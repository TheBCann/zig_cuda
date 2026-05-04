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

    // PTX kernel: compiled to NVPTX assembly for sm_75 (GTX 1660 Ti).
    const ptx_target = b.resolveTargetQuery(.{
        .cpu_arch = .nvptx64,
        .os_tag = .cuda,
        .cpu_model = .{ .explicit = &Target.nvptx.cpu.sm_75 },
    });

    const kernel = b.addObject(.{
        .name = "kernel",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/kernel.zig"),
            .target = ptx_target,
            .optimize = .ReleaseFast,
        }),
        .use_llvm = true,
    });
    kernel.bundle_ubsan_rt = false;

    const ptx = kernel.getEmittedAsm();

    // Optional: install the PTX so you can `grep .entry zig-out/bin/kernel.ptx`
    // for symbol inspection. Not needed at runtime since we @embedFile it.
    const install_ptx = b.addInstallFile(ptx, "bin/kernel.ptx");
    b.getInstallStep().dependOn(&install_ptx.step);

    // Host executable.
    const exe = b.addExecutable(.{
        .name = "zig_cuda",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    // Embed the PTX bytes into the binary so we don't depend on a
    // filesystem path at runtime.
    exe.root_module.addAnonymousImport("kernel_ptx", .{
        .root_source_file = ptx,
    });

    exe.root_module.linkSystemLibrary("cuda", .{});
    exe.root_module.linkSystemLibrary("c", .{});

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_cmd.addArgs(args);

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
