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

// 时序设计
// 冲突:
// rev | cdb
// bac | cdb
// que | rev
// rev | regState
// que,cdb,regState(次回) 上边沿更新
// rev,bac 下边沿更新

module ExModule(
    input clk,                  // 时钟
    input rst,                  // 重置内部状态
    input enable,               // 启动输入(1有效，上)
    input [31:0] inst,          // 指令
    input [2:0] regState[31:1]  // 寄存器占用状态
    input [31:0] a,             // RegHeap端口A(异步)
    input [31:0] b,             // RegHeap端口B(异步)
    input cntrI,                // 控制线（1有效,上）
    inout [31:0] cdbData,       // CDB的数据部分(上)
    inout [2:0] cdbId,          // CDB的ID部分
    inout cdbInt,               // CDB的内部线
    output cntrO                // 下一级控制线(1有效，上边更新(带异步))
    );

    reg [2:0] head,tail;
endmodule
