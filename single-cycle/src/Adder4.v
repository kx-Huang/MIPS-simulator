`timescale 1ns / 1ps


module Adder4(in, out);

    input  [31:0] in;
    output [31:0] out;

    assign out = in + 4;

endmodule
