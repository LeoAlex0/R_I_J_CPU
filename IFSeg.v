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
    output [31:0] IR1o,
    output [31:0] PCo
    );
	
    reg [31:0] lastIR;
    wire [31:0] realNPC, nextPC, IR_wire;
    assign realNPC = cond ? condNPC : nextPC;
    assign NPC = realNPC;
    assign IR1o = lastIR;
    assign IRo = IR_wire;
    
    always @(posedge clk,posedge rst) begin
        if (rst) lastIR <= 32'hFFFF_FFFF;
        else lastIR <= IR_wire;
    end
    
    InstGetter instMem(
        .clk(clk),
        .rst(rst),
        .stall(stall),
        .newPC(realNPC),
        .inst(IR_wire),
        .nextPC(nextPC),
        .PCo(PCo)
    );

endmodule