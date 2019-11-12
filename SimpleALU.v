`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:39:03 04/08/2019 
// Design Name: 
// Module Name:    SimpleALU 
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
module SimpleALU(
    input [2:0] ALU_OP,
    input [31:0] A,
    input [31:0] B,
    output reg ZF,
    output reg OF,
    output reg [31:0] F
    );
    
	 wire exSign,as;
	 wire [31:0] FAdd;
	 
	 assign as = ALU_OP[1] ^ ALU_OP[0];
	 assign {exSign,FAdd} = A+(as?~B:B)+as;
    
    always @(*) begin
        casex(ALU_OP)
            3'b000 : F = A & B;
            3'b001 : F = A | B;
            3'b010 : F = A ^ B;
            3'b011 : F = ~(A | B);
            3'b10x : F = FAdd;
            3'b110 : F = {31'b0,A<B};
            3'b111 : F = B<<A;
            default: F = 32'b0;
        endcase
        ZF = ~| F;
    end
	
	always @(*) begin
		casex(ALU_OP)
			3'b10x : OF = A[31] ^ B[31] ^ FAdd[31] ^ exSign;
			default: OF = 0;
		endcase
	end

endmodule
