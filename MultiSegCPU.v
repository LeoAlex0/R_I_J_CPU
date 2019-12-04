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
    input clk, // 全局时钟
    input rst
    );
    wire [31:0] IR[4],NPC[2],A,B[2],Imm,ALUo,MemData,CondPC,WBVal;
    wire [4:0] WBAddr;
    wire Cond,RegWrite;
    
    reg clks[5]; // 每一段的时钟
    reg [31:0] 
    
    IFSeg getter(
        .clk(clks[0]),
        .rst(rst),

    );

endmodule
