`timescale 1ns / 1ps


module ID_EX(
        input               clk, Hazard,
        input       [1:0]   ALUOp_ID,
        input               RegDst_ID,
                            ALUSrc_ID, //EX
                            MemRead_ID,
                            MemWrite_ID, //M
                            MemtoReg_ID, //WB
                            RegWrite_ID, //for use
        input       [31:0]  regReadData1_ID,
                            regReadData2_ID,
                            signExtend_ID,
        input       [4:0]   Rs_ID,
                            Rt_ID,
                            Rd_ID,

        output  reg [1:0]   ALUOp_EX,
        output  reg         RegDst_EX,
                            ALUSrc_EX, //EX
                            MemRead_EX,
                            MemWrite_EX, //M
                            MemtoReg_EX, //WB
                            RegWrite_EX, //for use
        output  reg [31:0]  regReadData1_EX,
                            regReadData2_EX,
                            signExtend_EX,
        output  reg [4:0]   Rs_EX,
                            Rt_EX,
                            Rd_EX
    );

    initial begin
        ALUOp_EX = 2'b00;
        RegDst_EX = 1'b0;
        ALUSrc_EX = 1'b0;
        MemRead_EX = 1'b0;
        MemWrite_EX = 1'b0;
        MemtoReg_EX = 1'b0;
        RegWrite_EX = 1'b0;
        regReadData1_EX = 32'b0;
        regReadData2_EX = 32'b0;
        signExtend_EX = 32'b0;
        Rs_EX = 5'b0;
        Rt_EX = 5'b0;
        Rd_EX = 5'b0;
    end

    always @(posedge clk) begin
        if (Hazard == 1'b1) begin
            ALUOp_EX <= 2'b00;
            RegDst_EX <= 1'b0;
            ALUSrc_EX <= 1'b0;
            MemRead_EX <= 1'b0;
            MemWrite_EX <= 1'b0;
            MemtoReg_EX <= 1'b0;
            RegWrite_EX <= 1'b0;
            regReadData1_EX <= regReadData1_ID;
            regReadData2_EX <= regReadData2_ID;
            signExtend_EX <= signExtend_ID;
            Rs_EX <= Rs_ID;
            Rt_EX <= Rt_ID;
            Rd_EX <= Rd_ID;
        end
        else begin
            ALUOp_EX <= ALUOp_ID;
            RegDst_EX <= RegDst_ID;
            ALUSrc_EX <= ALUSrc_ID;
            MemRead_EX <= MemRead_ID;
            MemWrite_EX <= MemWrite_ID;
            MemtoReg_EX <= MemtoReg_ID;
            RegWrite_EX <= RegWrite_ID;
            regReadData1_EX <= regReadData1_ID;
            regReadData2_EX <= regReadData2_ID;
            signExtend_EX <= signExtend_ID;
            Rs_EX <= Rs_ID;
            Rt_EX <= Rt_ID;
            Rd_EX <= Rd_ID;
        end
    end


endmodule
