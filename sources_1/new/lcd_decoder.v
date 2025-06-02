`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:43:23 PM
// Design Name: 
// Module Name: lcd_decoder
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


module lcd_decoder(clk, password_in, i_trials, i_state,
                lcd_rs, lcd_rw, lcd_e,
                 lcd_4, lcd_5, lcd_6, lcd_7

    );
    input clk;
    input [15:0]password_in;
    input [1:0] i_trials;
    input [3:0] i_state;
    
    output lcd_rs;
    output lcd_rw;
    output lcd_e;
    output lcd_4;
    output lcd_5;
    output lcd_6;
    output lcd_7;
    
    wire [5:0] in_0_1;
    wire [5:0] in_0_2;
    wire [5:0] in_1_1;
    wire [5:0] in_1_2;
    wire [5:0] in_2_1;
    wire [5:0] in_2_2;
    wire [5:0] in_3_1;
    wire [5:0] in_3_2;
    
    wire [5:0] out_trials_1;
    wire [5:0] out_trials_2;
    

    
    LCD_pass D1 (.clk(clk), .in(password_in[3:0]), .out_1(in_0_1), .out_2(in_0_2));
    LCD_pass D2 (.clk(clk), .in(password_in[7:4]), .out_1(in_1_1), .out_2(in_1_2));
    LCD_pass D3 (.clk(clk), .in(password_in[11:8]), .out_1(in_2_1), .out_2(in_2_2));
    LCD_pass D4 (.clk(clk), .in(password_in[15:12]), .out_1(in_3_1), .out_2(in_3_2));
    LCD_trials D5 (.clk(clk), .i_trials(i_trials), .out_trials_1(out_trials_1), .out_trials_2(out_trials_2));
    
    lcd_2 D6    (.clk(clk), 
                .input_0_1(in_0_1), .input_0_2(in_0_2), .input_1_1(in_1_1), .input_1_2(in_1_2),
                .input_2_1(in_2_1), .input_2_2(in_2_2), .input_3_1(in_3_1), .input_3_2(in_3_2),
                .i_trials_1(out_trials_1), .i_trials_2(out_trials_2), .i_state(i_state),
                .lcd_rs(lcd_rs), .lcd_rw(lcd_rw), .lcd_e(lcd_e),
                .lcd_4(lcd_4), .lcd_5(lcd_5), .lcd_6(lcd_6), .lcd_7(lcd_7)
                );
    

    
endmodule
