`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 08:43:21 PM
// Design Name: 
// Module Name: pass_decoder
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


module pass_decoder( password_in, out_1, out_2, out_3, out_4

    );
    input [15:0] password_in;
    
    output [3:0] out_1;
    output [3:0] out_2;
    output [3:0] out_3;
    output [3:0] out_4;
    
    led_decoder D1 ( .in(password_in[3:0]), .out(out_1));
    led_decoder D2 ( .in(password_in[7:4]), .out(out_2)); 
    led_decoder D3 ( .in(password_in[11:8]), .out(out_3)); 
    led_decoder D4 ( .in(password_in[15:12]), .out(out_4));     
endmodule
