`timescale 1ns / 1ps

module ControlUnit(
    input CLK,              // 时钟信号
    input RST,              // 重置信号
    input [5:0] op,         // 指令操作码
    input zero,             // ALU运算结果零标志
    input sign,             // ALU运算结果符号位
    output PCWre,           // PC值更新控制信号
    output ExtSel,          // 立即数扩展控制信号
    output InsMemRW,        // 指令存储器写使能信号
    output IRWre,           // 指令寄存器写使能信号
    output WrRegDSrc,       // 写入寄存器数据源选择信号
    output [1:0] RegDst,    // 写入寄存器选择信号
    output RegWre,          // 寄存器组写使能信号
    output ALUSrcA,         // A操作数数据源选择信号
    output ALUSrcB,         // B操作数数据源选择信号
    output [1:0] PCSrc,     // 下一条指令地址的选择信号
    output [2:0] ALUOp,     // ALU操作选择信号
    output mRD,             // 数据存储器读使能信号
    output mWR,             // 数据存储器写使能信号
    output DBDataSrc,       // DB数据源选择信号
    output [2:0] StateIn,
    output [2:0] StateOut
    );


    DFlipFlop dff(.StateIn(StateIn), .CLK(CLK), .RST(RST), 
        .StateOut(StateOut));
    NextState ns(.NowStateIn(StateOut), .op(op), 
        .NextStateOut(StateIn));
    OutputFunc opf(.NowStateIn(StateOut), .op(op), .zero(zero), .sign(sign), 
        .PCWre(PCWre), .ExtSel(ExtSel), .InsMemRW(InsMemRW), .IRWre(IRWre), 
        .WrRegDSrc(WrRegDSrc), .RegDst(RegDst), .RegWre(RegWre), .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB), .PCSrc(PCSrc), .ALUOp(ALUOp), .mRD(mRD), .mWR(mWR), 
        .DBDataSrc(DBDataSrc)
        );


endmodule

