`timescale 1ns / 1ps


module MUX_2x1 (A, B, sel, F);

    parameter size = 32;

    input [size-1:0] A,B;
    output [size-1:0] F;
    input sel;

    reg [size-1:0] F;

    always @(*) begin
        case (sel)
            1'b0:
                F = A;
            1'b1:
                F = B;
            default:
                F = A;
        endcase
    end

endmodule
