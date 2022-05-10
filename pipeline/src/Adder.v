`timescale 1ns / 1ps


module Adder(A, B, F);

    parameter size = 32;

    input [size-1:0] A, B;
    output [size-1:0] F;

    reg [size-1:0] F;

    always @(*) begin
        F <= A + B;
    end

endmodule
