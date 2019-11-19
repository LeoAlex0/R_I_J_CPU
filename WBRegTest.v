`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:14:16 11/18/2019
// Design Name:   WBReg
// Module Name:   E:/MyProjects/ISE/R_I_J_CPU/WBRegTest.v
// Project Name:  R_I_J_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: WBReg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module WBRegTest;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] LMD;
	reg [31:0] ALUo;
	reg [31:0] IR;

	// Outputs
	wire [31:0] WB_Data;
	wire WB_Write;
	wire [4:0] WB_Addr;

	// Instantiate the Unit Under Test (UUT)
	WBReg uut (
		.clk(clk), 
		.rst(rst), 
		.LMD(LMD), 
		.ALUo(ALUo), 
		.IR(IR), 
		.WB_Data(WB_Data), 
		.WB_Write(WB_Write), 
		.WB_Addr(WB_Addr)
	);

always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		LMD = 123;
		ALUo = 456;
		IR = 32'b000000_00000_00000_00000_00000_100000;

		// Wait 100 ns for global reset to finish
		#100;
      IR = 32'b101010_00000_00000_00000_00000_000000;
		#100;
      IR = 32'b001000_00000_00000_00000_00000_000000;
		#100;
      IR = 32'b001100_00000_00000_00000_00000_000000;
		#100;
      IR = 32'b000000_00000_00000_00000_00000_000000;
		#100;
      IR = 32'b100011_00000_00000_00000_00000_000000;
		#100;
      IR = 32'b000000_00000_00000_00000_00000_000000;
		#100;
      IR = 32'b101011_00000_00000_00000_00000_000000;
		// Add stimulus here

	end
      
endmodule

