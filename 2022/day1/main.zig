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

    var max: u32 = 0;
    var cur: u32 = 0;

    var it = std.mem.split(u8, read_buf, "\n");
    while (it.next()) |amount| {
        if (amount.len > 0) {
            const result: u32 = try std.fmt.parseInt(u32, amount, 10);
            cur += result;
        } else {
            if (cur > max) {
                max = cur;
            }
            cur = 0;
        }
    }
    std.debug.print("{}\n", .{max});
}
