`timescale 1ns / 1ps


module Branch_Detection(
        input               Branch,
                            equal,
                            Hazard,
                            Jump,
        input       [5:0]   opcode,
        output  reg         isBranch,
                            IF_Flush
    );

    initial begin
        isBranch = 1'b0;
        IF_Flush = 1'b0;
    end

    always @(*) begin
        if (Hazard) begin
            isBranch = 1'b0;
            IF_Flush = 1'b0;
        end
        else if (Jump == 1'b1) begin
            isBranch = 1'b0;
            IF_Flush = 1'b1;
        end
        else begin
            if (opcode == 4 && equal == 1'b1) begin //beq
                isBranch = 1'b1;
                IF_Flush = 1'b1;
            end
            else if (opcode == 5 && equal == 1'b0) begin //bne
                isBranch = 1'b1;
                IF_Flush = 1'b1;
            end
            else begin
                isBranch = 1'b0;
                IF_Flush = 1'b0;
            end
        end
    end

endmodule
