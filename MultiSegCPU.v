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

module LoadModule(
    );

endmodule
