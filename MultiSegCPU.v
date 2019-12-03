`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:42 11/05/2019 
// Design Name: 
// Module Name:    MultiSegCPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module MultiSegCPU(
    input clk,
    input rst,
    output ZF,
    output OF,
    output [31:0] F,
    output [31:0] Mem,
    output [31:0] PC
    );
    
    reg [31:0] NPC_IF, NPC_ID;
    reg [31:0] IR_IF, IR_ID, IR_EX, IR_MEM;
    reg [31:0] A_ID, B_ID, Imm_ID, B_EX, ALUo_MEM, LMD_MEM;
    reg [4:0] WB_Addr;
    reg cond_EX, cond_WB, WBFlag;
    
    IFSeg IFSeg_inst (
        .clk(clk),
        .rst(rst),
        .cond(cond_EX),
        .condNPC(F),
        .NPC(NPC_IF),
        .IR(IR_IF)
    );
    
    IDSeg IDSeg_inst (
        .clk(~clk), 
        .rst(rst), 
        .NPCi(NPC_IF), 
        .IR(IR_IF), 
        .WBFlag(WBFlag), 
        .WBAddr(WB_Addr), 
        .WBVal(WB_Data), 
        .NPCo(NPC_ID), 
        .IRo(IR_ID), 
        .A(A_ID), 
        .B(B_ID), 
        .Imm(Imm_ID)
    );

    EXSeg EXSeg_inst (
        .clk(clk), 
        .rst(rst), 
        .IRi(IR_ID), 
        .NPCi(NPC_ID), 
        .Ai(A_ID), 
        .Bi(B_ID), 
        .Immi(Imm_ID), 
        .cond(cond_EX), 
        .ALUo(F),
        .ZFo(ZF),
        .OFo(OF),
        .Bo(B_EX), 
        .IRo(IR_EX)
    );
    
    MEMSeg MEMSeg_inst (
        .clk(~clk), 
        .rst(rst), 
        .B_i(B_EX), 
        .ALUo_In_i(F), 
        .IR_i(IR_EX), 
        .ALUo_Out(ALUo_MEM), 
        .LMD(LMD_MEM), 
        .IR_Out(IR_MEM)
    );

    WBSeg WBSeg_inst (
        .clk(clk), 
        .rst(rst), 
        .LMD_i(LMD_MEM), 
        .ALUo_i(ALUo_MEM), 
        .IR_i(IR_MEM), 
        .cond_i(cond_EX), 
        .WB_Data(WB_Data), 
        .WB_Write(WBFlag), 
        .WB_Addr(WB_Addr), 
        .cond(cond_WB)
    );
    
endmodule
