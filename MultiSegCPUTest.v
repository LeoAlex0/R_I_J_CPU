`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:30:02 12/17/2019
// Design Name:   MultiSegCPU
// Module Name:   C:/Users/codgi/Documents/GitHub/R_I_J_CPU/MultiSegCPUTest.v
// Project Name:  R_I_J_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MultiSegCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MultiSegCPUTest;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire ZF;
	wire OF;
	wire [31:0] F;
	wire [31:0] Mem;
	wire [31:0] PC;
    
    wire hasHazard;

	// Instantiate the Unit Under Test (UUT)
	MultiSegCPU uut (
		.clk(clk), 
		.rst(rst), 
		.ZF(ZF), 
		.OF(OF), 
		.F(F), 
		.Mem(Mem), 
		.PC(PC),
        .hasHazard(hasHazard)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
    
    always #10 clk = ~clk;
      
endmodule

