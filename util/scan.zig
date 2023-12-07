const std = @import("std");
const print = std.debug.print;

// in support of continued progress in aoc this is just some kata
// getting familiar with zig, character arrays, arrays, strings ...

pub fn main() !void {
    const letters: [26]u8 = blk: {
        var arr: [26]u8 = undefined;
        for ("abcdefghijklmnopqrstuvwxyz", 0..) |c, i| { // note how to get index captured
            arr[i] = c;
        }
        break :blk arr;
    };
    print("{} {} {} {}\n", .{letters[0], letters[1], letters[2], letters[3]});

    const one: [3]u8 = blk: {
        var arr: [3]u8 = undefined;
        for ("xyz", 0..) |c, i| {
            arr[i] = c;
        }
        break :blk arr;
    };

    const ptr: *const [3]u8 = letters[23..26];
    const match: bool = std.mem.startsWith(u8, ptr, &one);
    print("Match -> {}\n", .{match});

    // print out some details

    print("{}\n", .{@TypeOf(ptr)});
    print("Array is {d} bytes.  One is {d} bytes\n", .{letters.len, one.len});
    print("Item #10 in Array is: {c}\n", .{letters[10]});
    print("Item #11 in Array is: {c}\n", .{letters[11]});

    // array kata
    // 3 variants to learn

    // note how we can use the @type... builtins to do reflection
    // let's call this form a normal array type
    const a1: [5]u8 = [5]u8{0, 1, 2, 3, 4};
    print("Array a1 is type [ {s} ] :\n", .{@typeName(@TypeOf(a1))});
    print("    a1 is {any}, a1[2] = {}\n", .{a1, a1[2]});

    // zig can infer the type and length for you when defining this
    // at compile time so this abbreviated definition works
    const b1 = [_]u8{5, 6, 7, 8, 9};
    print("Array b1 is type [ {s} ] :\n", .{@typeName(@TypeOf(b1))});
    print("    b1 is {any}, b1[4] = {}\n", .{b1, b1[4]});

    // arrays can be built up using the repetition operator and type
    // inference works correctly
    const r3 = a1 ** 3;
    print("Array r3 is type [ {s} ] :\n", .{@typeName(@TypeOf(r3))});
    print("    r3 is {any}, r3[4] = {}\n", .{r3, r3[5]});

    // multi-dim arrays - these are cool and easy to populate at compile time
    // and can also be used to store values in a grid a certain way
    const ma34: [3][4]u8 = [_][4]u8{
        .{ 24, 42, 37, 73 },
        .{ 17, 71, 13, 31 },
        .{ 23, 32, 41, 14 },
    };
    print("Multi-Dim Array ma34 is type [ {s} ] :\n", .{@typeName(@TypeOf(ma34))});
    print("    ma34 is {any}, ma34[0][1] = {}\n", .{ma34, ma34[0][1]});
    print("Diag Pattern is: {} {} {}\n", .{ma34[0][1], ma34[1][2], ma34[2][3]});
}
