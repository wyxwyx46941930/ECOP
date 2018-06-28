`timescale 1ns / 1ps

module DM(
    input mRD,                      // ?????????????0 => ??????????1 => ??????��????lw
    input mWR,                      // ��???????????0 => ???????1 => ��????��????sw
    input [31:0] DAddr,             // ???????????Memory??
    input [31:0] DataIn,            // ��???????????sw
    output [31:0] DataOut           // ???????????????lw
    );

    reg [7:0] Memory[0:128];        // 8��????????��???????128?????????��

    integer i;
    initial begin 
        for(i = 0; i < 128; i = i + 1) begin
            Memory[i] = 0;
        end
    end

    // ???????mRD == 1 => ????mRD == 0 => ????????
    // ??????????????????????��????
    assign DataOut[31:24] = (mRD) ? Memory[DAddr] : 8'bz;
    assign DataOut[23:16] = (mRD) ? Memory[DAddr + 1] : 8'bz;
    assign DataOut[15:8] = (mRD) ? Memory[DAddr + 2] : 8'bz;
    assign DataOut[7:0] = (mRD) ? Memory[DAddr + 3] : 8'bz;

    // ��?????mWR == 1 => ��??mWR == 0 => ?????
    // ???????????????��???????????
    always@(mWR or DataIn) begin
        if(mWR) begin
            Memory[DAddr] = DataIn[31:24];
            Memory[DAddr + 1] = DataIn[23:16];
            Memory[DAddr + 2] = DataIn[15:8];
            Memory[DAddr + 3] = DataIn[7:0];
        end
    end

endmodule