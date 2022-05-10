`timescale 1ns / 1ps


module RegFile(clk, RegWrite, read_reg_1, read_reg_2, write_reg, write_data, read_data_1, read_data_2);

    input          clk, RegWrite;
    input  [4:0]   read_reg_1, read_reg_2;
    input  [4:0]   write_reg;
    input  [31:0]  write_data;
    output [31:0]  read_data_1, read_data_2;

    reg    [31:0]  reg_file [0:31];

    // initialize register file
    initial begin
        for (integer i = 0; i < 32; i = i+1) begin
            reg_file[i] = 32'b0;
        end
    end

    // write register file
    always @(posedge clk) begin
        if(RegWrite == 1) begin
            reg_file[write_reg] = write_data;
        end
    end

    // read register file
    assign read_data_1 = reg_file[read_reg_1];
    assign read_data_2 = reg_file[read_reg_2];


endmodule
