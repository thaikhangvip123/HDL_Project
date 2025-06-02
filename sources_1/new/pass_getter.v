`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 07:00:31 PM
// Design Name: 
// Module Name: pass_getter
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


module pass_getter( digit_in, confirm_in, rst, clk, password_out);
    input clk;
    input rst;
    input [3:0] digit_in;
    input confirm_in;
    output wire [15:0]password_out;
    reg [15:0] out = 16'h0000;
    
    integer count;
    
   always @ (posedge clk) begin
        if (rst) begin
            out <= 16'h0000;
        end
         if (confirm_in) begin
                out <= (out << 4) + digit_in;
            end
        end  
    assign password_out = out;
endmodule
