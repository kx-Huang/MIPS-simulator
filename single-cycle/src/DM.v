`timescale 1ns / 1ps


module DM(clk, addr, write_data, read_data, MemWrite, MemRead);

    parameter size = 64;

    input         clk;
    input         MemRead, MemWrite;
    input  [31:0] addr, write_data;
    output [31:0] read_data;

    reg [31:0] data_memory [0:size-1];

    // initialize data memory
    initial begin
        for (integer i = 0; i < size; i = i + 1)
            data_memory[i] = 32'b0;
    end

    // write data into data memory
    always @(posedge clk) begin
        if (MemWrite) begin
            data_memory[addr >> 2] = write_data;
        end
    end

    // read data from data memory
    assign read_data = MemRead ? data_memory[addr >> 2] : 32'b0;

endmodule


