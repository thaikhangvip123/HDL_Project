`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 10:49:14 PM
// Design Name: 
// Module Name: buzzer
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


module buzzer( clk, switch1, signal, buzzer_out );
  input  clk; // 1Hz
  input switch1;
  input signal; 
  output buzzer_out;
  reg buzzer_signal = 0;
  integer  cnt = 0;
	
	always @(posedge clk) begin
	  if ( signal && ~switch1) begin
	           if( clk)
                buzzer_signal <= ~buzzer_signal; // Toggle buzzer_signal when clk is 1
               else buzzer_signal <=0;
            end
      else buzzer_signal <=0;
      end	    
        assign buzzer_out = buzzer_signal;
endmodule
