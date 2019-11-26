`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:04 11/18/2019 
// Design Name: 
// Module Name:    InsAnalyser 
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
module InsAnalyser(
	input [31:0] IR,
    output isBranch,
	output isLoad,
	output isStore,
	output isALUR,
	output isALUImm
    );
	 
	// IR
	wire [5:0] opcode,funct;
    wire [4:0] rs,rt,rd,shamt;
	assign {opcode,rs,rt,rd,shamt,funct} = IR;
	
    // Controller result
	wire [2:0] ALU_OP;
    wire [1:0] rd_rt_ra_s;
    wire [1:0] f_mem_pc_s;
    wire [1:0] pc_jr_b_ja_s;
    wire WriteReg;
    wire rt_imm_s;
    wire imme_s;
    wire MemWrite;
	
    // Output
    assign isBranch = ((opcode == 6'b000100) ||
                        (opcode == 6'b00101)) ? 1'b1 : 1'b0;
	assign isLoad = (opcode == 6'b100_011)?1'b1 : 1'b0;
	assign isStore = (opcode == 6'b101_011)? 1'b1 : 1'b0;
	assign isALUR = (opcode == 6'b000_000)? 1'b1 : 1'b0;
	assign isALUImm = ((opcode == 6'b001_000) ||
						(opcode == 6'b001_100) ||
						(opcode == 6'b001_110) ||
						(opcode == 6'b001_011)) ? 1'b1 : 1'b0;
	 //controller
	Controller controller(
        .opcode(opcode),
        .funct(funct),
        .ZF(ZF),
        .w_r_s(rd_rt_ra_s),
        .imm_s(imme_s),
        .w_r_data_s(f_mem_pc_s),
        .rt_imm_s(rt_imm_s),
        .ALU_OP(ALU_OP),
        .WriteReg(WriteReg),
        .MemWrite(MemWrite),
        .PC_s(pc_jr_b_ja_s)
    );

endmodule
