`timescale 1ns / 1ps


module ALUCtrl(ALUOp, funct, control);

    input  [1:0] ALUOp;
    input  [5:0] funct;
    output [3:0] control;

    reg    [3:0] control;

    always @(funct, ALUOp) begin
        case (ALUOp)
            2'b00: control = 4'b0010; // lw, sw, andi
            2'b01: control = 4'b0110; // beq, bne
            2'b10: // R-type
                case (funct)
                    6'b100000: control = 4'b0010; // add
                    6'b100010: control = 4'b0110; // sub
                    6'b100100: control = 4'b0000; // and
                    6'b100101: control = 4'b0001; // or
                    6'b101010: control = 4'b0111; // slt
                endcase
            2'b11: control = 4'b0000; // andi
        endcase
    end

endmodule
