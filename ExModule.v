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
    input [2:0] instId,         // 指令队列id
    input [31:0] inst,          // 指令
    input [2:0] regState[31:1]  // 寄存器占用状态
    input [31:0] a,             // RegHeap端口A(异步)
    input [31:0] b,             // RegHeap端口B(异步)
    input ctrlI,                // 控制线（1有效,上）
    inout tri [31:0] cdbData,   // CDB的数据部分(上)
    inout tri [2:0] cdbId,      // CDB的ID部分
    inout tri cdbInt,           // CDB的内部线
    output ctrlO                // 下一级控制线(1有效，上边更新(带异步))
    output [4:0] addrA,
    output [4:0] addrB
    );

    reg [2:0] head,tail,iter;   // 队列头尾
    reg [31:0] v[1:0][7:0];     // 待定操作数
    reg [4:0]  p[1:0][7:0];     // 待定数寄存器
    reg        s[1:0][7:0];     // 操作数就位
    reg        int[7:0];        // 是否内部指令
    reg [2:0]  id[7:0];         // 队列id

    wire isR,isI,isLd,isSt;
    wire [4:0] read[1:0],write;
    wire [2:0] aluOP;
    wire [31:0] imme;
    wire [1:0] dataReady,needShortcut;  // dataReady: 数据是否就位（检查短路)
    
    assign empty = head == tail;
    assign notReady = !(s[0][tail] && s[1][tail]);
    assign ctrlO = ctrlI && (empty || notReady);
    assign addrA = read[0];
    assign addrB = read[1];
    assign needShortcut = cdbInt ? 0 : { regState[read[0]] == cdbId,regState[read[1]]==cdbId };
    assign dataReady = needShortcut || { |regState[read[0]] , |regState[read[1]] || isI};

    // 指针时间段
    always @(negedge clk,posedge rst) begin
        if (rst) {head,v,p,s,int,id} <= 0;  // rst 状态
        else begin
            if (enable) begin      // 读IR中,注意此处不判溢
                // id处理
                id[head]  <= instId;
                // 开关处理
                { s[0][head],s[1][head] } <= dataReady;     
                // int
                int[head] <= isLd || isSt;
                // 操作数0处理
                if (needShortcut) v[0][head] <= cdbData;     // 短路CDB
                else if (dataReady) v[0][head] <= a;         // 寄存器调取
                else p[0][head] <= regState[read[0]];        // 等待CDB数据
                // 操作数1处理
                if (isI) v[1][head] <= imme;                    // I型指令读立即数
                else if (needShortcut) v[1][head] <= cdbData;   // 短路CDB
                else if (dataReady) v[1][head] <= b;            // 读寄存器
                else p[1][head] <= regState[read[1]];           // 等待CDB
                // 队列更新
                head <= head + 1;
            end
            // 更新rev
            for (iter = 0;iter <= 7;iter = iter+1) begin
                if (!s[0][iter] && !cdbInt && p[0][iter] == cdbId) begin
                    s[0][iter] <= 1;
                    v[0][iter] <= cdbData;
                end
                if (!s[1][iter] && !cdbInt && p[1][iter] == cdbId) begin
                    s[1][iter] <= 1;
                    v[1][iter] <= cdbData;
                end
            end
        end
    end

    wire iready;
    wire [31:0] aluOut;
    assign iready = head != tail && s[0][tail] && s[1][tail];

    reg ready;          // 数据就位
    reg [31:0] aluBuf;  // alu输出缓冲位
    reg intBUf;
    reg [2:0] idBuf;
    always @(posedge clk,posedge rst) begin
        if (rst) {tail,ready,aluBuf,intBuf,idBuf} <= 0;
        else begin
            ready <= iready;
            aluBuf <= aluOut;
            intBuf <= int[tail]
            idBuf <= id[tail];
            tail <= tail + 1;
        end
    end

    SimplaALU(
        .ALU_OP(aluOP),
        .A(v[0][tail]),
        .B(v[1][tail]),
        .F(aluOut)
    )

    BusAdapter (
        .ready(ready),
        .ctrlI(ctrlI),
        .ctrlO(ctrlO),
        .data({idBuf,intBuf,aluBuf}),
        .bus({cdbId,cdbInt,cdbData})
    );

    Decoder (
        .inst(inst),
        .read(read),
        .write(write),
        .isR(isR),
        .isI(isI),
        .isLd(isLd),
        .isSt(isSt),
        .aluOP(aluOP)
    );

endmodule
