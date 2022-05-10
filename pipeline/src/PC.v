`timescale 1ns / 1ps


module PC(clk, in, out, PCWrite);

    parameter size = 32;

    input PCWrite;
    input [size-1:0] in;
    output [size-1:0] out;
    input clk;

    reg [size-1:0] out;

    initial begin
        out = 32'b0;
    end

    always @(posedge clk) begin
        if (PCWrite)
            out <= in;
    end

endmodule
