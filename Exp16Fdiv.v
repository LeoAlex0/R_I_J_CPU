`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:48 12/06/2018 
// Design Name: 
// Module Name:    Exp16Fdiv 
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
module Exp16Fdiv(
	input CLK_in,
	input [30:0] n,
	input rst,
	output reg CLK_out
    );
	reg [30:0] counter;
	initial begin
		// Initialize Inputs
		counter = 0;

	end
	always@(posedge CLK_in or posedge rst)begin
		if(rst==1) begin
			CLK_out = 0;
			counter = 0;
		end
		else begin
			counter = counter+1;
			if(counter[30:0] == {1'b0,n[30:1]})begin
				CLK_out = 1;
			end
			if(counter[30:0] == n[30:0])begin
				CLK_out = 0;
				counter = 0;
			end
		end
	end


endmodule
