`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:18:21 12/03/2019
// Design Name:   MEMSeg
// Module Name:   E:/MyProjects/ISE/R_I_J_CPU/MEMSegTest.v
// Project Name:  R_I_J_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MEMSeg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MEMSegTest;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] B_i;
	reg [31:0] ALUo_In_i;
	reg [31:0] IR_i;

	// Outputs
	wire [31:0] ALUo_Out;
	wire [31:0] LMD;
	wire [31:0] IR_Out;

	// Instantiate the Unit Under Test (UUT)
	MEMSeg uut (
		.clk(clk), 
		.rst(rst), 
		.B_i(B_i), 
		.ALUo_In_i(ALUo_In_i), 
		.IR_i(IR_i), 
		.ALUo_Out(ALUo_Out), 
		.LMD(LMD), 
		.IR_Out(IR_Out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		B_i = 0;
		ALUo_In_i = 0;
		IR_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

