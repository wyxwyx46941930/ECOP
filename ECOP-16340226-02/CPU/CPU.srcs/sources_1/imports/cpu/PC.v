`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 22:55:52
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input Reset,
    input PCWre,// 0：不改变PC 1：改变Pc
    input [1:0] PCSrc,//选择Pc跳转方式
    input [31:0] immediate,//立即数
    input [25:0] addr,//2-27位跳转地址
    output reg[31:0] address//输出地址
    );
    
    reg [31:0] pc4;
    
    always @(posedge clk or negedge Reset)
        begin
            if (Reset == 0) begin
                address = 0;
            end
            else if (PCWre) begin
                case(PCSrc)
                    2'b00: begin
                        //普通+4求PC
                        address = address + 4;           
                    end
                    2'b01: begin
                        //beq、bne类跳转指令求PC
                        address = address + 4 + immediate*4;                                                                      
                    end
                    2'b10: begin    
                        pc4 = address + 4;                    
                        //由实验报告中提到的j跳转地址求值
                        address = {pc4[31:28],addr[25:0],1'b0,1'b0};
                    end
                    default: begin
                        address = address + 4;                    
                    end                    
                endcase
            end
        end

endmodule
