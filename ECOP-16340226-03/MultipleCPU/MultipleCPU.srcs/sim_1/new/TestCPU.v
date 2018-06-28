`timescale 1ns / 1ps

module TestCPU();
    reg CLK;
    reg RST;
    wire [5:0] op;
    wire [2:0] StateIn;
    wire [2:0] StateOut;
    wire [31:0] curAddress;
    wire [31:0] newAddress;
    wire [4:0] rs;
    wire [31:0] ReadData1;
    wire [4:0] rt;
    wire [31:0] ReadData2;
    wire [31:0] result;
    wire [31:0] WriteData;
    wire [4:0] WriteReg;
    wire [31:0] InsDataOut;
    wire [31:0] ADROut;
    wire [31:0] BDROut;
    wire [31:0] ALUDROut;
    wire [31:0] DBDROut;
    wire [15:0] Immediate;
    wire [4:0] rd;
    wire [4:0] sa;
    wire PCWre;
    
    MultipleCycleCPU mccpu(.CLK(CLK), .RST(RST),
        .op(op), .StateIn(StateIn), .StateOut(StateOut), 
        .curAddress(curAddress), .newAddress(newAddress),
        .rs(rs), .ReadData1(ReadData1), .rt(rt), .ReadData2(ReadData2), 
        .result(result), .WriteData(WriteData), .WriteReg(WriteReg), 
        .InsDataOut(InsDataOut), .ADROut(ADROut), .BDROut(BDROut), 
        .ALUDROut(ALUDROut), .DBDROut(DBDROut), .Immediate(Immediate), 
        .rd(rd), .sa(sa), .PCWre(PCWre));

    initial begin
        CLK = 0;
        RST = 0;
        #50;
            CLK = 1;
        #50;
            RST = 1;
        forever #50 begin
          CLK = ~CLK;
        end  
    end


endmodule

