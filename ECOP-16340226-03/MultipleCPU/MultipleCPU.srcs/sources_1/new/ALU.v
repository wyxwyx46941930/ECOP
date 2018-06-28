`timescale 1ns / 1ps

module ALU(
    input [2:0] ALUOp,          // ALU ????????
    input [31:0] A,             // A ????
    input [31:0] B,             // B ????
    output reg zero,            // ??????????
    output reg sign,		    // ??????????¦Ë
    output reg [31:0] result    // ??????
    );

    always@(ALUOp or A or B) begin    
        case (ALUOp)
            3'b000 : result = (A + B);
            3'b001 : result = (A - B);
            3'b010 : result = (A < B) ? 1 : 0;
            3'b011 : result = (((A < B) && (A[31] == B[31])) || (A[31] && !B[31])) ? 1 : 0;
            3'b100 : result = (B << A);
            3'b101 : result = (A | B);
            3'b110 : result = (A & B);
            3'b111 : result = (A ^ B);
            default : result = 0;
        endcase

        zero = (result == 0) ? 1 : 0;
        sign = result[31];
    end

endmodule