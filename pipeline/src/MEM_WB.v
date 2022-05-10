`timescale 1ns / 1ps


module MEM_WB (
    input               clk,
    input               MemtoReg_MEM, //WB
                        RegWrite_MEM, //for use
    input       [31:0]  dmReadData_MEM,
                        ALUResult_MEM,
    input       [4:0]   Dst_MEM,

    output  reg         MemtoReg_WB, //WB
                        RegWrite_WB, //for use
    output  reg [31:0]  dmReadData_WB,
                        ALUResult_WB,
    output  reg [4:0]   Dst_WB
);

    initial begin
        MemtoReg_WB = 1'b0;
        RegWrite_WB = 1'b0;
        dmReadData_WB = 32'b0;
        ALUResult_WB = 32'b0;
        Dst_WB = 5'b0;
    end

    always @(posedge clk) begin
        MemtoReg_WB <= MemtoReg_MEM;
        RegWrite_WB <= RegWrite_MEM;
        dmReadData_WB <= dmReadData_MEM;
        ALUResult_WB <= ALUResult_MEM;
        Dst_WB <= Dst_MEM;
    end

endmodule