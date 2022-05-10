`timescale 1ns / 1ps


module Shift_Left_2 (in, out);

    parameter input_size = 32, output_size = 32;

    input [input_size-1:0] in;
    output [output_size-1:0] out;

    wire [output_size-1:0] out;

    assign out = in * 4;

endmodule
