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
    output [5:0] opcode,
    output [5:0] funct,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output isBranch,
	output isLoad,
	output isStore,
	output isALUR,
	output isALUImm,
    output isNop
    );
	 
	// IR
	assign {opcode, rs, rt, rd, shamt, funct} = IR;
	
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
	assign isALUR = (opcode == 6'b000_000 && funct != 6'b000_000)? 1'b1 : 1'b0;
	assign isALUImm = ((opcode == 6'b001_000) ||
						(opcode == 6'b001_100) ||
						(opcode == 6'b001_110) ||
						(opcode == 6'b001_011)) ? 1'b1 : 1'b0;
    assign isNop = (opcode == 6'b111_111);
    
	 //controller
	Controller controller(
        .opcode(opcode),
        .funct(funct),
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

module Decoder(
        input [31:0] inst,          // ??
        output [4:0] read0,     // ?????(0??)
        output [4:0] read1,
        output [4:0] write,         // ?????(0??)
        output isR,                 // R???
        output isI,                 // I???
        output isJ,                 // J???
        output isLd,                // ?????
        output isSt,                // ?????
        output isCond,              // ???????
        output [31:0] imme,         // ???????(0??)
        output reg [2:0] aluOP         // ALU???
    );


    wire [5:0] opcode,func;
    wire [4:0] rs,rt,rd,shamt;
    wire IsR,IsI,IsJ,IsLd,IsSt;
    
    assign {opcode,rs,rt,rd,shamt,func} = inst;

    assign IsR  = opcode == 6'b0;                   // R???opcode???0
    assign IsI  = opcode[5:3] == 3'b1 
        || opcode[5:2] == 4'b1 || IsLd || IsSt;     // I???
    assign IsJ  = opcode[5:1] == 5'b1;               // J???
    assign IsLd = opcode == 6'b100_011;              // lw
    assign IsSt = opcode == 6'b101_011;              // sw
    assign imme = (IsI || IsLd || IsSt) ? 
        {(IsLd || IsSt || opcode == 6'b001_000) ? {16{inst[15]}} : 16'b0, inst[15:0]} : 32'b0;       // ???imme,0??
    assign read0 = !IsJ ? rs : 5'b0;
    assign read1 = !IsJ ? rt : 5'b0;
    assign write   = IsR ? rd : ((IsI || IsLd) ? rt : 5'b0);

    always @ (*) begin
        if (IsR)
            case (func)
                6'b100_000: aluOP = 3'b100;             // add
                6'b100_010: aluOP = 3'b101;             // sub
                6'b100_1xx: aluOP = {1'b0,func[1:0]};   // and/or/xor/nor
                6'b101_011: aluOP = 3'b110;             // sltu
                6'b000_100: aluOP = 3'b111;             // sllv
                default:    aluOP = 3'b000;             // default: add
            endcase
        else if (IsI && opcode[5:2] != 4'b1)            // ????I???
            case (opcode[2:0])
                3'b000:  aluOP = 3'b100;                 // addi
                3'b1xx:  aluOP = {1'b0,opcode[1:0]};     // andi/xori
                3'b011:  aluOP = 3'b110;                 // sltiu
                default: aluOP = 3'b000;                 // default: add
            endcase
        else if (opcode[5:2] == 4'b1) aluOP = 3'b010;    // ???I???,??
        else aluOP = 3'b000;
    end

    assign isR    = IsR;
    assign isI    = IsI;
    assign isJ    = IsJ;
    assign isLd   = IsLd;
    assign isSt   = IsSt;
    assign isCond = opcode[5:2] == 4'b1 || opcode[5:1] == 5'b1;
endmodule