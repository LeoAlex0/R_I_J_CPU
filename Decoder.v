// 指令解析
module Decoder(
        input [31:0] inst,          // 指令
        output [4:0] read[1:0],     // 读寄存器号(0占位)
        output [4:0] write,         // 写寄存器号(0占位)
        output isR,                 // R型指令
        output isI,                 // I型指令
        output isJ,                 // J型指令
        output isLd,                // 读主存指令
        output isSt,                // 写主存指令
        output isCond,              // 是否为控制指令
        output [31:0] imme,         // 扩展后的立即数(0占位)
        output [2:0] aluOP,         // ALU操作码
    );


    wire [5:0] opcode,func;
    wire [4:0] rs,rt,rd,shamt;
    wire IsR,IsI,IsJ,IsLd,IsSt;
    
    assign {opcode,func,rs,rt,rd,shamt,func} = inst;

    assign IsR  = opcode == 6'b0;                   // R型指令opcode部分全0
    assign IsI  = opcode[5:3] == 3'b1 
        || opcode[5:2] == 4'b1 || IsLd || IdSt;     // I型指令
    assign IsJ  = opcode[5:1] == 5'b1               // J型指令
    assign IsLd = opcode == 6'b100_011              // lw
    assign IsSt = opcode == 6'b101_011              // sw
    assign imme = (IsI || IsLD || IsSt) ? {(IsLD || IsSt || opcode == 6'b001_000)?16{inst[15]}:16'b0,inst[15:0]} : 32'b0;       // 补齐的imme，0占位
    assign read[0] = !IsJ ? rs : 5'b0;
    assign read[1] = !IsJ ? rt : 5'b0;
    assign write   = IsR ? rd : ((IsI || IsLd) ? rt : 5'b0)

    always (*) begin
        if (IsR)
            case (func)
                6'b100_000: aluOP = 3'b100;             // add
                6'b100_010: aluOP = 3'b101;             // sub
                6'b100_1xx: aluOP = {1'b0,func[1:0]};   // and/or/xor/nor
                6'b101_011: aluOP = 3'b110;             // sltu
                6'b000_100: aluOP = 3'b111;             // sllv
                default:    aluOP = 3'b000;             // default: add
            endcase
        else if (IsI && opcode[5:2] != 4'b1)            // 非控制类I型指令
            case (opcode[2:0])
                3'b000:  aluOp = 3'b100;                 // addi
                3'b1xx:  aluOp = {1'b0,opcode[1:0]};     // andi/xori
                3'b011:  aluOp = 3'b110;                 // sltiu
                default: aluOp = 3'b000;                 // default: add
            endcase
        else if (opcode[5:2] == 4'b1) aluOp = 3'b010;    // 控制类I型指令，异或
        else aluOP = 3'b000;
    end

    assign isR    = IsR;
    assign isI    = IsI;
    assign isJ    = IsJ;
    assign isLd   = IsLd;
    assign isSt   = IsSt;
    assign isCond = opcode[5:2] == 4'b1 || opcode[5:1] == 5'b1;
endmodule
