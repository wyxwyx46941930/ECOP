`timescale 1ns / 1ps

// ????????
`define opAdd 6'b000000
`define opSub 6'b000001
`define opAddi 6'b000010
`define opOr 6'b010000
`define opAnd 6'b010001
`define opOri 6'b010010
`define opSll 6'b011000
`define opSlt 6'b100110
`define opSltiu 6'b100111
`define opSw 6'b110000
`define opLw 6'b110001
`define opBeq 6'b110100
`define opBltz 6'b110110
`define opJ 6'b111000
`define opJr 6'b111001
`define opJal 6'b111010
`define opHalt 6'b111111

// ????
`define sIF 3'b000
`define sID 3'b001
`define sEXE 3'b010
`define sMEM 3'b100
`define sWB 3'b011
`define sHalt 3'b111