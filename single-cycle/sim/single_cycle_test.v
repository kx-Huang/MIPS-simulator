`timescale 1ns / 1ps


module Single_Cycle_test;

    integer i = 0;
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	Single_Cycle_CPU uut (clk);

	initial begin
		// Initialize Inputs
		clk = 0;
        $dumpfile("Single_Cycle_CPU.vcd");
        $dumpvars(1, uut);
        $display("Single Cycle CPU Test-Bench:");
        $display("==========================================================");
        $display("Clock Cycle: %d, PC = 0x%H", i, 00000000);
        $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.reg_file.reg_file[16], uut.reg_file.reg_file[17], uut.reg_file.reg_file[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.reg_file.reg_file[19], uut.reg_file.reg_file[20], uut.reg_file.reg_file[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", uut.reg_file.reg_file[22], uut.reg_file.reg_file[23], uut.reg_file.reg_file[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", uut.reg_file.reg_file[9],  uut.reg_file.reg_file[10], uut.reg_file.reg_file[11]);
        $display("Data Memory 0x00 = 0x%H", uut.dm.data_memory[0]);
        $display("Data Memory 0x04 = 0x%H", uut.dm.data_memory[1]);
        $display("Data Memory 0x08 = 0x%H", uut.dm.data_memory[2]);
        $display("Data Memory 0x0c = 0x%H", uut.dm.data_memory[3]);
        $display("Data Memory 0x10 = 0x%H", uut.dm.data_memory[4]);
        $display("Data Memory 0x14 = 0x%H", uut.dm.data_memory[5]);
        $display("Data Memory 0x18 = 0x%H", uut.dm.data_memory[6]);
        $display("Data Memory 0x1c = 0x%H", uut.dm.data_memory[7]);
        $display("----------------------------------------------------------");
        #1000;
        $stop;
	end

    always #10 begin
        if (clk == 1'b1) begin
        $display("Clock Cycle: %d, PC = 0x%H", i, uut.pc_out);
        $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.reg_file.reg_file[16], uut.reg_file.reg_file[17], uut.reg_file.reg_file[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.reg_file.reg_file[19], uut.reg_file.reg_file[20], uut.reg_file.reg_file[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", uut.reg_file.reg_file[22], uut.reg_file.reg_file[23], uut.reg_file.reg_file[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", uut.reg_file.reg_file[9],  uut.reg_file.reg_file[10], uut.reg_file.reg_file[11]);
        $display("Data Memory 0x00 = 0x%H", uut.dm.data_memory[0]);
        $display("Data Memory 0x04 = 0x%H", uut.dm.data_memory[1]);
        $display("Data Memory 0x08 = 0x%H", uut.dm.data_memory[2]);
        $display("Data Memory 0x0c = 0x%H", uut.dm.data_memory[3]);
        $display("Data Memory 0x10 = 0x%H", uut.dm.data_memory[4]);
        $display("Data Memory 0x14 = 0x%H", uut.dm.data_memory[5]);
        $display("Data Memory 0x18 = 0x%H", uut.dm.data_memory[6]);
        $display("Data Memory 0x1c = 0x%H", uut.dm.data_memory[7]);
        $display("----------------------------------------------------------");
        end
        clk = ~clk;
        if (clk == 1'b1) begin
            i = i + 1;
        end
    end

endmodule
