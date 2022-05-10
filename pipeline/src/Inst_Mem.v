`timescale 1ns / 1ps


module Inst_Mem(R_addr, inst);

    parameter data_size = 32;

    input [data_size-1:0] R_addr;
    output [data_size-1:0] inst;

    reg [data_size-1:0] inst;

    parameter mem_size = 1000;

    reg [data_size/4-1:0] memory_8[0:4000];
    reg [data_size-1:0] memory[0:mem_size-1];

    // read from file into instruction memory
    // Format: one instruction per line, no space in one line
    initial begin
        $readmemb("InstructionMem_Demo.txt", memory_8);
    end

    integer i;
    initial begin
        for (i = 0; i < mem_size; i = i + 1)
            memory[i] = {memory_8[4*i], memory_8[4*i+1], memory_8[4*i+2], memory_8[4*i+3]};
    end

    always @(R_addr) begin
        inst <= memory[R_addr >> 2];
    end

endmodule
