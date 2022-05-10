`timescale 1ns / 1ps


module PC(clk, stall, in, out);

    input         clk;
    input         stall;
    input  [31:0] in;
    output [31:0] out;

    reg    [31:0] out;

    // initialize program counter
    initial begin
        out = 32'b0;
    end

    // update program counter
    always@(posedge clk) begin
        if (!stall) begin
            out = in;
        end
    end

endmodule
