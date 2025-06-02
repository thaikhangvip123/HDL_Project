`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 12:04:02 PM
// Design Name: 
// Module Name: servo_tb
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


module servo_tb(

    );
    reg clk;
    reg enable; 
    wire servo;
    
    servo UUT(
        .clk(clk),
        .enable(enable),
        .servo(servo)
    );
    
    initial clk =0;
    always #10 clk =~clk;
    
    initial begin
            enable =0;
            #10
            enable =1;
            #10
            enable =0;    
    end
endmodule
