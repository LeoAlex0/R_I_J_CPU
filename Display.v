`timescale 1ns / 1ps
// 8 位七段数码管扫描显示模块
module Display(clk, data, which, seg); // 调试接口
    input clk; // 接入系统时钟
    input [32:1] data; // 32 位显示数据
    output reg [2:0] which = 0; // 片选编码（驱动哪一位数码管），低电平有效
    output reg [7:0] seg; // 段选信号（点亮哪些笔划），低电平有效

    always @(negedge clk) which <= which + 1'b1;

    reg [3:0] digit;
    always @* case (which)
        0: digit <= data[32:29]; 
        1: digit <= data[28:25];
        2: digit <= data[24:21];
        3: digit <= data[20:17];
        4: digit <= data[16:13];
        5: digit <= data[12:09];
        6: digit <= data[08:05];
        7: digit <= data[04:01];
    endcase

    always @* case (digit) 
        4'h0: seg <= 8'b0000_0011; 
        4'h1: seg <= 8'b1001_1111;
        4'h2: seg <= 8'b0010_0101;
        4'h3: seg <= 8'b0000_1101;
        4'h4: seg <= 8'b1001_1001;
        4'h5: seg <= 8'b0100_1001;
        4'h6: seg <= 8'b0100_0001;
        4'h7: seg <= 8'b0001_1111;
        4'h8: seg <= 8'b0000_0001;
        4'h9: seg <= 8'b0000_1001;
        4'hA: seg <= 8'b0001_0001;
        4'hB: seg <= 8'b1100_0001;
        4'hC: seg <= 8'b0110_0011;
        4'hD: seg <= 8'b1000_0101;
        4'hE: seg <= 8'b0110_0001;
        4'hF: seg <= 8'b0111_0001;
    endcase

endmodule // Display
