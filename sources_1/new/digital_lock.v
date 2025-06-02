`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 01:25:04 PM
// Design Name: 
// Module Name: digital_lock
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


module digital_lock( clk, rst, digit_in, key, switch4,
                     out_1, out_2, out_3, out_4,
                     lcd_rs, lcd_rw, lcd_e, lcd_4, lcd_5, lcd_6, lcd_7,
                     buzzer_out, servo

    );
    input clk;
    input rst;
    input [3:0] digit_in;
    input [3:0] key;
    input switch4;
    
    output [3:0] out_1;
    output [3:0] out_2;
    output [3:0] out_3;
    output [3:0] out_4;
    
     output  lcd_rs; 
     output  lcd_rw;
     output  lcd_7; 
     output  lcd_6;
     output  lcd_5; 
     output  lcd_4;
     output  lcd_e;
     output buzzer_out;
     output servo;
     
     top_module TOP(
        .clk(clk),
        .rst(rst),
        .digit_in(digit_in),
        .key0(~key[0]),
        .key1(~key[1]),
        .key2(~key[2]),
        .key3(~key[3]),
        .switch4(switch4),
        .out_1(out_1),
        .out_2(out_2),
        .out_3(out_3),
        .out_4(out_4),
        .lcd_rs(lcd_rs), .lcd_rw(lcd_rw), .lcd_e(lcd_e), .lcd_4(lcd_4), .lcd_5(lcd_5), .lcd_6(lcd_6), .lcd_7(lcd_7),
        .buzzer_out(buzzer_out),
        .servo(servo)
        
     );
endmodule
