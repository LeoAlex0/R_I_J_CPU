`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:35:36 11/18/2019 
// Design Name: 
// Module Name:    MEMReg 
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
module MEMReg(
	input clk,
	input rst,
	input [31:0] B_i,
	input [31:0] ALUo_In_i,
	input [31:0] IR_i,
	
	output [31:0] ALUo_Out,
	output [31:0] LMD,
	output [31:0] IR_Out
    );
	 
	reg [31:0] B;
	reg [31:0] ALUo_In;
	reg [31:0] IR;
	
	reg dev_null;
	
	initial begin
		B = 0;
		ALUo_In = 0;
		IR = 0;
	end
	
	assign IR_Out = IR;
	assign ALUo_Out = ALUo_In;
	//op type
	 wire isALU;
	 wire isLoad;
	 wire isStore;
	 wire isALUR;
	 wire isALUImm;
	 assign isALU = isALUR|isALUImm;
	 
	InsAnalyser analyser(
		.IR(IR),
		.isLoad(isLoad),
		.isStore(isStore),
		.isALUR(isALUR),
		.isALUImm(isALUImm)
	 );
	 
	 
	 //counter
	 wire i_can_write;
	 assign i_can_write = (i==max-1)?1'b1:1'b0;
	 integer i = 0;
	 integer max = 3;
	 
	 //control
	 always@(negedge clk or posedge rst) begin
		if(rst) begin
			i=0;
			B=0;
			ALUo_In=0;
			IR=0;
		end
		else begin
			i=i+1;
			if(i>=max) begin
				i=0;
			end
			
			if(!clk)begin
				B=B_i;
				ALUo_In=ALUo_In_i;
				IR=IR_i;
			end
			else begin
				dev_null=1'b0;
			end
		end
	 end
	 
	
	
	 RAM memory (
        .clka(~clk), // input clka
        .wea(isStore&i_can_write), // input [0 : 0] wea
        .addra(ALUo_In[15:2]), // input [13 : 0] addra
        .dina(B), // input [31 : 0] dina
        .douta(LMD) // output [31 : 0] douta
    );
endmodule
