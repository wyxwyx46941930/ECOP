`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 11:08:44
// Design Name: 
// Module Name: RegFile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFile(
    input clk,
    input RegWre,
    input RegDst,
    input [5:0] opCode,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [15:0] immediate,
    input DBDataSrc,
    input [31:0] dataFromALU,
    input [31:0] dataFromRW,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
    
    wire [4:0] WriteReg;
    wire [31:0] WriteData;
    
    assign WriteReg = RegDst ? rd : rt;
    assign WriteData = DBDataSrc ? dataFromRW : dataFromALU;
    
    reg [31:0] register[0:31];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i+1) register[i] <= 0; 
    end
    
    assign ReadData1 = (opCode == 6'b011000) ? immediate[10:6] : register[rs];
    assign ReadData2 = register[rt];
    
    //always @(RegWre or RegDst or DBDataSrc or WriteReg or WriteData) begin
    always @(negedge clk) begin
        if (WriteReg && WriteData) register[WriteReg] = WriteData;
    end
    
endmodule
