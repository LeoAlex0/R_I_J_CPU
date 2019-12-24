`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:00:59 12/24/2019 
// Design Name: 
// Module Name:    IS 
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
module IS(
    input clk,
    input rst,
    input [31:0] IRi,
    output [31:0] IRo
    );
    

    reg [31:0] IR;
    
    always @ (negedge clk or posedge rst) begin
        
    end

endmodule
