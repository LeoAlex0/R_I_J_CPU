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
    
    //output [2:0] ALU_OP,
    //output [5:0] opcode, funct
    );
    
    reg [31:0] A, B, IR;
    wire [2:0] ALU_OP;
    wire [5:0] opcode, funct;
    wire isALUR, isBranch;
    
    initial begin
        A <= 32'b0;
        B <= 32'b0;
        IR <= 32'b0;
    end
    
    assign Bo = B;
    assign IRo = IR;
    
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
        .A(A),
		.B(B),
		.ZF(ZFo),
		.OF(OFo),
        .F(ALUo)
    );

    assign cond = (Ai == 0 ? 1'b1 : 1'b0);
   
    always @ (negedge clk or posedge rst) begin
        if (rst) begin
            IR <= 32'b0;
            A <= 32'b0;
            B <= 32'b0;
        end else begin
            IR <= IRi;
       
            // MUX-2
            if (isBranch) begin  
                A <= NPCi;
            end else begin
                A <= Ai;
            end
           
            // MUX-3
            if (isALUR) begin   
                B <= Bi;
            end else if (isBranch) begin
                B <= (Immi << 2);
            end else begin
                B <= Immi;
            end
        end
    end

endmodule
