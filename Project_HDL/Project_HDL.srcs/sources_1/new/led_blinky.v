`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 07:42:15 PM
// Design Name: 
// Module Name: led_blinky
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


module led_blinky( clk, rst, divided_clk
    );
    input clk; //0.1MHz
    input rst;
    output reg divided_clk = 0; //1Hz
    
    integer count = 0;
    // value = 1Mhz/2f  - 1
    parameter value = 49999999;
    
    always @ ( posedge clk) begin
                if(rst) begin
                    count <= 0 ;
                    divided_clk <= 0;
                end else begin
                    if(count < value) begin
                            count <= count +1;
                    end else begin
                        count <= 0;
                        divided_clk <= ~divided_clk;
                       end
                   end 
            end
endmodule
