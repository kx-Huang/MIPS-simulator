`timescale 1ns / 1ps


module MUX2_1(in_0, in_1, sel, out);

    parameter bit = 32;

    input            sel;
    input  [bit-1:0] in_0, in_1;
    output [bit-1:0] out;

    assign out = (sel == 0) ? in_0 : in_1;

endmodule
