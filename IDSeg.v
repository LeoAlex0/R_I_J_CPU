`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:52 11/05/2019 
// Design Name: 
// Module Name:    IDSeg 
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

module IDSeg(
    input clk,
    input rst,
    input [31:0] NPCi,
    input [31:0] IR,        // IF :: Instruction
    input WBFlag,
    input [4:0] WBAddr,     // Writeback :: Reg Addr
    input [31:0] WBVal,     // Writeback :: Reg value
    output [31:0] NPCo,
    output [31:0] IRo,
    output [31:0] A,
    output [31:0] B,
    output [31:0] Imm
    );
    
    wire imm_s;
    reg [31:0] NPC;
    
    initial begin
        NPC <= 32'b0;
    end

    always @ (negedge clk, posedge rst) begin
        if (rst) begin
            NPC <= 0;
        end else begin
            NPC <= NPCi;
        end
    end

    assign NPCo = NPC;
    assign IRo = IR;
    assign Imm = {((imm_s && IR[15]) ? 16'hffff:16'h0) , IR[15:0]};

    RegHeap regs(
        .clk(clk),
        .rst(rst),
        .addrA(IR[25:21]),
        .addrB(IR[20:16]),
        .addrW(WBAddr),
        .dataW(WBVal),
        .WriteReg(WBFlag),
        .dataA(A),
        .dataB(B)
    );

    Controller ctrl (
        .opcode(IR[31:26]),
        .funct(IR[5:0]),
        .imm_s(imm_s)
    );


endmodule
