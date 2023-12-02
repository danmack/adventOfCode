const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const fileName = "input.txt";
    const file = try std.fs.cwd().openFile(fileName, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    const read_buf = try file.readToEndAlloc(allocator, 1024*1024);
    defer allocator.free(read_buf);

    var sum: u32 = 0;

    var iter = std.mem.split(u8, read_buf, "\n");
    while (iter.next()) |code| {
        if (code.len > 0) {
            var first: u8 = 0;
            var last: u8 = 0;
            var seen_first = false;
            for (code) |dig| {
                if (dig > 47 and dig < 58) {
                    if (seen_first) {
                        last = dig - 48;
                    } else {
                        seen_first = true;
                        first = dig - 48;
                        last = first;
                    }
                }
            }
            sum += (first * 10) + last;
        }
    }
    print("Sum is {}\n", .{sum});
}
