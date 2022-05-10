`timescale 1ns / 1ps


module EX_MEM(
    input               clk,
    input               MemRead_EX,
                        MemWrite_EX, //M
                        MemtoReg_EX, //WB
                        RegWrite_EX, //for use
    input       [31:0]  ALUResult_EX,
                        ForwardBOut_EX,
    input       [4:0]   Dst_EX,

    output  reg         MemRead_MEM,
                        MemWrite_MEM, //M
                        MemtoReg_MEM, //WB
                        RegWrite_MEM, //for use
    output  reg [31:0]  ALUResult_MEM,
                        ForwardBOut_MEM,
    output  reg [4:0]   Dst_MEM
);

    initial begin
        MemRead_MEM = 1'b0;
        MemWrite_MEM = 1'b0;
        MemtoReg_MEM = 1'b0;
        RegWrite_MEM = 1'b0;
        ALUResult_MEM = 32'b0;
        ForwardBOut_MEM = 32'b0;
        Dst_MEM = 5'b0;
    end

    always @(posedge clk) begin
            MemRead_MEM <= MemRead_EX;
            MemWrite_MEM <= MemWrite_EX;
            MemtoReg_MEM <= MemtoReg_EX;
            RegWrite_MEM <= RegWrite_EX;
            ALUResult_MEM <= ALUResult_EX;
            ForwardBOut_MEM <= ForwardBOut_EX;
            Dst_MEM <= Dst_EX;
    end

endmodule