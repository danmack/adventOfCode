const std = @import("std");

pub fn main() !void {
    const fileName = "input.txt";
    const file = try std.fs.cwd().openFile(fileName, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    const read_buf = try file.readToEndAlloc(allocator, 1024*1024);
    defer allocator.free(read_buf);

    // will use tri-sort type of algo to do this while scanning file

    var a: u32 = 0;  // biggest
    var b: u32 = 0;  // 2nd biggest
    var c: u32 = 0;  // 3rd biggest

    var cur: u32 = 0;

    var it = std.mem.split(u8, read_buf, "\n");
    while (it.next()) |amount| {
        if (amount.len > 0) {
            const result: u32 = try std.fmt.parseInt(u32, amount, 10);
            cur += result;
        } else {
            if (cur > a) {
                b = a;
                a = cur;
            } else if (cur > b) {
                c = b;
                b = cur;
            } else if (cur > c) {
                c = cur;
            }
            cur = 0;
        }
    }
    std.debug.print("Elf1 {}, Elf2 {}, Elf3 {}\n", .{a, b, c});
    const total: u32 = a + b + c;
    std.debug.print("Total is: {}\n", .{total});
}
