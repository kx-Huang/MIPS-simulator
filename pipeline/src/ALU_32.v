`timescale 1ns / 1ps


module ALU_32(A, B, alu_control, zero, result);

    parameter size = 32;

    input [size-1:0] A, B;
    input [3:0] alu_control;
    output [size-1:0] result;
    output zero;

    reg [size-1:0] result;

    assign zero = (result == 0);

    initial begin
        result = 32'b0;
    end

    always @ (alu_control, A, B ) begin
        case (alu_control)
            4'b0000: // AND
                result = A & B;
            4'b0001: // OR
                result = A | B;
            4'b0010: // ADD
                result = A + B;
            4'b0110: // SUB
                result = A - B;
            4'b0111: // SLT
                result = (A < B) ? 1 : 0;
            4'b1100: // NOR
                result = ~(A | B);
            default:
                ;
        endcase
    end

endmodule
