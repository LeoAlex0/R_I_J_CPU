`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:36:18 05/20/2019
// Design Name:   CPU
// Module Name:   /home/extra-home/leo/IC/R_I_J_CPU/TestBench.v
// Project Name:  R_I_J_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire ZF;
	wire OF;
	wire [31:0] F,Mem,PC;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.rst(rst), 
		.ZF(ZF), 
		.OF(OF), 
		.F(F),
        .Mem(Mem),
        .PC(PC)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
        #1 rst=0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        
        while (1) #5 clk = !clk;
	end
endmodule

