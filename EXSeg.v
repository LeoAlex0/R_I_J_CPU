`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:25 11/19/2019 
// Design Name: 
// Module Name:    EXSeg 
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

module EXSeg(
    input clk,
    input rst,
	input [31:0] IRi,
    input [31:0] NPCi,
	input [31:0] Ai,
	input [31:0] Bi,
    input [31:0] Immi,
    output cond,
    output [31:0] ALUo,
    output ZFo, OFo,
    output [31:0] Bo,
    output [31:0] IRo
    );
    
    reg [31:0] A, B, IR, Imm, NPC;
    wire [2:0] ALU_OP;
    wire [5:0] opcode, funct;
    wire isALUR, isBranch;
    
    assign Bo = B;
    assign IRo = IR;
    
    initial begin
        A <= 32'b0;
        B <= 32'b0;
        IR <= 32'hFFFF_FFFF;
    end
    
    // Instruction Analyzer
    InsAnalyser analyser_inst (
        .IR(IR), 
        .opcode(opcode),
        .funct(funct),
        .isBranch(isBranch),
        .isALUR(isALUR)
    );
    
    // Controller
    Controller ctrl (
        .opcode(opcode),
        .funct(funct),
        .ALU_OP(ALU_OP)
    );
    
     // ALU
    SimpleALU alu (
        .ALU_OP(ALU_OP),
        .A(isBranch ? NPC : A),
		.B(isALUR ? B : isBranch ? (Imm << 2) : Imm),
		.ZF(ZFo),
		.OF(OFo),
        .F(ALUo)
    );

    assign cond = (A == 0 ? 1'b1 : 1'b0);
       
    always @ (negedge clk or posedge rst) begin
        if (rst) begin
            IR <= 32'hFFFF_FFFF;
            A <= 32'b0;
            B <= 32'b0;
            Imm <= 32'b0;
            NPC <= 32'b0;
        end else begin
            IR <= IRi;
            A <= Ai;
            B <= Bi;
            Imm <= Immi;
            NPC <= NPCi;
        end
    end

endmodule
