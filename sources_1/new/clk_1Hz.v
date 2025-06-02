`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 10:10:18 PM
// Design Name: 
// Module Name: clk_1Hz
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


module clk_1Hz(clk, reset, clk_1Hz

    );
    
        input clk, reset;
        output clk_1Hz;
        
        reg clk_1Hz = 1'b0;
        reg [27:0] counter;
        
        always@(posedge clk)
        begin
            if (reset)
                begin
                    clk_1Hz <= 0;
                    counter <= 0;
                end
            else
                begin
                    counter <= counter + 1;
                    if ( counter == 50000000)
                        begin
                            counter <= 0;
                            clk_1Hz <= ~clk_1Hz;
                        end
                end
        end
endmodule
