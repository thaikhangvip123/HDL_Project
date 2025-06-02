`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 08:30:01 PM
// Design Name: 
// Module Name: edge_detector
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


module edge_detector( clk, rst, sig_in, pulse_out_p);
    input clk;
    input rst;
    input sig_in;
    output pulse_out_p;
    
    reg sig_in_delay = 0;
    
    always @ (posedge clk) begin
        if(rst) begin
                sig_in_delay <= 1'b0;
            end else begin
                sig_in_delay <= sig_in;
            end
         end
         assign pulse_out_p = ~sig_in_delay & sig_in;
endmodule
