const std = @import("std");

pub fn allocationBytes(comptime T: type, n: usize) error{SizeOverflow}!usize {
    return std.math.mul(usize, n, @sizeOf(T)) catch error.SizeOverflow;
}

pub fn copyBytes(comptime T: type, capacity: usize, count: usize) error{ InvalidValue, SizeOverflow }!usize {
    if (count > capacity) return error.InvalidValue;
    return allocationBytes(T, count);
}

test "allocation size overflow" {
    try std.testing.expectEqual(@as(usize, 16), try allocationBytes(f32, 4));
    try std.testing.expectError(error.SizeOverflow, allocationBytes(f32, std.math.maxInt(usize) / 4 + 1));
}

test "copy bounds and byte overflow remain checked in every build mode" {
    try std.testing.expectEqual(@as(usize, 8), try copyBytes(f32, 3, 2));
    try std.testing.expectEqual(@as(usize, 0), try copyBytes(f32, 0, 0));
    try std.testing.expectError(error.InvalidValue, copyBytes(f32, 2, 3));
    try std.testing.expectError(error.SizeOverflow, copyBytes(f32, std.math.maxInt(usize), std.math.maxInt(usize)));
}
