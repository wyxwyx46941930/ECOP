`timescale 1ns / 1ps

module PCMultiplexer(
    input CLK,
    input [1:0] PCSrc,
    input [31:0] S0,
    input [31:0] S1,
    input [31:0] S2,
    input [31:0] S3,
    output reg [31:0] PCOut
    );
    
    always@(posedge CLK) begin

        case(PCSrc)
            2'b00: PCOut <= S0;
            2'b01: PCOut <= S1;
            2'b10: PCOut <= S2;
            2'b11: PCOut <= S3;
        endcase
    end

endmodule