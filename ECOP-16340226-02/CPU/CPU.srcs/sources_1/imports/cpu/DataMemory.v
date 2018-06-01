`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 23:49:44
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input clk,
    input nRD,
    input nWR,
    input [31:0] DAddr,
    input [31:0] DataIn,
    output reg[31:0] DataOut
    );
    
    reg [7:0] memory[0:127];
    reg [31:0] address;
    
    //always @(nRD or DAddr or memory) begin
    always @(nRD) begin
        if (nRD == 0) begin
             address = (DAddr << 2);
             DataOut = (memory[address]<<24)+
             (memory[address+1]<<16)+
             (memory[address+2]<<8)+
             memory[address+3];
        end
    end
      
    integer i;
    initial begin
        for (i = 0; i < 128; i = i+1) memory[i] <= 0;
    end
    always @(negedge clk)
        begin
            if (nWR == 0) begin
                address = DAddr << 2;
                memory[address] = DataIn[31:24];
                memory[address+1] = DataIn[23:16];
                memory[address+2] = DataIn[15:8];
                memory[address+3] = DataIn[7:0];
            end  
        end
    
endmodule
