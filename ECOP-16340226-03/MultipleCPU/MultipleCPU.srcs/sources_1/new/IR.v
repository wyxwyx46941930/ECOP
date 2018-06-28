`timescale 1ns / 1ps

module IR(
    input [31:0] InsDataIn,
    input CLK,
    input IRWre,
    output reg [31:0] InsDataOut
    );

    always@(negedge CLK) begin
        if(IRWre) begin
            InsDataOut <= InsDataIn;
        end
    end
endmodule