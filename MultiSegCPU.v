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
    input rst
    );
    wire [31:0] IR[4],NPC[2],A,B[2],Imm,ALUo,MemData;
    wire Cond,RegWrite;

    IFSeg (
    );
    IDSeg(
    );
    ExSeg(
    );
    MemSeg(
    );
    WBSeg(
    );

endmodule
