`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:14:09 12/03/2019
// Design Name:   IDSeg
// Module Name:   E:/MyProjects/ISE/R_I_J_CPU/IDSegTest.v
// Project Name:  R_I_J_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IDSeg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module IDSegTest;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] NPCi;
	reg [31:0] IR;
	reg WBFlag;
	reg [4:0] WBAddr;
	reg [31:0] WBVal;

	// Outputs
	wire [31:0] NPCo;
	wire [31:0] IRo;
	wire [31:0] A;
	wire [31:0] B;
	wire [31:0] Imm;

	// Instantiate the Unit Under Test (UUT)
	IDSeg uut (
		.clk(clk), 
		.rst(rst), 
		.NPCi(NPCi), 
		.IR(IR), 
		.WBFlag(WBFlag), 
		.WBAddr(WBAddr), 
		.WBVal(WBVal), 
		.NPCo(NPCo), 
		.IRo(IRo), 
		.A(A), 
		.B(B), 
		.Imm(Imm)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		NPCi = 0;
		IR = 0;
		WBFlag = 0;
		WBAddr = 0;
		WBVal = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

