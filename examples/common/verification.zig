const std = @import("std");

pub fn check(actual: f64, expected: f64, abs_tol: f64, rel_tol: f64) error{VerificationFailed}!void {
    if (!std.math.isFinite(actual) or !std.math.isFinite(expected) or
        @abs(actual - expected) > abs_tol + rel_tol * @abs(expected))
        return error.VerificationFailed;
}

test "reject nonfinite values and finite mismatches" {
    for ([_]f64{ std.math.nan(f64), std.math.inf(f64), -std.math.inf(f64), 2 }) |bad| {
        try std.testing.expectError(error.VerificationFailed, check(bad, 1, 1e-5, 1e-5));
    }
    try std.testing.expectError(error.VerificationFailed, check(1, std.math.nan(f64), 1e-5, 1e-5));
    try check(1.000001, 1, 1e-5, 1e-5);
}
