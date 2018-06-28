`timescale 1ns / 1ps

module Multiplexer32(
    input control,
    input [31:0] S0,
    input [31:0] S1,
    output [31:0] Out
    );

    assign Out = control ? S1 : S0;
endmodule