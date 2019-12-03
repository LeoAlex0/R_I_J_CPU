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
    output reg cond,
    output reg [31:0] ALUo,
    output reg ZFo, OFo,
    output reg [31:0] Bo,
    output reg [31:0] IRo
    );
    
    reg [31:0] A, B, F, IR;
    reg [2:0] ALU_OP;
    reg ZF, OF, isALUR, isBranch;
    
    // ALU
    SimpleALU alu (
        .ALU_OP(ALU_OP),
        .A(A),
		.B(B),
		.ZF(ZF),
		.OF(OF),
        .F(F)
    );

    // Instruction Analyzer
    
    InsAnalyser analyser_inst (
        .IR(IR), 
        .isBranch(isBranch), 
        .isALUR(isALUR)
    );
   
    always @ (negedge clk, posedge rst) begin
        if (rst) begin
            IR <= 0;
        end else begin
            IR <= IRi;
        end
        
        // MUX-2
        if (isBranch) begin     // branch
            A <= NPCi;
        end else begin
            A <= Ai;
        end
       
        // MUX-3
        if (isALUR) begin     // R: opcode == 0
            B <= Bi;
        end else begin
            B <= Immi;
        end
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            {cond, ALUo, ZFo, OFo, Bo, IRo} <= 0;
        end else begin
            {cond, ALUo, ZFo, OFo, Bo, IRo} <= {(Ai == 0), F, ZF, OF, Bi, IR};
        end
    end

endmodule
