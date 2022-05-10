`timescale 1ns / 1ps


module Control(inst_31_26, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

    input [5:0] inst_31_26;
    output RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    output [1:0] ALUOp;

    reg RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    reg [1:0] ALUOp;

    initial begin
        RegDst      <= 1'b0;
        Jump        <= 1'b0;
        Branch      <= 1'b0;
        MemRead     <= 1'b0;
        MemtoReg    <= 1'b0;
        MemWrite    <= 1'b0;
        ALUSrc      <= 1'b0;
        RegWrite    <= 1'b0;
        ALUOp       <= 2'b00;
    end

    // This block is mainly used for designed inst.

    always @(inst_31_26) begin
        case (inst_31_26)
            // R-type
            6'b000000: begin //add, and, or, slt
                RegDst      <= 1'b1;
                Jump        <= 1'b0;
                Branch      <= 1'b0;
                MemRead     <= 1'b0;
                MemtoReg    <= 1'b0;
                MemWrite    <= 1'b0;
                ALUSrc      <= 1'b0;
                RegWrite    <= 1'b1;
                ALUOp       <= 2'b10;
            end
            // I-type
            6'b001000: begin //addi
                RegDst      <= 1'b0;
                Jump        <= 1'b0;
                Branch      <= 1'b0;
                MemRead     <= 1'b0;
                MemtoReg    <= 1'b0;
                MemWrite    <= 1'b0;
                ALUSrc      <= 1'b1;
                RegWrite    <= 1'b1;
                ALUOp       <= 2'b00;
            end
            6'b001100: begin //andi
                RegDst      <= 1'b0;
                Jump        <= 1'b0;
                Branch      <= 1'b0;
                MemRead     <= 1'b0;
                MemtoReg    <= 1'b0;
                MemWrite    <= 1'b0;
                ALUSrc      <= 1'b1;
                RegWrite    <= 1'b1;
                ALUOp       <= 2'b11;
            end
            6'b000100: begin //beq
                RegDst      <= 1'b1;
                Jump        <= 1'b0;
                Branch      <= 1'b1;
                MemRead     <= 1'b0;
                MemtoReg    <= 1'b0;
                MemWrite    <= 1'b0;
                ALUSrc      <= 1'b0;
                RegWrite    <= 1'b0;
                ALUOp       <= 2'b01;
            end
            6'b000100: begin //bne
                RegDst      <= 1'b1;
                Jump        <= 1'b0;
                Branch      <= 1'b1;
                MemRead     <= 1'b0;
                MemtoReg    <= 1'b0;
                MemWrite    <= 1'b0;
                ALUSrc      <= 1'b0;
                RegWrite    <= 1'b0;
                ALUOp       <= 2'b01;
            end
            6'b100011: begin //lw
                RegDst      <= 1'b0;
                Jump        <= 1'b0;
                Branch      <= 1'b0;
                MemRead     <= 1'b1;
                MemtoReg    <= 1'b1;
                MemWrite    <= 1'b0;
                ALUSrc      <= 1'b1;
                RegWrite    <= 1'b1;
                ALUOp       <= 2'b00;
            end
            6'b101011: begin //sw
                RegDst      <= 1'b0;
                Jump        <= 1'b0;
                Branch      <= 1'b0;
                MemRead     <= 1'b0;
                MemtoReg    <= 1'b0;
                MemWrite    <= 1'b1;
                ALUSrc      <= 1'b1;
                RegWrite    <= 1'b0;
                ALUOp       <= 2'b00;
            end
            //J-type
            6'b000010: begin //j
                RegDst      <= 1'b1;
                Jump        <= 1'b1;
                Branch      <= 1'b0;
                MemRead     <= 1'b0;
                MemtoReg    <= 1'b0;
                MemWrite    <= 1'b0;
                ALUSrc      <= 1'b0;
                RegWrite    <= 1'b0;
                ALUOp       <= 2'b10;
            end

            default: begin
                RegDst      <= 1'b0;
                Jump        <= 1'b0;
                Branch      <= 1'b0;
                MemRead     <= 1'b0;
                MemtoReg    <= 1'b0;
                MemWrite    <= 1'b0;
                ALUSrc      <= 1'b0;
                RegWrite    <= 1'b0;
                ALUOp       <= 2'b00;
            end

        endcase
    end

endmodule

module ALU_control(funct, ALUOp, alu_control);

    input [5:0] funct;
    input [1:0] ALUOp;
    output [3:0] alu_control;

    reg [3:0] alu_control;

    always @(*) begin
        case (ALUOp)
            2'b00:
                alu_control = 4'b0010;
            2'b01:
                alu_control = 4'b0110;
            2'b10: begin
                case (funct)
                    6'b100000:
                        alu_control = 4'b0010;
                    6'b100010:
                        alu_control = 4'b0110;
                    6'b100100:
                        alu_control = 4'b0000;
                    6'b100101:
                        alu_control = 4'b0001;
                    6'b101010:
                        alu_control = 4'b0111;
                    default alu_control = 4'b0000;
                endcase
            end
            default alu_control = 4'b0000;
        endcase
    end

endmodule
