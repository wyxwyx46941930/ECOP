`timescale 1ns / 1ps

module WRMultiplexer(
    input [1:0] RegDst,
    input [4:0] S0,
    input [4:0] S1,
    input [4:0] S2,
    output [4:0] WROut
    );

    assign WROut = RegDst[1] ? S2 : (RegDst[0] ? S1 : S0);

endmodule