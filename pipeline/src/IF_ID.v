`timescale 1ns / 1ps


module IF_ID(
    input               clk,
                        IFID_Write,
                        IF_Flush,
    input       [31:0]  pcAdd4_IF,
                        inst_IF,
    output reg  [31:0]  pcAdd4_ID,
                        inst_ID
    );

    initial begin
        pcAdd4_ID = 32'b0;
        inst_ID = 32'b0;
    end

    always @(posedge clk) begin
        if (IF_Flush) begin
            pcAdd4_ID <= 32'b0;
            inst_ID <= 32'b0;
        end
        else if (IFID_Write) begin
            pcAdd4_ID <= pcAdd4_IF;
            inst_ID <= inst_IF;
        end
    end

endmodule
