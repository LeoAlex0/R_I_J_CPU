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
    input [31:0] IR_ID,
    output hasHazard
    );

    wire [5:0] opcode_IF, opcode_ID;
    wire [4:0] rs_IF, rs_ID, rt_IF, rt_ID;
    wire isLoad_IF, isStore_IF, isBranch_IF, isALUR_IF, isALUImm_IF;
    wire isLoad_ID;
    
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
    
    InsAnalyser anysr_ID (
        .IR(IR_ID), 
        .opcode(opcode_ID), 
        .rs(rs_ID), 
        .rt(rt_ID), 
        .isLoad(isLoad_ID)
    );
    
    assign hasHazard = ((isLoad_ID && isALUR_IF && rt_ID == rs_IF) 
                    || (isLoad_ID && isALUR_IF && rt_ID == rt_IF)
                    || (isLoad_ID && (isLoad_IF || isStore_IF || isALUImm_IF || isBranch_IF) && rt_ID == rs_IF)
                    ) ? 1'b1 : 1'b0;

endmodule
