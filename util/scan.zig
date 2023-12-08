const std = @import("std");
const print = std.debug.print;

// in support of continued progress in aoc this is just some kata
// getting familiar with zig, character arrays, arrays, strings ...

pub fn main() !void {


    // char arrays (u8) and string stuff
    // zig doesn't have strings so
    // quoted text constants in code are just slices of bytes

    const name = "John Doe";
    print("\n\nname is {s}\n", .{ name });
    print("-> @TypeOf returns: {}\n",  .{ @TypeOf(name) });
    print("-> @typeName is   : {s}\n", .{ @typeName(@TypeOf(name))});

    print("\nNote that these string literals are defined as: (in sect 5.3 of zig docs)\n", .{});
    print(" \"string literals are constant single-item Pointers to null-terminated byte arrays\"\n\n", .{});
    print("\nThis explains why John Doe is of type of type *const [8:0]u8\n\n", .{});


    // technique 1: populate a u8 array with text, then search in it for a substr

    const letters: [26]u8 = blk: {
        var arr: [26]u8 = undefined;
        for ("abcdefghijklmnopqrstuvwxyz", 0..) |c, i| { // note how to get index captured
            arr[i] = c;
        }
        break :blk arr;
    };
    print("{} {} {} {}\n", .{letters[0], letters[1], letters[2], letters[3]});

    // this is interesting in so far as it demonstrates the use of returning memory
    // while using break and also the :blk syntax ; but very convoluted

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

    // more concisely lets make a *const [26:0]u8 instead per the next section
    // much much cleaner

    const letters2 = "abcdefghitwomnopqrstuvwxyz";
    const two = "two";
    const match2: bool = std.mem.startsWith(u8, letters2[9..12], two);
    print("Two in letters2 ? -> {}\n", .{ match2 });
    print("-> @TypeOf letters2 is {}, length is {d}\n", .{ @TypeOf(letters2), letters2.len });
    print("-> letter2[26] is available but should be 0, e.g. letters2[26]-> [{}]\n", .{ letters2[26] });

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

    // string stuff

}
