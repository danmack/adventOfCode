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
        const myOutcome = line[2];

        const outcomePts: u32 = switch(myOutcome) {
            88 => 0, // x->lose
            89 => 3, // y->draw
            90 => 6, // z->win
            else => 0
        };

        const movePts: u32 = switch(opMove) {
            65 => blk: {
                const res: u32 = switch(myOutcome) {   // a (rock)
                    88 => 3,   // lose -> scissors
                    89 => 1,   // draw -> rock
                    90 => 2,   // win -> paper
                    else => 0
                };
                break :blk res;
            },

            66 => blk: {
                const res: u32 = switch(myOutcome) {   // b (paper)
                    88 => 1,   // lose -> rock
                    89 => 2,   // draw -> paper
                    90 => 3,   // win -> scissors
                    else => 0
                };
                break :blk res;
            },

            67 => blk: {
                const res: u32 = switch(myOutcome) {  // c (scissors)
                    88 => 2,  // lose -> paper
                    89 => 3,  // draw -> scissors
                    90 => 1,  // win -> rock
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
