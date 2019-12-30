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
    
    wire [4:0] read0_IF, read1_IF;
    wire [4:0] write_ID;
    
    Decoder dec_IF (
        .inst(IR_IF),
        .read0(read0_IF),
        .read1(read1_IF)
    );
    
    Decoder dec_ID (
        .inst(IR_ID),
        .write(write_ID)
    );
    
    
    assign hasHazard = IR_IF != 32'hFFFF_FFFF && IR_ID != 32'hFFFF_FFFF
            && write_ID != 5'b0 && (write_ID == read0_IF || write_ID == read1_IF);    
    
    /*
    wire [5:0] opcode_IF, opcode_ID;
    wire [4:0] rs_IF, rs_ID, rt_IF, rt_ID, rd_IF, rd_ID;
    wire isLoad_IF, isStore_IF, isBranch_IF, isALUR_IF, isALUImm_IF;
    wire isLoad_ID, isALUR_ID, isALUImm_ID;

    
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
        .rd(rd_IF),
        .isBranch(isBranch_IF), 
        .isLoad(isLoad_IF), 
        .isStore(isStore_IF), 
        .isALUR(isALUR_IF), 
        .isALUImm(isALUImm_IF)
    );
    
    InsAnalyser anysr_ID (
        .IR(IR_ID), 
        .opcode(opcode_ID), 
        .rs(rs_ID), 
        .rt(rt_ID), 
        .rd(rd_ID),
        .isLoad(isLoad_ID),
        .isALUR(isALUR_ID),
        .isALUImm(isALUImm_ID)
    );
    
    assign hasHazard = ((isLoad_ID && isALUR_IF && rt_ID == rs_IF) 
                    || (isLoad_ID && isALUR_IF && rt_ID == rt_IF)
                    || (isLoad_ID && (isLoad_IF || isStore_IF || isALUImm_IF || isBranch_IF) && rt_ID == rs_IF)
                    || (isALUR_ID && isALUR_IF && (rd_ID == rs_IF || rd_ID == rt_IF))
                    || (isALUImm_ID && (isALUR_IF || isALUImm_IF) && (rt_ID == rs_IF || rt_ID == rt_IF))
                    ) ? 1'b1 : 1'b0;
    */
    

endmodule
