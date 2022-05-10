`timescale 1ns / 1ps


module Forwarding(
    input       [4:0]   Rs_ID,
                        Rt_ID,
                        Rs_EX,
                        Rt_EX,
                        Dst_MEM,
                        Dst_WB,
    input               RegWrite_MEM,
                        RegWrite_WB,
    output reg  [1:0]   ForwardA,
                        ForwardB,
                        Forward1,
                        Forward2
);

    initial begin
        ForwardA = 2'b00;
        ForwardB = 2'b00;
        Forward1 = 1'b0;
        Forward2 = 1'b0;
    end

    always @(*) begin
        if (RegWrite_MEM && Dst_MEM && Dst_MEM == Rs_EX)
            ForwardA = 2'b10;
        else if (RegWrite_WB && Dst_WB && Dst_WB == Rs_EX)
            ForwardA = 2'b01;
        else
            ForwardA = 2'b00;

        if (RegWrite_MEM && Dst_MEM && Dst_MEM == Rt_EX)
            ForwardB = 2'b10;
        else if (RegWrite_WB && Dst_WB && Dst_WB == Rt_EX)
            ForwardB = 2'b01;
        else
            ForwardB = 2'b00;

        //useless
        if (RegWrite_MEM && Dst_MEM && Dst_MEM == Rs_ID)
            Forward1 = 1'b1;
        else
            Forward1 = 1'b0;

        if (RegWrite_MEM && Dst_MEM && Dst_MEM == Rt_ID)
            Forward2 = 1'b1;
        else
            Forward2 = 1'b0;
    end

endmodule
