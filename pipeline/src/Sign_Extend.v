`timescale 1ns / 1ps


module Sign_Extend (in, out);

    parameter input_size = 16, output_size = 32;

    input [input_size-1:0] in;
    output [output_size-1:0] out;

    wire [output_size-1:0] out;

    assign out = $signed(in);

endmodule
