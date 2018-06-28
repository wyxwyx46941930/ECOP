`timescale 1ns / 1ps
`include "head.v"

module NextState(
    input [2:0] NowStateIn,             // ?????????
    input [5:0] op,                     // ????????
    output reg [2:0] NextStateOut       // ????????
    );
        
    always@(NowStateIn or op) begin
        case (NowStateIn)
            `sIF: NextStateOut = `sID;
            `sID: begin
                case (op)
                    `opJ, `opJal, `opJr, `opHalt: NextStateOut = `sIF;
                    default: NextStateOut = `sEXE; 
                endcase
            end
            `sEXE: begin
                case (op)
                    `opBeq, `opBltz: NextStateOut = `sIF;
                    `opSw, `opLw: NextStateOut = `sMEM;
                    default: NextStateOut = `sWB;
                endcase
            end
            `sMEM: begin
                case (op)
                    `opSw: NextStateOut = `sIF;
                    `opLw: NextStateOut = `sWB;
                endcase
            end
            `sWB: NextStateOut = `sIF;
        endcase
    end

endmodule