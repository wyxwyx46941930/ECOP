`timescale 1ns / 1ps

module SignZeroExtend(
    input [15:0] Immediate,
    input ExtSel,                   // 0 => zero-extend, 1 => signed-extend
    output [31:0] ExtendImmediate   
    );

    assign ExtendImmediate[15:0] = Immediate;
    assign ExtendImmediate[31:16] = ExtSel ? (Immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;

endmodule