`timescale 1ns / 1ps
module MultiSegCPU(
    input clk, // 全局时钟
    input rst
    );
    tri [31:0] cdbData;         // CDB的数据部分
    tri [2:0] cdbId;            // CDB中的Id编号
    tri cdbInt;                 // CDB中指令内部计算（1有效）
    wire zf,of;                 // ALU的额外参数，负责Flag的传递和内部计算的标定
    
    reg [31:0] que[7:1];        // 执行队列
    reg [31:0] res[7:1];        // 执行结果
    reg busy[7:1];              // 表项占用
    reg complete[7:1];          // 表项完成
    reg [2:0] regState[31:1];   // 寄存器占用状态
    reg [2:0] head,tail;        // 队列指针
    
    IFSeg getter(
        .clk(clks[0]),
        .rst(rst),
    );

endmodule


module BusAdapter(
    input ready,            // 数据就位（上边沿）
    input ctrlI,            // 控制输入（1有效，上边沿）
    input [35:0] data,      // 数据（上边沿）
    output ctrlO,           // 控制输出（1有效，上边沿）
    output tri [35:0] bus   // 总线（上边沿）
    );

    assign ctrlO = ctrlI && !ready;
    assign bus = (ctrlI && ready) ? data : 36'bz;

endmodule

// 时序设计
// 冲突:
// rev | cdb
// bac | cdb
// que | rev
// rev | regState
// que,cdb,regState(次回) 上边沿更新
// rev,bac 下边沿更新

module LoadModule(
    input clk,                  // 时钟
    input rst,                  // 重置
    input enable,               // 输入有效
    input [2:0] instId,         // 指令id
    input [31:0] inst,          // 指令
    input [2:0] regState[31:1], // 寄存器占用状态

    input [31:0] data,          // memeory返回的数据
    output [31:0] addr,         // 给memory的addr

    input ctrlI,                // 总线控制输入（1有效）
    output ctrlO,               // 总线控制输出（1有效)

    // CDB线
    inout tri [31:0] cdbData,
    inout tri [2:0] cdbId,
    inout tri cdbInt
    );

    integer iter;
    reg [2:0]  head,tail;
    reg [31:0]  v[7:0];
    reg [2:0]   p[7:0];
    reg         s[7:0];

    wire isLd;

    always @(negedge clk,posedge rst) begin
        if (rst) {head,v,p,s} <= 0;
        else begin
            if (enable) begin
                p <= instId;
                s <= 0;
            end

            for (iter=0;iter<=7;iter=iter+1) begin
                if (!s[iter] && cdbInt && p[iter] == cdbId) begin
                    s[iter] <= 1;
                    v[iter] <= cdbData;
                end
            end
        end
    end

    always @(posedge clk,posedge rst) begin
        if (rst) tail <= 0;
        else begin
            if (ctrlI 
        end
    end

endmodule
