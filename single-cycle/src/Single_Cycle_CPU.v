`timescale 1ns / 1ps


module Single_Cycle_CPU(clk);

    input clk;

    // pc related wire
    wire [31:0] pc_in,
                pc_out,
                pc_plus_4,
                inst,
                stall;

    // control related wire
    wire        RegDst,
                Jump,
                BranchEq,
                BranchNe,
                MemRead,
                MemtoReg,
                MemWrite,
                ALUSrc,
                RegWrite;
    wire [1:0]  ALUOp;

    // RegFile related wire
    wire [4:0]  reg_write_addr;
    wire [31:0] reg_write_data,
                reg_read_data_1,
                reg_read_data_2;

    // ALU related wire
    wire        alu_zero;
    wire [3:0]  alu_ctrl;
    wire [31:0] sign_ext_out,
                alu_in_2,
                alu_result;
    // data memory related wire
    wire [31:0] mem_read_data;

    // jump related wire
    wire        Branch;
    wire [31:0] imm_left_shift_2,
                mux_branch_to_jump,
                branch_addr,
                jump_addr;

    assign stall = 1'b0;
    assign jump_addr = {pc_plus_4[31:28], inst[25:0], 2'b0};
    assign Branch = (BranchEq & alu_zero) | (BranchNe & ~alu_zero);

    // module connection
    PC              pc          (clk, stall, pc_in, pc_out);
    IM      #(64)   im          (pc_out, inst);
    Control         control     (inst[31:26], RegDst, Jump, BranchEq, BranchNe, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    MUX2_1  #(5)    mux_RegDst  (inst[20:16], inst[15:11], RegDst, reg_write_addr);
    RegFile         reg_file    (clk, RegWrite, inst[25:21], inst[20:16], reg_write_addr, reg_write_data, reg_read_data_1, reg_read_data_2);
    SignExt         sign_ext    (inst[15:0], sign_ext_out);
    MUX2_1  #(32)   mux_ALUSrc  (reg_read_data_2, sign_ext_out, ALUSrc, alu_in_2);
    ALUCtrl         alu_control (ALUOp, inst[5:0], alu_ctrl);
    ALU             alu         (alu_ctrl, reg_read_data_1, alu_in_2, alu_zero, alu_result);
    DM      #(64)   dm          (clk, alu_result, reg_read_data_2, mem_read_data, MemWrite, MemRead);
    MUX2_1  #(32)   mux_Mem2Reg (alu_result, mem_read_data, MemtoReg, reg_write_data);
    Adder4          adder4      (pc_out, pc_plus_4);
    LeftShift2      ls2         (sign_ext_out, imm_left_shift_2);
    Adder2_1        adder2_1    (pc_plus_4, imm_left_shift_2, branch_addr);
    MUX2_1  #(32)   mux_branch  (pc_plus_4, branch_addr, Branch, mux_branch_to_jump);
    MUX2_1  #(32)   mux_jump    (mux_branch_to_jump, jump_addr, Jump, pc_in);

endmodule
