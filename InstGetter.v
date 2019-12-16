`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:24:16 05/14/2019 
// Design Name: 
// Module Name:    InstGetter 
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
module InstGetter(
    input clk,
    input rst,
    input [31:0] newPC,
    output [31:0] inst,
    output [31:0] nextPC,
    output reg [31:0] PC
    );
    
    initial PC <= 0;
    assign nextPC = PC + 4;

    InstROM rom (
        .clka(clk), // input clka
        .addra(PC), // input [31 : 0] addra
        .douta(inst) // output [31 : 0] douta
    );
    
    always @ (negedge clk, posedge rst)
        if (rst) PC <= 0;
        else PC <= newPC;
    
endmodule
