`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:00:35 11/05/2019 
// Design Name: 
// Module Name:    IFSeg 
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
module IFSeg(
    input clk,
	input rst,
    input cond,
    input [31:0] condNPC,
    output [31:0] NPC,
    output [31:0] IR
    );
	 
	 wire [31:0] realNPC,nextPC;
	 assign realNPC = cond ? nextPC : condNPC;
	 assign NPC = realNPC;
	 
	 InstGetter instMem(
		.clk(clk),
		.rst(rst),
		.newPC(realNPC),
		.inst(IR),
		.nextPC(nextPC)
	 );

endmodule
