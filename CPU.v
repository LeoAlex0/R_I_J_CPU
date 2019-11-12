`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:38:19 05/20/2019 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
    input clk,
    input rst,
    output ZF,
    output OF,
    output [31:0] F,
    output [31:0] Mem,
    output [31:0] PC
    );

    wire [31:0] nextPC,inst;
    reg [31:0] newPC;
    
    wire [5:0] opcode,funct;
    wire [4:0] rs,rt,rd,shamt;
    wire [15:0] imm;
    wire [25:0] addr;
    
    reg [4:0] rd_rt_ra;
    reg [31:0] f_mem_pc;
    wire [31:0] dataA,dataB;
    
    wire [31:0] f,imme,b_imme;
    
    wire [31:0] mem;
    
    wire [2:0] ALU_OP;
    wire [1:0] rd_rt_ra_s;
    wire [1:0] f_mem_pc_s;
    wire [1:0] pc_jr_b_ja_s;
    wire WriteReg;
    wire b_imme_s;
    wire imme_s;
    wire MemWrite;
    
    assign PC = nextPC;
    
    InstGetter getter (
        .clk(clk),
        .rst(rst),
        .newPC(newPC),
        .inst(inst),
        .nextPC(nextPC)
    );
    
    assign {opcode,rs,rt,rd,shamt,funct} = inst; // R
    assign imm = inst[15:0]; // I
    assign addr = inst[25:0]; // J
    
    always @(*)
        case (pc_jr_b_ja_s)
            2'b00 : newPC = nextPC;
            2'b01 : newPC = dataA;
            2'b10 : newPC = nextPC + (imme<<2);
            default: newPC = {nextPC[31:28],addr,2'b00};
        endcase
        
    reg [4:0] lastAddrW;
    reg [1:0] lastFMemPC_s;
    reg lastWriteReg;
    reg [31:0] lastF,lastPC;
    
    always @(negedge clk) 
        {lastAddrW,lastFMemPC_s,lastWriteReg,lastF,lastPC} <= {rd_rt_ra,f_mem_pc_s,WriteReg,f,nextPC};
    
    RegHeap regs (
        .clk(clk),
        .rst(rst),
        .WriteReg(lastWriteReg),
        .addrA(rs),
        .addrB(rt),
        .addrW(rd_rt_ra),
        .dataW(f_mem_pc),
        .dataA(dataA),
        .dataB(dataB)
    );
    
    always @(*)
        case (rd_rt_ra_s)
            2'b00 : rd_rt_ra = rd;
            2'b01 : rd_rt_ra = rt;
            2'b10 : rd_rt_ra = 5'h1f;
            default: rd_rt_ra = 5'b0;
        endcase
    
    always @(*)
        case (lastFMemPC_s)
            2'b00 : f_mem_pc = lastF;
            2'b01 : f_mem_pc = mem;
            2'b10 : f_mem_pc = lastPC;
            default: f_mem_pc = 32'h0;
        endcase
    
    SimpleALU alu (
        .ALU_OP(ALU_OP),
        .A(dataA),
        .B(b_imme),
        .ZF(ZF),
        .OF(OF),
        .F(f)
    );
    
    assign imme = imme_s ? {imm[15]?16'hffff:16'h0,imm} : {16'h0,imm};
    assign b_imme = b_imme_s ? imme : dataB;
    assign F=f;
    assign Mem=mem;
    
    RAM memory (
        .clka(~clk), // input clka
        .wea(MemWrite), // input [0 : 0] wea
        .addra(F[15:2]), // input [13 : 0] addra
        .dina(dataB), // input [31 : 0] dina
        .douta(mem) // output [31 : 0] douta
    );
    
    /*
    output [1:0] w_r_s,
    output imm_s,
    output [1:0] w_r_data_s,
    output rt_imm_s,
    output [2:0] ALU_OP,
    output MemWrite,
    output [1:0] PC_s
    */
    
    Controller controller(
        .opcode(opcode),
        .funct(funct),
        .ZF(ZF),
        .w_r_s(rd_rt_ra_s),
        .imm_s(imme_s),
        .w_r_data_s(f_mem_pc_s),
        .rt_imm_s(b_imme_s),
        .ALU_OP(ALU_OP),
        .WriteReg(WriteReg),
        .MemWrite(MemWrite),
        .PC_s(pc_jr_b_ja_s)
    );
    
endmodule
