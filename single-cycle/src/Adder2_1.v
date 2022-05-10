`timescale 1ns / 1ps


module Adder2_1(in_0, in_1, out);

    input  [31:0] in_0, in_1;
    output [31:0] out;

    assign out = in_0 + in_1;

endmodule
