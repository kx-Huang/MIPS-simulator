`timescale 1ns / 1ps


module block_test;

    parameter input_size = 26, output_size = 28;

    reg [input_size-1:0] in;
    wire [output_size-1:0] out;

    Shift_Left_2 # (input_size,output_size) sl_2 (in, out);

    initial begin
        #0 in = 16'b0;
        #100 in = 16;
        #100 in = -16;
    end

    initial #300 $stop;

endmodule
