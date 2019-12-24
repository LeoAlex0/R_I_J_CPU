`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:17 05/20/2019 
// Design Name: 
// Module Name:    Controller 
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

module Controller(
    input [5:0] opcode,
    input [5:0] funct,
    input ZF,
    output reg [1:0] w_r_s,
    output reg imm_s,
    output reg [1:0] w_r_data_s,
    output reg rt_imm_s,
    output reg [2:0] ALU_OP,
    output reg MemWrite,
    output reg WriteReg,
    output reg [1:0] PC_s
);
    always @(*) begin
        casex (opcode)
            6'b000_000: begin //R
                {w_r_s,w_r_data_s,rt_imm_s,MemWrite} = 0;
                imm_s = 1'bx;
                WriteReg = 1;
                casex(funct)
                    6'b100_000 : ALU_OP = 3'b100;
                    6'b100_010 : ALU_OP = 3'b101;
                    6'b100_1xx : ALU_OP = {1'b0,funct[1:0]};
                    6'b101_011 : ALU_OP = 3'b110;
                    6'b000_100 : ALU_OP = 3'b111;
                    default : ALU_OP = 3'b000;
                endcase
                PC_s = funct == 6'b001000; // jr
            end
            
            6'b001xxx : begin  // I1
                {rt_imm_s,WriteReg,MemWrite,w_r_data_s,w_r_s,PC_s} = 9'b1100001_00;
                imm_s = opcode[2:0] == 3'b000;
                case(opcode[2:0])
                    3'b000 : ALU_OP = 3'b100;
                    3'b100 : ALU_OP = 3'b000;
                    3'b110 : ALU_OP = 3'b010;
                    3'b011 : ALU_OP = 3'b110;
                    default: ALU_OP = 3'b000;
                endcase
            end
            
            // I2
            6'b100011 : {w_r_s,imm_s,w_r_data_s,rt_imm_s,MemWrite,PC_s,WriteReg,ALU_OP} = 13'b0110110001100;
            6'b101011 : {w_r_s,imm_s,w_r_data_s,rt_imm_s,MemWrite,PC_s,WriteReg,ALU_OP} = 13'bxx1xx11000100;
            
            // I3
            6'b00010x : begin
                {w_r_s,imm_s,rt_imm_s,w_r_data_s,ALU_OP,WriteReg,MemWrite} = 11'bxx_1_0_xx_101_0_0;
                PC_s = {ZF^opcode[0],1'b0};
            end
            
            // J
            6'b000_01x: begin
                {imm_s,rt_imm_s,ALU_OP,MemWrite,PC_s} = 8'bx_x_xxx_0_11;
                w_r_s = {opcode[0],1'b0};
                w_r_data_s = {opcode[0],1'b0};
                WriteReg = opcode[0];
            end
                        
            default : {w_r_s,imm_s,w_r_data_s,rt_imm_s,MemWrite,PC_s,WriteReg,ALU_OP} = 0;
        endcase
    end
endmodule
