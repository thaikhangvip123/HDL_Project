`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 09:52:28 PM
// Design Name: 
// Module Name: servo
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


module servo( clk, enable,servo
    );
    input clk;
    input enable;
    output servo;
    
   reg [19:0] counter=0;
   reg        servo_reg;
   
   reg [15:0] control	=	50000; 

always @(posedge clk) begin
        if (enable) begin
            control <=0;
        end

        counter <= counter + 1;
        if (counter == 999999) begin
            counter <= 0;
        end

        if (counter < (100000 - control)) begin // 1.5ms pulse width for 90 degrees
            servo_reg <= 1;
        end else begin
            servo_reg <= 0;
        end
        
        if(counter == 0)
            control = control + 2500;
            
         if(control > 50000) begin
                control <=50000;
        end           
    end

    assign servo = servo_reg;

endmodule

