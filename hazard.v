`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:32 12/16/2019 
// Design Name:  
// Module Name:    hazard 
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

module hazard(
    input [31:0] IR_IF,
	 input clk,
    output hasHazard
    );

    wire [5:0] opcode_IF;
    wire [4:0] rs_IF, rt_IF;
    wire isLoad_IF, isStore_IF, isBranch_IF, isALUR_IF, isALUImm_IF;
    
	 integer regCounter,memCounter;
	 reg regCounterEnable,memCounterEnable;
	 
	 wire isRegRead,isRegWrite,isMemRead,isMemWrite;
	 assign isRegRead = 1'b1;
	 assign isRegWrite = isALUR_IF | isALUImm_IF;
	 assign isMemRead = isLoad_IF;
	 assign isMemWrite = isStore_IF;
	 
	 initial begin
		regCounter = 0;
		memCounter = 0;
		regCounterEnable = 1'b0;
		memCounterEnable = 1'b0;
	 end
	 
	 assign hasHazard = (regCounterEnable == 1'b1 && regCounter != 0 || memCounterEnable == 1'b1 && memCounter != 0)?1'b1:1'b0;
	 
	 always @ (negedge clk or posedge clk) begin
		//=====counter--;=======
		regCounter = (regCounter > 0)?regCounter-1:0;
		memCounter = (memCounter > 0)?memCounter-1:0;
		regCounterEnable <= (regCounter > 0)?regCounterEnable | isRegRead:1'b0;
		memCounterEnable <= (memCounter > 0)?memCounterEnable | isMemWrite:1'b0;
		
		if(isRegWrite) regCounter = 3;
		if(isMemRead) memCounter = 2;
	 
	 
	 end
	 
    InsAnalyser anysr_IF (
        .IR(IR_IF), 
        .opcode(opcode_IF), 
        .rs(rs_IF), 
        .rt(rt_IF), 
        .isBranch(isBranch_IF), 
        .isLoad(isLoad_IF), 
        .isStore(isStore_IF), 
        .isALUR(isALUR_IF), 
        .isALUImm(isALUImm_IF)
    );

endmodule
