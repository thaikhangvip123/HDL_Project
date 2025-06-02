`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 10:17:58 AM
// Design Name: 
// Module Name: led_blinker
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led_blinker( clk, rst, enable , led_blinker

    );
    
    input clk; //1Hz
    input rst;
    input enable;
    output led_blinker;
    
    reg blinker=0;
    always @ ( posedge clk) begin
        if(rst) blinker <=0;
        if(enable) 
            blinker <= ~ blinker;
        end
                   
     assign led_blinker = blinker;
endmodule
