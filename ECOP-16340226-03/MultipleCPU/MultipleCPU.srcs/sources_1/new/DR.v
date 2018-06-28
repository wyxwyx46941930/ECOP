`timescale 1ns / 1ps

module DR(
    input CLK,              // ??????
    input [31:0] DRIn,      // ????????
    output reg [31:0] DROut     // ???????
    );
    always@(negedge CLK) begin
        DROut <= DRIn;
    end

endmodule