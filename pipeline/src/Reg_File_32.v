`timescale 1ns / 1ps


module Reg_File_32(clk, R_reg1, R_reg2, W_reg, W_data, R_data1, R_data2, RegWrite);

    parameter data_size = 32;
    parameter reg_addr_size = 5;

    input [reg_addr_size-1:0] R_reg1, R_reg2, W_reg;
    input [data_size-1:0] W_data;
    output [data_size-1:0] R_data1, R_data2;
    input RegWrite, clk;

    reg [data_size-1:0] register[0:31];

    integer i;
    initial begin
        for (i = 0; i < (2 << reg_addr_size); i = i + 1)
            register[i] = 32'b0;
    end

    always @(negedge clk) begin
        if (RegWrite == 1'b1) begin
            register[W_reg] <= W_data;
        end
    end

    assign R_data1 = register[R_reg1];
    assign R_data2 = register[R_reg2];

endmodule
