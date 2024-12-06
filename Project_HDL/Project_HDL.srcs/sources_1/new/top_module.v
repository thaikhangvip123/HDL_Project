`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2024 12:12:08 PM
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
        confirm_getter0,
        confirm_getter1,
        confirm_getter2,
        confirm_getter3,

        switch,
        out_1,
        out_2,
        out_3,
        out_4,
        

        //success,
        //open_door,
        //lock_door,
        //buzzer,
//        led_blinky
        
        led1,
        led2
    );
    input clk;
    input rst;
    input [3:0] digit_in;
    input confirm_getter0;
    input confirm_getter1;
    input confirm_getter2;
    input confirm_getter3;
    
    input switch;

       // intermidiate variable
    wire confirm_getter_pe0;
    wire confirm_getter_pe1;
    wire confirm_getter_pe2;
    wire confirm_getter_pe3;
    
    
    output [3:0] out_1;
    output [3:0] out_2;
    output [3:0] out_3;
    output [3:0] out_4;
    
    //output open_door;
    //output lock_door;
    //output buzzer;
    //output success;
//    output led_blinky;
    output led1;
    output led2;
    
    wire [15:0] password;
    wire incorrect;
    wire correct;
    wire [1:0] trials;
    wire [3:0] state;
    // Instantiate pass_getter
    
    parameter CLK_IN = 50000000;
    
    
    pass_getter u_pass_getter (
        .clk(clk),
        .rst(rst),
        .digit_in(digit_in),
        .confirm_in(confirm_getter_pe0),
        .password_out(password)
    );

    // Instantiate pass_decoder
    pass_decoder u_pass_decoder (
        .password_in(password),
        .out_1(out_1),
        .out_2(out_2),
        .out_3(out_3),
        .out_4(out_4)
    );
    
    edge_detector PD0(
        .sig_in(confirm_getter0),
        .rst(rst),
        .clk(clk),
        .pulse_out_p(confirm_getter_pe0)
    );
    edge_detector PD1(
        .sig_in(confirm_getter1),
        .rst(rst),
        .clk(clk),
        .pulse_out_p(confirm_getter_pe1)
    );
    edge_detector PD2(
        .sig_in(confirm_getter2),
        .rst(rst),
        .clk(clk),
        .pulse_out_p(confirm_getter_pe2)
    );
    edge_detector PD3(
        .sig_in(confirm_getter3),
        .rst(rst),
        .clk(clk),
        .pulse_out_p(confirm_getter_pe3)
    );
        
    state_machine state_machine (
        .clk(clk),
        .rst(rst),
        .button0(confirm_getter0),
        .button1(confirm_getter1),
        .button2(confirm_getter2),
        .button3(confirm_getter3),
        //.success_signal(success),
        .i_password(password),
        //.open_door_signal(open_door),
        //.lock_door_signal(lock_door),
        //.buzzer_signal(buzzer),
//        .led_blink(led_blinky)
        .o_state(state),
        .o_correct(correct),
        .o_incorrect(incorrect),
        .o_trials(trials),
        .led1(led1),
        .led2(led2)
    );
endmodule
