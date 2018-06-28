`timescale 1ns / 1ps

module PC(
    input CLK,                      
    input RST,                      
    input PCWre,                    
    input [31:0] newAddress,        
    output reg [31:0] curAddress    
                                    
    );
    
    initial begin
        curAddress = 0;
    end
    
    always@(PCWre or RST) begin
        if(!RST) begin
            curAddress = 0;
        end
        else if(PCWre) begin 
            curAddress = newAddress;
        end
    end

endmodule