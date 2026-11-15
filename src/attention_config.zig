const std = @import("std");

/// Shared by the example hosts and scores kernels.
pub const max_head_dim: u32 = 128;

pub fn validateHeadDimension(d: u32) error{InvalidHeadDimension}!void {
    if (d == 0 or d > max_head_dim) return error.InvalidHeadDimension;
}

test "head dimension boundaries" {
    try validateHeadDimension(1);
    try validateHeadDimension(max_head_dim);
    try std.testing.expectError(error.InvalidHeadDimension, validateHeadDimension(0));
    try std.testing.expectError(error.InvalidHeadDimension, validateHeadDimension(max_head_dim + 1));
}
