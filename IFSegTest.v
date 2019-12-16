`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:17:32 12/03/2019
// Design Name:   IFSeg
// Module Name:   E:/MyProjects/ISE/R_I_J_CPU/IFSegTest.v
// Project Name:  R_I_J_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IFSeg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module IFSegTest;

	// Inputs
	reg clk;
	reg rst;
	reg cond;
    reg stall;
	reg [31:0] condNPC;

	// Outputs
	wire [31:0] NPC;
	wire [31:0] IR;

	// Instantiate the Unit Under Test (UUT)
	IFSeg uut (
		.clk(clk), 
		.rst(rst), 
		.cond(cond), 
        .stall(stall),
		.condNPC(condNPC), 
		.NPC(NPC), 
		.IR(IR)
	);

	always #10 clk = ~clk;
	always #100 cond = ~cond;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		cond = 0;
        stall = 0;
		condNPC = 0;
		// Wait 100 ns for global reset to finish
		#100;
		condNPC = 1;
		#100;
		condNPC = 12;
		#100;
		condNPC = 123;
		#100;
		condNPC = 12345;
		#100;
		condNPC = 0;
		#100;
		condNPC = 2;
        
        #100;
        stall = 1;
		condNPC = 1;
		#100;
		condNPC = 12;
		#100;
		condNPC = 123;
		#100;
		condNPC = 12345;
		#100;
		condNPC = 0;
		#100;
		condNPC = 2;

        
		// Add stimulus here

	end
      
endmodule

