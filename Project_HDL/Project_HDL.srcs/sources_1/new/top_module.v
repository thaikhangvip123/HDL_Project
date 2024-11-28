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
        confirm_getter,
        
        out_1,
        out_2,
        out_3,
        out_4
    );
    input clk;
    input rst;
    input [3:0] digit_in;
    input confirm_getter;
    
     wire confirm_getter_pe;
    
    output [3:0] out_1;
    output [3:0] out_2;
    output [3:0] out_3;
    output [3:0] out_4;
    
    wire [15:0] password;

    // Instantiate pass_getter
    pass_getter u_pass_getter (
        .clk(clk),
        .rst(rst),
        .digit_in(digit_in),
        .confirm_in(confirm_getter_pe ),
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
        .sig_in(confirm_getter),
        .rst(rst),
        .clk(clk),
        .pulse_out_p(confirm_getter_pe)
    );
endmodule
