`timescale 1ns / 1ps


module Pipeline_CPU(clk);

    /* declearation */
    input clk;
    //IF
    wire    [31:0]  pcIn_IF,
                    pcOut_IF,
                    pcAdd4_IF,
                    inst_IF;
    wire            IFID_Write,
                    IF_Flush;

    //ID
    wire            isBranch,
                    Jump;
    wire    [31:0]  jump_addr,
                    branch_addr;
    wire    [31:0]  pcAdd4_ID,
                    inst_ID;

    wire    [4:0]   Rs_ID,
                    Rt_ID,
                    Rd_ID;
    wire    [5:0]   opcode,
                    funct;
    wire            Branch,
                    Hazard,
                    PCWrite;
    wire    [1:0]   ALUOp_ID;
    wire            RegDst_ID,
                    ALUSrc_ID, //EX
                    MemRead_ID,
                    MemWrite_ID, //M
                    MemtoReg_ID, //WB
                    RegWrite_ID; //for use
    wire    [31:0]  regReadData1_ID,
                    regReadData2_ID;
    wire    [31:0]  signExtend_ID;

    //EX
    wire    [1:0]   ALUOp_EX;
    wire            RegDst_EX,
                    ALUSrc_EX, //EX
                    MemRead_EX,
                    MemWrite_EX, //M
                    MemtoReg_EX, //WB
                    RegWrite_EX; //for use
    wire    [31:0]  regReadData1_EX,
                    regReadData2_EX,
                    signExtend_EX;
    wire    [4:0]   Rs_EX,
                    Rt_EX,
                    Rd_EX,
                    Dst_EX;

    wire    [1:0]   ForwardA,
                    ForwardB;
    wire    [31:0]  aluInA_EX,
                    aluInB_EX,
                    ForwardBOut_EX,
                    ALUResult_EX;
    wire    [3:0]   aluControl_EX;
    wire            aluzero_EX;

    //MEM
    wire            MemRead_MEM,
                    MemWrite_MEM, //M
                    MemtoReg_MEM, //WB
                    RegWrite_MEM; //for use
    wire    [31:0]  ALUResult_MEM,
                    ForwardBOut_MEM,
                    dmReadData_MEM;
    wire    [4:0]   Dst_MEM;

    //WB
    wire            MemtoReg_WB, //WB
                    RegWrite_WB; //for use
    wire    [31:0]  dmReadData_WB,
                    ALUResult_WB,
                    regWriteData_WB;
    wire    [4:0]   Dst_WB;

    /* Implement */
    //IF
    MUX_4x1 pcSrc_mux(
                .A0(pcAdd4_IF),
                .A1(jump_addr),
                .A2(branch_addr),
                .sel({isBranch,Jump}),
                .F(pcIn_IF)
            );
    PC pc(
           .clk(clk),
           .in(pcIn_IF),
           .out(pcOut_IF),
           .PCWrite(PCWrite)
       );
    assign pcAdd4_IF = pcOut_IF + 4;
    Inst_Mem im(
                 .R_addr(pcOut_IF),
                 .inst(inst_IF)
             );

    //IF_ID
    IF_ID ifid(
              .clk(clk),
              .IFID_Write(IFID_Write),
              .IF_Flush(IF_Flush),
              .pcAdd4_IF(pcAdd4_IF),
              .inst_IF(inst_IF),
              .pcAdd4_ID(pcAdd4_ID),
              .inst_ID(inst_ID)
          );

    //ID
    assign opcode = inst_ID[31:26];
    assign Rs_ID = inst_ID[25:21];
    assign Rt_ID = inst_ID[20:16];
    assign Rd_ID = inst_ID[15:11];
    assign funct = inst_ID[5:0];
    Hazard_Detection hazard_detect(
                         .Branch(Branch),
                         .MemRead_EX(MemRead_EX),
                         .RegWrite_EX(RegWrite_EX),
                         .RegWrite_MEM(RegWrite_MEM),
                         .MemRead_MEM(MemRead_MEM),
                         .Rs_ID(Rs_ID),
                         .Rt_ID(Rt_ID),
                         .Rt_EX(Rt_EX),
                         .Rd_EX(Rd_EX),
                         .Dst_MEM(Dst_MEM),
                         .IFID_Write(IFID_Write),
                         .Hazard(Hazard),
                         .PC_Write(PCWrite)
                     );
    Control control(
                .inst_31_26(opcode),
                .RegDst(RegDst_ID),
                .Jump(Jump),
                .Branch(Branch),
                .MemRead(MemRead_ID),
                .MemtoReg(MemtoReg_ID),
                .ALUOp(ALUOp_ID),
                .MemWrite(MemWrite_ID),
                .ALUSrc(ALUSrc_ID),
                .RegWrite(RegWrite_ID)
            );
    Reg_File_32 rf(
                    .clk(clk),
                    .R_reg1(Rs_ID),
                    .R_reg2(Rt_ID),
                    .W_reg(Dst_WB),
                    .W_data(regWriteData_WB),
                    .R_data1(regReadData1_ID),
                    .R_data2(regReadData2_ID),
                    .RegWrite(RegWrite_WB)
                );
    Sign_Extend signextend(
                    .in(inst_ID[15:0]),
                    .out(signExtend_ID)
                );
    assign branch_addr = (signExtend_ID << 2) + pcAdd4_ID;
    assign jump_addr = {pcAdd4_ID[31:28], (inst_ID[25:0] << 2)};
    assign equal = (regReadData1_ID == regReadData2_ID);
    Branch_Detection branch_detect(
                         .Branch(Branch),
                         .equal(equal),
                         .Hazard(Hazard),
                         .Jump(Jump),
                         .opcode(opcode),
                         .isBranch(isBranch),
                         .IF_Flush(IF_Flush)
                     );

    //ID_EX
    ID_EX idex(
              .clk(clk),
              .Hazard(Hazard),
              .ALUOp_ID(ALUOp_ID),
              .RegDst_ID(RegDst_ID),
              .ALUSrc_ID(ALUSrc_ID), //EX
              .MemRead_ID(MemRead_ID),
              .MemWrite_ID(MemWrite_ID), //M
              .MemtoReg_ID(MemtoReg_ID), //WB
              .RegWrite_ID(RegWrite_ID), //for use
              .regReadData1_ID(regReadData1_ID),
              .regReadData2_ID(regReadData2_ID),
              .signExtend_ID(signExtend_ID),
              .Rs_ID(Rs_ID),
              .Rt_ID(Rt_ID),
              .Rd_ID(Rd_ID),

              .ALUOp_EX(ALUOp_EX),
              .RegDst_EX(RegDst_EX),
              .ALUSrc_EX(ALUSrc_EX), //EX
              .MemRead_EX(MemRead_EX),
              .MemWrite_EX(MemWrite_EX), //M
              .MemtoReg_EX(MemtoReg_EX), //WB
              .RegWrite_EX(RegWrite_EX), //for use
              .regReadData1_EX(regReadData1_EX),
              .regReadData2_EX(regReadData2_EX),
              .signExtend_EX(signExtend_EX),
              .Rs_EX(Rs_EX),
              .Rt_EX(Rt_EX),
              .Rd_EX(Rd_EX)
          );

    //EX
    ALU_32 alu(
               .A(aluInA_EX),
               .B(aluInB_EX),
               .alu_control(aluControl_EX),
               .zero(aluzero_EX),
               .result(ALUResult_EX)
           );
    MUX_4x1 forwardA_mux(
                .A0(regReadData1_EX),
                .A1(regWriteData_WB),
                .A2(ALUResult_MEM),
                .sel(ForwardA),
                .F(aluInA_EX)
            );
    MUX_4x1 forwardB_mux(
                .A0(regReadData2_EX),
                .A1(regWriteData_WB),
                .A2(ALUResult_MEM),
                .sel(ForwardB),
                .F(ForwardBOut_EX)
            );
    assign aluInB_EX = ALUSrc_EX ? signExtend_EX : ForwardBOut_EX;
    ALU_control alu_ctrl(
                    .funct(signExtend_EX[5:0]),
                    .ALUOp(ALUOp_EX),
                    .alu_control(aluControl_EX)
                );
    Forwarding forward(
                   .Rs_ID(Rs_ID),
                   .Rt_ID(Rt_ID),
                   .Rs_EX(Rs_EX),
                   .Rt_EX(Rt_EX),
                   .Dst_MEM(Dst_MEM),
                   .Dst_WB(Dst_WB),
                   .RegWrite_MEM(RegWrite_MEM),
                   .RegWrite_WB(RegWrite_WB),
                   .ForwardA(ForwardA),
                   .ForwardB(ForwardB)
               );
    assign Dst_EX = RegDst_EX ? Rd_EX : Rt_EX;

    //EX_MEM
    EX_MEM exmem(
               .clk(clk),
               .MemRead_EX(MemRead_EX),
               .MemWrite_EX(MemWrite_EX), //M
               .MemtoReg_EX(MemtoReg_EX), //WB
               .RegWrite_EX(RegWrite_EX), //for use
               .ALUResult_EX(ALUResult_EX),
               .ForwardBOut_EX(ForwardBOut_EX),
               .Dst_EX(Dst_EX),

               .MemRead_MEM(MemRead_MEM),
               .MemWrite_MEM(MemWrite_MEM), //M
               .MemtoReg_MEM(MemtoReg_MEM), //WB
               .RegWrite_MEM(RegWrite_MEM), //for use
               .ALUResult_MEM(ALUResult_MEM),
               .ForwardBOut_MEM(ForwardBOut_MEM),
               .Dst_MEM(Dst_MEM)
           );

    //MEM
    Data_Mem dm(
                 .clk(clk),
                 .addr(ALUResult_MEM),
                 .W_data(ForwardBOut_MEM),
                 .R_data(dmReadData_MEM),
                 .MemWrite(MemWrite_MEM),
                 .MemRead(MemRead_MEM)
             );

    //MEM_WB
    MEM_WB memwb(
               .clk(clk),
               .MemtoReg_MEM(MemtoReg_MEM), //WB
               .RegWrite_MEM(RegWrite_MEM), //for use
               .dmReadData_MEM(dmReadData_MEM),
               .ALUResult_MEM(ALUResult_MEM),
               .Dst_MEM(Dst_MEM),

               .MemtoReg_WB(MemtoReg_WB), //WB
               .RegWrite_WB(RegWrite_WB), //for use
               .dmReadData_WB(dmReadData_WB),
               .ALUResult_WB(ALUResult_WB),
               .Dst_WB(Dst_WB)
           );

    //WB
    assign regWriteData_WB = MemtoReg_WB ? dmReadData_WB : ALUResult_WB;


endmodule
