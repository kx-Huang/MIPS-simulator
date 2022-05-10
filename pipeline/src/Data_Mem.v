`timescale 1ns / 1ps


module Data_Mem(clk, addr, W_data, R_data, MemWrite, MemRead);

    parameter data_size = 32;

    input [data_size-1:0] addr, W_data;
    output [data_size-1:0] R_data;
    input MemWrite, MemRead, clk;

    parameter mem_size = 1000;

    reg [data_size-1:0] memory [0:mem_size-1];

    integer i;
    initial begin
        for (i = 0; i < mem_size; i = i + 1)
            memory[i] = 32'b0;
    end

    always @(posedge clk) begin
        if (MemWrite == 1'b1)
            memory[addr >> 2] = W_data;
    end

    assign R_data = (MemRead == 1'b1) ? memory[addr >> 2]:32'b0;

endmodule
