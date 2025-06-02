`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 09:46:46 PM
// Design Name: 
// Module Name: LCD_trials
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


module LCD_trials( clk, i_trials, out_trials_1, out_trials_2 );
    input clk;
    input [1:0] i_trials;
    output reg [5:0] out_trials_1;
    output reg [5:0] out_trials_2;
    always @ (posedge clk) begin
            case(i_trials)
                2'd0: begin 
                out_trials_1 <= 6'b100011; //0
                out_trials_2 <= 6'b100000; 
                    end
                2'd1: begin
                out_trials_1 <= 6'b100011; //1
                out_trials_2 <= 6'b100001; 
                    end
                2'd2: begin
                out_trials_1 <= 6'b100011; //2
                out_trials_2 <= 6'b100010; 
                    end
                2'd3: begin
                out_trials_1 <= 6'b100011; //3
                out_trials_2<= 6'b100011; 
                    end
                default: out_trials_1 <= 6'b010000;
             endcase
          end       
endmodule
