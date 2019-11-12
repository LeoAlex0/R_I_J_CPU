`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:32 04/14/2019 
// Design Name: 
// Module Name:    Regheap 
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
module RegHeap(
    input [4:0] addrA,
    input [4:0] addrB,
    input [4:0] addrW,
    input [31:0] dataW,
    input WriteReg,
    input clk,
    input rst,
    output [31:0] dataA,
    output [31:0] dataB
    );

    reg [31:0] heap[31:0];
    assign dataA = heap[addrA];
    assign dataB = heap[addrB];
    
    integer i;
    
    initial for (i=0;i<32;i=i+1) heap[i] <= 0;
    
    always @(posedge clk or posedge rst)
        if (rst) for (i=0;i<32;i=i+1) heap[i] <=0;
        else if (WriteReg && addrW) heap[addrW] <= dataW;
    
endmodule
