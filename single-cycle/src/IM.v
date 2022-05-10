`timescale 1ns / 1ps


module IM(addr, inst);

    parameter size = 64;

    input  [31:0] addr;
    output [31:0] inst;

    reg    [31:0] memory [0:size-1];

    // read from file into instruction memory
    // Format: one instruction per line, no space in one line
    initial begin
        $readmemb("InstructionMem_Demo.txt", memory);
    end

    assign inst = memory[addr>>2];

endmodule
