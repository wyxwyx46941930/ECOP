`timescale 1ns / 1ps

module RegisterFile(
    input CLK,                  // ???
    input RegWre,               // ��???????? 1 ???????????????? WriteData ��?? WriteReg
    input RST,                  // ???????????????????????????????��????
    input [4:0] rs,             // Read Reg1????? rs ?????
    input [4:0] rt,             // Read Reg2????? rt ?????
    input [4:0] WriteReg,       // ????��???????????
    input [31:0] WriteData,     // ????��???????
    output [31:0] ReadData1,    // rs ????
    output [31:0] ReadData2     // rt ????
    );

    // ??????�?????? 32 ?? 32 ��???????????? 0 ????????? 0
    // ??? rs??rt ??????????? 5??2^5 = 32
    // ��??????????? 0 ???????????????��??
    reg [31:0] register[0:31];

    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            register[i] = 0;
        end
    end
    
    // ?? rs ??? rt ????????????????????????? ReadData1 ?? ReadData2
    assign ReadData1 = register[rs];
    assign ReadData2 = register[rt];

    // ??????????? WriteData ��?? WriteReg
    always@(negedge CLK) begin
        // ???????????? RST ???? 0?????????��??????
        if(!RST) begin
            for(i = 1; i < 32; i = i + 1) begin
                register[i] <= 0;
            end
        end
        else if(RegWre && WriteReg != 0) begin
            register[WriteReg] <= WriteData;
        end
    end

endmodule

