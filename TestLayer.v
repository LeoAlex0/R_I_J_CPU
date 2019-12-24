`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:45:02 03/02/2014 
// Design Name: 
// Module Name:    BTN_OK 
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
module BTN_OK(
    input clk_100MHz,
    input BTN,
    output reg BTN_Out
    );

	reg BTN1,BTN2;
	wire BTN_Down;
	reg [21:0] cnt;
	reg BTN_20ms_1,BTN_20ms_2;
	wire BTN_Up;
	
	always @(posedge clk_100MHz)
	begin
		BTN1 <= BTN;
		BTN2 <= BTN1;
	end
	assign BTN_Down = (~BTN2)&& BTN1 ; //浠鍒鐨勮烦鍙
	
	always @(posedge clk_100MHz)
	begin
		if (BTN_Down) 
			begin
				cnt <= 22'b0;
				BTN_Out <= 1'b1;
			end
		else	cnt <= cnt+1'b1;
		if (cnt==22'h20000) BTN_20ms_1 <= BTN;
		BTN_20ms_2 <= BTN_20ms_1;
		if (BTN_Up) BTN_Out <= 1'b0;
	end
	
	assign BTN_Up = BTN_20ms_2 && (~BTN_20ms_1);//浠鍒

endmodule


module TestLayer(
    input clk_25MHz,
    input clk,
    input rst,
    input [1:0] mux,
	 output [2:0] which,
	 output enable,
	 output [7:0] seg
    );
    wire [31:0] F,Mem,PC;
    wire ZF,OF;
    wire [31:0] showData;
    
    wire clk_out;
    BTN_OK btnclk(
        .clk_100MHz(clk_25MHz),
        .BTN(clk),
        .BTN_Out(clk_out)
    );
    
    MultiSegCPU cpu(
        .clk(clk_out),
        .rst(rst),
        .F(F),
        .Mem(Mem),
        .PC(PC),
        .ZF(ZF),
        .OF(OF)
    );
    
	wire clk_500Hz;
	Exp16Fdiv Fdiv500Hzout (
			.CLK_in(clk_25MHz), 
			.n(31'd5000), 
			.rst(1'b0), 
			.CLK_out(clk_500Hz)
	);
	 
	 Display disp(clk_500Hz,showData,which,seg);
	 
     reg [31:0] led;
	 assign showData = led;//TODO: 填上数码管显示数据
	 
    always @(*) begin
        case (mux)
            2'b00 : led = F;
            2'b01 : led = {ZF,6'b0,OF};
            2'b10 : led = Mem;
            2'b11 : led = PC;
            default: led = 32'b0;
        endcase
    end
    

endmodule
