`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:19:26 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
        clk,
        rst,
        digit_in,
        key0,key1,key2,key3,
        switch4,
        
        out_1,
        out_2,
        out_3,
        out_4,
        lcd_rs, lcd_rw, lcd_e, lcd_4, lcd_5, lcd_6, lcd_7,
        buzzer_out, servo_out,
        led_incorrect, led_correct
    );
    input clk;
    input rst;
    input [3:0] digit_in;
    input key0;
    input key1;
    input key2;
    input key3;
    input switch4;
    
    wire key0_pe;
    wire key1_pe;
    wire key2_pe;
    wire key3_pe;
        
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
     output servo_out;
     
     output led_incorrect;
     output led_correct;
    
    wire rst;
    wire [15:0] password;
    wire clk_1Hz;
    wire correct;
    wire incorrect;
    wire [1:0] trials;
    wire [3:0] state;
    wire buzzer;
    wire servo;
    
        clk_1Hz C1(
            .clk(clk),
            .reset(rst),
            .clk_1Hz(clk_1Hz)
        );
    
        pass_getter PG (
            .clk(clk),
            .rst(rst),
            .digit_in(digit_in),
            .confirm_in(key0_pe),
            .password_out(password)
        );

        door_lock_fsm FSM (
            .clk(clk),
            .clk_1Hz(clk_1Hz),
            .rst(rst),
            .confirm0(key0_pe),
            .confirm1(key1_pe),
            .confirm2(key2_pe),
            .confirm3(key3_pe),
            .password_in(password),
            .correct(correct),
            .incorrect(incorrect),
            .trials(trials),
            .state(state),
            .buzzer(buzzer),
            .servo(servo)
        );
    
        pass_decoder PD (
            .password_in(password),
            .out_1(out_1),
            .out_2(out_2),
            .out_3(out_3),
            .out_4(out_4)
        );
        
        servo SV(
            .clk(clk),
            .enable(servo),
            .servo(servo_out)
        );
    
        lcd_decoder LD ( 
            .clk(clk),
            .password_in(password),
            .i_trials(trials),
            .i_state(state),
            .lcd_e(lcd_e),
            .lcd_rs(lcd_rs),
            .lcd_rw(lcd_rw),
            .lcd_4(lcd_4),
            .lcd_5(lcd_5),
            .lcd_6(lcd_6),
            .lcd_7(lcd_7)
        );
        
        buzzer BZ(
            .clk(clk_1Hz),
            .switch1(switch4),
            .signal(buzzer),
            .buzzer_out(buzzer_out)
        );
        
        edge_detector ED0(
            .sig_in(key0),
            .rst(rst),
            .clk(clk),
            .pulse_out_p(key0_pe)
        );
        edge_detector ED1(
            .sig_in(key1),
            .rst(rst),
            .clk(clk),
            .pulse_out_p(key1_pe)
        );
        edge_detector ED2(
            .sig_in(key2),
            .rst(rst),
            .clk(clk),
            .pulse_out_p(key2_pe)
        );
        edge_detector ED3(
            .sig_in(key3),
            .rst(rst),
            .clk(clk),
            .pulse_out_p(key3_pe)
        );        

        
        led_blinker LB1(
            .clk(clk_1Hz),
            .rst(rst),
            .enable(incorrect),
            .led_blinker(led_incorrect)
        );
        
        led_blinker LB2(
            .clk(clk_1Hz),
            .rst(rst),
            .enable(correct),
            .led_blinker(led_correct)
        );
endmodule
