`timescale 1ns / 1ps

`include "head.v"

module OutputFunc(
    input [2:0] NowStateIn, // 当前状态输入
    input [5:0] op,         // 指令操作码
    input zero,             // ALU运算结果零标志
    input sign,             // ALU运算结果符号位
    output reg PCWre,       // PC值更新控制信号
    output reg ExtSel,          // 立即数扩展控制信号
    output reg InsMemRW,        // 指令存储器写使能信号
    output reg IRWre,           // 指令寄存器写使能信号
    output reg WrRegDSrc,       // 写入寄存器数据源选择信号
    output reg [1:0] RegDst,    // 写入寄存器选择信号
    output reg RegWre,          // 寄存器组写使能信号
    output reg ALUSrcA,         // A操作数数据源选择信号
    output reg ALUSrcB,         // B操作数数据源选择信号
    output reg [1:0] PCSrc,     // 下一条指令地址的选择信号
    output reg [2:0] ALUOp,     // ALU操作选择信号
    output reg mRD,             // 数据存储器读使能信号
    output reg mWR,             // 数据存储器写使能信号
    output reg DBDataSrc        // DB数据源选择信号

    );
    
    always@(NowStateIn) begin
        PCWre = (NowStateIn == `sIF && op != `opHalt) ? 1: 0;
        ExtSel = (NowStateIn == `sEXE) ? ((op == `opOri || op == `opSltiu) ? 0 : 1) : 1;
        InsMemRW = (NowStateIn == `sIF) ? 1 : 0;
        IRWre = (NowStateIn == `sIF) ? 1 : 0;
        WrRegDSrc = (NowStateIn == `sID && op == `opJal) ? 0 : 1;
        RegDst[1] = (NowStateIn == `sWB) ? ((op == `opAddi || op == `opOri || op == `opSltiu || op == `opLw) ? 0 : 1) : 0;
        RegDst[0] = (NowStateIn == `sWB) ? ((op == `opAddi || op == `opOri || op == `opSltiu || op == `opLw) ? 1 : 0) : 0;
        RegWre = (NowStateIn == `sWB) ? 1 : ((NowStateIn == `sID && op == `opJal) ? 1 : 0);
        ALUSrcA = (NowStateIn == `sEXE && op == `opSll) ? 1 : 0;
        ALUSrcB = (NowStateIn == `sEXE) ? ((op == `opAddi || op == `opOri || op == `opSltiu || op == `opSw || op == `opLw) ? 1 : 0) : 0;
        ALUOp[2] = (NowStateIn == `sEXE) ? ((op == `opOr || op == `opAnd || op == `opOri || op == `opSll) ? 1 : 0) : 0;
        ALUOp[1] = (NowStateIn == `sEXE) ? ((op == `opAnd || op == `opSlt || op == `opSltiu || op == `opBltz)) : 0;
        ALUOp[0] = (NowStateIn == `sEXE) ? ((op == `opSub || op == `opOr || op == `opOri || op == `opSlt || op == `opBeq || op == `opBltz) ? 1 : 0) : 0;
        mRD = (NowStateIn == `sMEM && op == `opLw) ? 1 : 0;
        mWR = (NowStateIn == `sMEM && op == `opSw) ? 1 : 0;
        DBDataSrc = (NowStateIn == `sMEM && op == `opLw) ? 1 : 0;
    end
    
    always@(NowStateIn or zero) begin
        PCSrc[1] = (NowStateIn == `sID) ? 1 : 0;
        PCSrc[0] = (NowStateIn == `sID) ? ((op == `opJ || op == `opJal) ? 1 : 0) : ((NowStateIn == `sEXE) ? (((op == `opBeq && zero == 1) || (op == `opBltz && zero == 0)) ? 1 : 0): 0);
        
    end
    
endmodule