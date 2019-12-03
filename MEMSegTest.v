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
	
	always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		B_i = 123;
		ALUo_In_i = 321;
		IR_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
      IR_i = 32'b000000_00000_00000_00000_00000_100000;

		// Wait 100 ns for global reset to finish
		#100;
      IR_i = 32'b101010_00000_00000_00000_00000_000000;
		#100;
      IR_i = 32'b001000_00000_00000_00000_00000_000000;
		#100;
      IR_i = 32'b001100_00000_00000_00000_00000_000000;
		#100;
      IR_i = 32'b000000_00000_00000_00000_00000_000000;
		#100;
      IR_i = 32'b100011_00000_00000_00000_00000_000000;
		#100;
      IR_i = 32'b000000_00000_00000_00000_00000_000000;
		#100;
      IR_i = 32'b101011_00000_00000_00000_00000_000000;
	    #100;
      IR_i = 32'b000010_00000_00000_00000_00000_100000;

	end
      
endmodule

