`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:11:03 12/30/2019
// Design Name:   hazard
// Module Name:   E:/MyProjects/ISE/R_I_J_CPU/hazardTest.v
// Project Name:  R_I_J_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: hazard
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module hazardTest;

	// Inputs
	reg [31:0] IR;
	reg clk;

	// Outputs
	wire hasHazard;

	// Instantiate the Unit Under Test (UUT)
	hazard uut (
		.IR_IF(IR), 
		.clk(clk), 
		.hasHazard(hasHazard)
	);

always #100 clk = ~clk;

	initial begin
		// Initialize Inputs
		IR = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
      IR = 32'h8c01_0014;//reg read
		#100;
      IR = 32'h8c01_0014;
		#100;
      IR = 32'h8c01_0014;
		#100;
      IR = 32'h8c01_0014;
		#100;
      IR = 32'h8c01_0014;
		
		#100;
      IR = 32'h8c06_0015;
		#100;
      IR = 32'h0000_1820;//reg write
		#100;
      IR = 32'h8c06_0015;
		#100;
      IR = 32'h8c06_0015;
		
		#100;
      IR = 32'h0000_1820;
		#100;
		IR = 32'hffff_ffff;//nop
		#100;
      IR = 32'h8c06_0015;
		
		#100;
      IR = 32'h0000_1820;
		#100;
		IR = 32'hffff_ffff;//nop
		#100;
		IR = 32'hffff_ffff;//nop
		#100;
      IR = 32'h8c06_0015;
		
		#100;
      IR = 32'h0000_1020;
		#100;
      IR = 32'h0023_2022;
		#100;
      IR = 32'h0085_3027;
		#100;
      IR = 32'hac06_0016;
		#100;
      IR = 32'h10c7_fff8;
		// Add stimulus here

	end
      
endmodule

