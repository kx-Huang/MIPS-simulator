`timescale 1ns / 1ps


module Hazard_Detection(
    input               Branch,
                        MemRead_EX,
                        RegWrite_EX,
                        RegWrite_MEM,
                        MemRead_MEM,
    input       [4:0]   Rs_ID,
                        Rt_ID,
                        Rt_EX,
                        Rd_EX,
                        Dst_MEM,
    output reg          IFID_Write,
                        Hazard,
                        PC_Write
    );

    initial begin
        IFID_Write = 1'b1;
        Hazard = 1'b0;
        PC_Write = 1'b1;
    end

    always @(*) begin
        // for load use hazard
        if (MemRead_EX && Rt_EX && (Rt_EX == Rs_ID || Rt_EX == Rt_ID)) begin
            IFID_Write = 1'b0;
            Hazard = 1'b1;
            PC_Write = 1'b0;
        end
        // for branch use hazard
        else if (Branch) begin
            if (RegWrite_EX && Rd_EX && (Rd_EX == Rs_ID || Rd_EX == Rt_ID) ) begin // add beq
                IFID_Write = 1'b0;
                Hazard = 1'b1;
                PC_Write = 1'b0;
            end
            else if (RegWrite_MEM && Dst_MEM && (Dst_MEM == Rs_ID || Dst_MEM == Rt_ID) ) begin //add x beq
                IFID_Write = 1'b0;
                Hazard = 1'b1;
                PC_Write = 1'b0;
            end
            else begin
                IFID_Write = 1'b1;
                Hazard = 1'b0;
                PC_Write = 1'b1;
            end
        end
        else begin
            IFID_Write = 1'b1;
            Hazard = 1'b0;
            PC_Write = 1'b1;
        end

    end


endmodule
