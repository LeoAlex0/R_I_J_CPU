`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:17:55 12/03/2019
// Design Name:   EXSeg
// Module Name:   E:/MyProjects/ISE/R_I_J_CPU/ExSegTest.v
// Project Name:  R_I_J_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: EXSeg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ExSegTest;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] IRi;
	reg [31:0] NPCi;
	reg [31:0] Ai;
	reg [31:0] Bi;
	reg [31:0] Immi;

	// Outputs
	wire cond, ZFo, OFo;
	wire [31:0] ALUo;
	wire [31:0] Bo;
	wire [31:0] IRo;
    
    //wire [2:0] ALU_OP;
    //wire [5:0] opcode, funct;
	
	// Instantiate the Unit Under Test (UUT)
	EXSeg uut (
		.clk(clk), 
		.rst(rst), 
		.IRi(IRi), 
		.NPCi(NPCi), 
		.Ai(Ai), 
		.Bi(Bi),
		.Immi(Immi), 
		.cond(cond), 
		.ALUo(ALUo), 
        .ZFo(ZFo),
        .OFo(OFo),
		.Bo(Bo), 
		.IRo(IRo)
        
        
        //.ALU_OP(ALU_OP),
        //.opcode(opcode),
        //.funct(funct)
	);
	
	always #10 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		IRi = 0;
		NPCi = 0;
		Ai = 0;
		Bi = 0;
		Immi = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        
        
		// Add stimulus here
        IRi = 32'b000000_00000_00000_00000_00000_100000;    // Add
        Ai = 32'b00000000_00000000_00000000_00000001;
        Bi = 32'b00000000_00000000_00000000_00000011;
        
        #20;
        IRi = 32'b001000_00000_00000_00000_00000_000000;    // Addi
        Ai = 32'b00000000_00000000_00000000_00000001;
        Bi = 32'b00000000_00000000_00000000_00000011;
        Immi = 32'b00000000_00000000_00000000_00000111;
        
       
        
	end
      
endmodule

