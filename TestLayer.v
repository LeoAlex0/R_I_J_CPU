`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:06:54 05/21/2019 
// Design Name: 
// Module Name:    TestLayer 
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
	assign BTN_Down = (~BTN2)&& BTN1 ; //从0到1的跳变
	
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
	
	assign BTN_Up = BTN_20ms_2 && (~BTN_20ms_1);//从1到0

endmodule


module TestLayer(
    input clk_100MHz,
    input clk,
    input rst,
    input [1:0] mux,
    output reg [31:0] LED
    );
    wire [31:0] F,Mem,PC;
    wire ZF,OF;
    
    wire clk_out;
    BTN_OK btnclk(
        .clk_100MHz(clk_100MHz),
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
    
    always @(*) begin
        case (mux)
            2'b00 : LED = F;
            2'b01 : LED = {ZF,6'b0,OF};
            2'b10 : LED = Mem;
            2'b11 : LED = PC;
            default: LED = 32'b0;
        endcase
    end
    

endmodule
