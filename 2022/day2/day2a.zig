const std = @import("std");
const expect = @import("std").testing.expect;

pub fn main() !void {
    const fileName = "input.txt";
    const file = try std.fs.cwd().openFile(fileName, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    const read_buf = try file.readToEndAlloc(allocator, 1024*1024);
    defer allocator.free(read_buf);

    var iter = std.mem.tokenizeAny(u8, read_buf, "\n");

    var totalScore: u32 = 0;

    while (iter.next()) |line| {
        const opMove = line[0];
        const myMove = line[2];

        const movePts: u32 = switch(myMove) {
            65, 88 => 1,
            66, 89 => 2,
            67, 90 => 3,
            else => 0
        };

        const outcomePts: u32 = switch(opMove) {
            65 => blk: {
                const res: u32 = switch(myMove) {
                    90 => 0,
                    88 => 3,
                    89 => 6,
                    else => 0
                };
                break :blk res;
            },

            66 => blk: {
                const res: u32 = switch(myMove) {
                    88 => 0,
                    89 => 3,
                    90 => 6,
                    else => 0
                };
                break :blk res;
            },

            67 => blk: {
                const res: u32 = switch(myMove) {
                    89 => 0,
                    90 => 3,
                    88 => 6,
                    else => 0
                };
                break :blk res;
            },
            else => 0
        };
        totalScore = totalScore + movePts + outcomePts;
    }
    std.debug.print("Total Score is : {}\n", .{totalScore});
}
