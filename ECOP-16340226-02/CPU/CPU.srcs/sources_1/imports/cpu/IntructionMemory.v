`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 00:35:03
// Design Name: 
// Module Name: IntructionMemory
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


module IntructionMemory(
    input [31:0] pc,
    output [5:0] opCode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] immediate,
    output [5:0] sa,
    output [25:0] addr
    );
    // 8位长的指令存储单元，共128个
    reg [7:0] memory[0:127];
    reg [31:0] address;
    reg [31:0] instruction;
    initial begin
        $readmemb("C:/Users/dell/Desktop/CPU/instructions.txt", memory);
        instruction = 0;
    end
    
    always @(pc) begin
        address = pc[6:2] << 2;
        instruction = (memory[address]<<24)+
        (memory[address+1]<<16)+
        (memory[address+2]<<8)+
        memory[address+3];
    end
    
    assign opCode = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign immediate = instruction[15:0];
    assign sa = instruction[10:6];
    assign addr = instruction[25:0];
  
endmodule
