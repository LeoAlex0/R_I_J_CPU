`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:23 11/18/2019 
// Design Name: 
// Module Name:    WBReg 
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
module WBSeg(
	input clk,
	input rst,
	input [31:0] LMD_i,
	input [31:0] ALUo_i,
	input [31:0] IR_i,
	input [31:0] cond_i,
	
	output [31:0] WB_Data,
	output WB_Write,
	output [4:0] WB_Addr,
	output reg cond
    );
	 
	 reg [31:0] LMD;
	 reg [31:0] ALUo;
	 reg [31:0] IR;
	 
	 reg dev_null;
	 
	 initial begin
		LMD = 0;
		ALUo = 0;
		IR = 0;
		cond = 1'b0;
	 end
	 
	 wire [5:0] opcode,funct;
    wire [4:0] rs,rt,rd,shamt;
	 assign {opcode,rs,rt,rd,shamt,funct} = IR;
	 //op type
	 wire isLoadStore;
	 wire isLoad;
	 wire isStore;
	 wire isALUR;
	 wire isALUImm;
	 assign isLoadStore = isLoad|isStore;

	//MUX and Outputs
	 wire useRt;
	 wire dontWriteInOtherIns;
	 assign useRt = isALUImm|isLoadStore;//use rt or rd
	 assign dontWriteInOtherIns = ~(isALUR|isALUImm|isLoadStore); //disable write_sign in other inst
	 assign WB_Data = (isLoadStore)?LMD:ALUo;//MUX4
	 assign WB_Addr = (useRt)?rt:rd;
	 assign WB_Write = ~dontWriteInOtherIns;
	 
	 
	 //control
	 always@(negedge clk or posedge rst) begin
	   if(rst) begin
			LMD = 0;
			ALUo = 0;
			IR = 0;
			cond = 1'b0;
		end
		else begin
			if(!clk)begin
				LMD=LMD_i;
				ALUo=ALUo_i;
				IR=IR_i;
				cond=cond_i;
			end
			else begin
				dev_null=1'b0;
			end
		end
	 end
	 
	 InsAnalyser analyser(
		.IR(IR),
		.isLoad(isLoad),
		.isStore(isStore),
		.isALUR(isALUR),
		.isALUImm(isALUImm)
	 );

endmodule
