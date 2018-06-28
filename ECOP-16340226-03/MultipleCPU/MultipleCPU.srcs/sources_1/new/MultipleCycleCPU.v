`timescale 1ns / 1ps

module MultipleCycleCPU(
    input CLK,
    input RST,
    output [5:0] op,
    output [2:0] StateIn,
    output [2:0] StateOut,
    output [31:0] curAddress,
    output [31:0] newAddress,
    output [4:0] rs,
    output [31:0] ReadData1,
    output [4:0] rt,
    output [31:0] ReadData2,
    output [31:0] result,
    output [31:0] WriteData,
    output [4:0] WriteReg,
    output [31:0] InsDataOut,
    output [31:0] ADROut,
    output [31:0] BDROut,
    output [31:0] ALUDROut,
    output [31:0] DBDROut,
    output [15:0] Immediate,
    output [4:0] rd,
    output [4:0] sa,
    output PCWre,
    output [1:0] PCSrc
    );
    
    wire [2:0] ALUOp;
    wire ExtSel, InsMemRW, IRWre, WrRegDSrc, ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc;
    wire [31:0] IDataIn, DataOut;
    wire [31:0] DBDRIn;
    wire [1:0] RegDst;
    wire RegWre;
    wire [4:0] Reg31;
    reg [31:0] curAddress4, curAddressImm, curAddressRs, curAddressJ;
    wire [31:0] ExtendImmediate;
    wire [31:0] IDataOut;
    wire [31:0] AOut, BOut, extendSa;
    wire zero, sign;

    always@(posedge CLK) begin
        curAddress4 <= curAddress + 4;
        curAddressImm <= curAddress4 + (ExtendImmediate << 2);    //
        curAddressRs <= ReadData1;
        curAddressJ[31:28] <= curAddress4[31:28];
        curAddressJ[27:2] <= InsDataOut[25:0];
        curAddressJ[1:0] <= 2'b00;
    end
   
    assign IDataIn = 0;
    assign op[5:0] = InsDataOut[31:26];
    assign rs[4:0] = InsDataOut[25:21];
    assign rt[4:0] = InsDataOut[20:16];
    assign rd[4:0] = InsDataOut[15:11];
    assign sa[4:0] = InsDataOut[10:6];
    assign Immediate[15:0] = InsDataOut[15:0];
    assign Reg31 = 5'b11111;
    assign extendSa = {{17{0}}, InsDataOut[10:6]};
    
    PC pc(.CLK(CLK), .RST(RST), .PCWre(PCWre), .newAddress(newAddress),
        .curAddress(curAddress));

    IM im(.InsMemRW(InsMemRW), .IAddr(curAddress), .IDataIn(IDataIn), 
        .IDataOut(IDataOut));

    IR ir(.InsDataIn(IDataOut), .CLK(CLK), .IRWre(IRWre),
        .InsDataOut(InsDataOut));

    ControlUnit cu(.CLK(CLK), .RST(RST), .op(op), .zero(zero), .sign(sign),
        .PCWre(PCWre), .ExtSel(ExtSel), .InsMemRW(InsMemRW), .IRWre(IRWre), 
        .WrRegDSrc(WrRegDSrc), .RegDst(RegDst), .RegWre(RegWre), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB),
        .PCSrc(PCSrc), .ALUOp(ALUOp), .mRD(mRD), .mWR(mWR), .DBDataSrc(DBDataSrc),
        .StateIn(StateIn), .StateOut(StateOut));

    WRMultiplexer wrmp(.RegDst(RegDst), .S0(Reg31), .S1(rt), .S2(rd), 
        .WROut(WriteReg));
    
    Multiplexer32 wdmp(.control(WrRegDSrc), .S0(curAddress4), .S1(DBDROut),
        .Out(WriteData));

    RegisterFile rf(.CLK(CLK), .RegWre(RegWre), .RST(RST), .rs(rs), .rt(rt), .WriteReg(WriteReg), .WriteData(WriteData), 
        .ReadData1(ReadData1), .ReadData2(ReadData2));
    
    DR adr(.CLK(CLK), .DRIn(ReadData1), 
        .DROut(ADROut));
    
    DR bdr(.CLK(CLK), .DRIn(ReadData2),
        .DROut(BDROut));

    Multiplexer32 amp(.control(ALUSrcA), .S0(ADROut), .S1(extendSa), 
        .Out(AOut));

    SignZeroExtend sze(.Immediate(Immediate), .ExtSel(ExtSel),
        .ExtendImmediate(ExtendImmediate));

    Multiplexer32 bmp(.control(ALUSrcB), .S0(BDROut), .S1(ExtendImmediate),
        .Out(BOut));

    ALU alu(.ALUOp(ALUOp), .A(AOut), .B(BOut), 
        .zero(zero), .sign(sign), .result(result));

    PCMultiplexer pcmp(.CLK(CLK), .PCSrc(PCSrc), .S0(curAddress4), .S1(curAddressImm), .S2(curAddressRs), .S3(curAddressJ), 
        .PCOut(newAddress));
    
    DR aluoutdr(.CLK(CLK), .DRIn(result),
        .DROut(ALUDROut));

    DM dm(.mRD(mRD), .mWR(mWR), .DAddr(ALUDROut), .DataIn(BDROut), 
        .DataOut(DataOut));
    
    Multiplexer32 dbmp(.control(DBDataSrc), .S0(result), .S1(DataOut), 
        .Out(DBDRIn));

    DR dbdr(.CLK(CLK), .DRIn(DBDRIn), 
        .DROut(DBDROut));

endmodule