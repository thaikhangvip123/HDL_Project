`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:56:07 PM
// Design Name: 
// Module Name: LCD_pass
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


module LCD_pass(clk, in, out_1, out_2);
    input clk;
    input [3:0] in;
    output reg [5:0] out_1;
    output reg [5:0] out_2;
    
        always @ (posedge clk) begin
            case(in)
                4'h0: begin 
                out_1 <= 6'b100011; //0
                out_2 <= 6'b100000; 
                    end
                4'h1: begin
                out_1 <= 6'b100011; //1
                out_2 <= 6'b100001; 
                    end
                4'h2: begin
                out_1 <= 6'b100011; //2
                out_2 <= 6'b100010; 
                    end
                4'h3: begin
                out_1 <= 6'b100011; //3
                out_2 <= 6'b100011; 
                    end
                4'h4: begin
                out_1 <= 6'b100011; //4
                out_2 <= 6'b100100; 
                    end
                4'h5: begin
                out_1 <= 6'b100011; //5
                out_2 <= 6'b100101; 
                    end
                4'h6: begin
                out_1 <= 6'b100011; //6
                out_2 <= 6'b100110; 
                    end
                4'h7: begin
                out_1 <= 6'b100011; //7
                out_2 <= 6'b100111; 
                    end
                4'h8: begin
                out_1 <= 6'b100011; //8
                out_2 <= 6'b101000; 
                    end
                4'h9: begin
                out_1 <= 6'b100011; //9
                out_2 <= 6'b101001; 
                    end
                
                4'hA:begin
                 out_1 <= 6'b100100;
                 out_2 <= 6'b100001; //A
                 end
                4'hB:
                begin
                 out_1 <= 6'b100100;
                 out_2 <= 6'b100010; //B
                 end
                4'hC:
                begin
                 out_1 <= 6'b100100;
                 out_2 <= 6'b100011; //C
                 end
                4'hD:
                begin
                 out_1 <= 6'b100100;
                 out_2 <= 6'b100100; //D
                 end
                4'hE:
                begin
                 out_1 <= 6'b100100;
                 out_2 <= 6'b100101; //E
                 end   
                4'hF:
                begin
                 out_1 <= 6'b100100;
                 out_2 <= 6'b100110; //F
                 end
                default: out_1 <= 6'b010000;
             endcase    
         end
 endmodule 

