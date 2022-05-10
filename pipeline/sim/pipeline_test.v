`timescale 1ns / 1ps


module pipeline_test;

    integer i = 1;
    reg clk;

    top uut(clk);

    initial begin
		// Initialize Inputs
        #0 clk = 0;
        $display("==========================================================");
	end

    always #10 begin
        $display("Time: %d, CLK = %d, PC = %H", i, clk, uut.pcOut_IF);
        $display("[$s0] = %H, [$s1] = %H, [$s2] = %H", uut.rf.register[16], uut.rf.register[17], uut.rf.register[18]);
        $display("[$s3] = %H, [$s4] = %H, [$s5] = %H", uut.rf.register[19], uut.rf.register[20], uut.rf.register[21]);
        $display("[$s6] = %H, [$s7] = %H, [$t0] = %H", uut.rf.register[22], uut.rf.register[23], uut.rf.register[8]);
        $display("[$t1] = %H, [$t2] = %H, [$t3] = %H", uut.rf.register[9], uut.rf.register[10], uut.rf.register[11]);
        $display("[$t4] = %H, [$t5] = %H, [$t6] = %H", uut.rf.register[12], uut.rf.register[13], uut.rf.register[14]);
        $display("[$t7] = %H, [$t8] = %H, [$t9] = %H", uut.rf.register[15], uut.rf.register[24], uut.rf.register[25]);
        clk = ~clk;
        if (~clk) i = i + 1;
    end

    initial #1000 $stop;
endmodule
