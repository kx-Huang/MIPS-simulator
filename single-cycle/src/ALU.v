`timescale 1ns / 1ps


module ALU(control, in_1, in_2, zero, result);

    input  [3:0]  control;
    input  [31:0] in_1, in_2;
    output        zero;
    output [31:0] result;

    reg    [31:0] result;

    assign zero = (result == 0);

    // initialize ALU
    initial begin
        result = 32'b0;
    end

    // ALU operation
    always @(control, in_1, in_2) begin
        case (control)
            4'b0000: result = in_1 & in_2;
            4'b0001: result = in_1 | in_2;
            4'b0010: result = in_1 + in_2;
            4'b0110: result = in_1 - in_2;
            4'b0111: result = (in_1 < in_2) ? 1 : 0;
        endcase
    end

endmodule
