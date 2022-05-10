`timescale 1ns / 1ps


module MUX_4x1 (A0, A1, A2, A3, sel, F);

    parameter size = 32;

    input [size-1:0] A0, A1, A2, A3;
    output reg [size-1:0] F;
    input [1:0] sel;

    always @(*) begin
        case (sel)
            2'b00:
                F = A0;
            2'b01:
                F = A1;
            2'b10:
                F = A2;
            2'b11:
                F = A3;
        endcase
    end

endmodule
