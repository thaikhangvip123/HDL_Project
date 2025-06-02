`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 08:21:46 PM
// Design Name: 
// Module Name: led_decoder
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


module led_decoder( in, out);
    input [3:0] in;
    output reg [3:0] out;
    
        always @ (*) begin
            case(in)
                4'h0: out <= 4'b0000;
                4'h1: out <= 4'b0001;
                4'h2: out <= 4'b0010;
                4'h3: out <= 4'b0011;
                4'h4: out <= 4'b0100;
                4'h5: out <= 4'b0101;
                4'h6: out <= 4'b0110;
                4'h7: out <= 4'b0111;
                4'h8: out <= 4'b1000;
                4'h9: out <= 4'b1001;
                4'hA: out <= 4'b1010;
                4'hB: out <= 4'b1011;
                4'hC: out <= 4'b1100;
                4'hD: out <= 4'b1101;
                4'hE: out <= 4'b1110;          
                4'hF: out <= 4'b1111;
                default: out <= 4'b0000;
             endcase    
         end     
endmodule
