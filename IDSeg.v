`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:52 11/05/2019 
// Design Name: 
// Module Name:    IDSeg 
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
module IDSeg(
    input clk,
    input rst,
    input [31:0] NPCi,
    input [31:0] IRi,
	 input WBFlag,
	 input [4:0] WBAddr,
	 input [31:0] WBVal,
    output reg [31:0] NPCo,
    output reg [31:0] IRo,
    output reg [31:0] A,
    output reg [31:0] B,
    output reg [31:0] Imm
    );
	 
	 reg [31:0] NPC,IR;
	 wire [31:0] wA,wB,wImm;
	 wire imm_s;
	 
	 always @ (negedge clk,posedge rst) begin
		if (rst) begin
			NPC <= 0;
			IR <= 0;
		end else begin
			NPC <= NPCi;
			IR <= IRi;
		end
	 end
	 
	 assign wImm = imm_s ? {IRi[15]?16'hffff:16'h0,IRi[15:0]} : {16'h0,IRi[15:0]};
	 always @ (posedge clk,posedge rst) begin
		if (rst) {NPCo,IRo,A,B,Imm} <= 0;
		else {NPCo,IRo,A,B,Imm} <= {NPCi,IRi,wA,wB,wImm};
	 end
	 
	 RegHeap regs(
		.clk(clk),
		.rst(rst),
		.addrA(IRi[25:21]),
		.addrB(IRi[20:16]),
		.addrW(WBAddr),
		.dataW(WBVal),
		.WriteReg(WBFlag),
		.dataA(wA),
		.dataB(wB)
	 );
	 
	 Controller (
		.opcode(IRi[31:26]),
		.funct(IRi[5:0]),
		.imm_s(imm_s)
	 );


endmodule
