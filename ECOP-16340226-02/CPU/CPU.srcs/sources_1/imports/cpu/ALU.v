`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 22:30:06
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [31:0] extend,
    input [5:0] sa,
    input [2:0] ALUOp,
    input ALUSrcA,
    input ALUSrcB,
    output reg [31:0] result,
    output reg zero
    );
    
    wire [31:0] A;
    wire [31:0] B;
    
    assign A = ALUSrcA ? sa : ReadData1;
    assign B = ALUSrcB ? extend : ReadData2;
    
    always @(ReadData1 or ReadData2 or extend or ALUSrcA or ALUSrcB or ALUOp or A or B)
        begin
            case(ALUOp)
                3'b000: begin
                    result = A + B;
                    zero = (result == 0) ? 1 : 0;
                end
                3'b001: begin
                    result = A - B;
                    zero = (result == 0) ? 1 : 0;
                end
                3'b010: begin
                    result = B << A;
                    zero = (result == 0) ? 1 : 0;
                end
                3'b011: begin
                    result = A | B;
                    zero = (result == 0) ? 1 : 0;
                end
                3'b100: begin
                    result = A & B;
                    zero = (result == 0) ? 1 : 0;
                end
                3'b101: begin
                    result = (A < B) ? 1 : 0;
                    zero = (result == 0) ? 1 : 0;
                end
                3'b110: begin
                    result = (((A < B) && (A[31] == B[31])) ||((A[31] == 1 && B[31] == 0))) ? 1 : 0;
                    zero = (result == 0) ? 1 : 0;                 
                end
                3'B111: begin
                    result = A ^~ B;
                    zero = (result == 0) ? 1 : 0;
                end
            endcase
        end
endmodule
