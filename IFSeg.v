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
    input stall,
    input [31:0] condNPC,
    output [31:0] NPC,
    output [31:0] IRo,
    output [31:0] PCo
    );
	
    wire [31:0] IR;
    wire [31:0] realNPC, nextPC;
    wire clk1;
    assign realNPC = cond ? condNPC : nextPC;
    assign NPC = realNPC;
    assign clk1 = stall ? 1'b1 : clk;
    assign IRo = stall ? 32'b0 : IR;

    InstGetter instMem(
        .clk(clk1),
        .rst(rst),
        .newPC(realNPC),
        .inst(IR),
        .nextPC(nextPC),
        .PCo(PCo)
    );

endmodule