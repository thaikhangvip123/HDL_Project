`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 01:03:08 PM
// Design Name: 
// Module Name: LCD_2
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


module lcd_2(clk, 
                input_0_1, input_0_2, input_1_1, input_1_2, input_2_1, input_2_2, input_3_1, input_3_2, 
                i_trials_1, i_trials_2, i_state,
                lcd_rs, lcd_rw, lcd_e, lcd_4, lcd_5, lcd_6, lcd_7); 
 input clk; // synthesis attribute PERIOD clk "50.0 MHz" 
 parameter n = 27;
 parameter k = 17; 
 reg [n-1:0] count=0; 
 reg lcd_busy=1; 
 reg lcd_stb; 
 reg [5:0] lcd_code;
 reg [6:0] lcd_stuff; 
 reg refresh;
 
 input [5:0] i_trials_1;
 input [5:0] i_trials_2; 
 input [3:0] i_state;
 
 input [5:0] input_0_1;
 input [5:0] input_0_2;
 input [5:0] input_1_1;
 input [5:0] input_1_2;
 input [5:0] input_2_1;
 input [5:0] input_2_2;
 input [5:0] input_3_1;
 input [5:0] input_3_2;
  
 
 output reg lcd_rs; 
 output reg lcd_rw;
 output reg lcd_7; 
 output reg lcd_6;
 output reg lcd_5; 
 output reg lcd_4;
 output reg lcd_e;
 
 localparam [3:0] INITIAL = 4'd0;
 localparam [3:0] SET_PASS = 4'd1;
 localparam [3:0] ENTER_PASS = 4'd2;
 localparam [3:0] CHECK_PASS = 4'd3;
 localparam [3:0] FAIL = 4'd4;
 localparam [3:0] FREEZE = 4'd5;
 localparam [3:0] SUCCESS = 4'd6;
 localparam [3:0] OPEN_DOOR = 4'd7;
 localparam [3:0] LOCK_DOOR = 4'd8;
 
 always @ (posedge clk) 
 begin
        count <= count + 1;
                case(i_state)
          INITIAL: begin // INITIAL
               case (count[k+7:k+2]) 
                     0: lcd_code <= 6'b000010; // function set 
                     1: lcd_code <= 6'b000010; 
                     2: lcd_code <= 6'b001100;
                     3: lcd_code <= 6'b000000; // display on/off control
                     4: lcd_code <= 6'b001100; 
                     5: lcd_code <= 6'b000000; // display clear
                     6: lcd_code <= 6'b000001;
                     7: lcd_code <= 6'b000000; // entry mode set
                     8: lcd_code <= 6'b000110;
                     
                     9: lcd_code <= 6'b100100; // I 
                     10: lcd_code <= 6'b101001; 
                     11: lcd_code <= 6'b100100; // N 
                     12: lcd_code <= 6'b101110; 
                     13: lcd_code <= 6'b100100; // I 
                     14: lcd_code <= 6'b101001;
                     15: lcd_code <= 6'b100101; // T 
                     16: lcd_code <= 6'b100100; 
                     17: lcd_code <= 6'b100100; // I 
                     18: lcd_code <= 6'b101001; 
                     19: lcd_code <= 6'b100100; // A
                     20: lcd_code <= 6'b100001; 
                     21: lcd_code <= 6'b100100; // L 
                     22: lcd_code <= 6'b101100; 
                     23: lcd_code <= 6'b100010; // space 
                     24: lcd_code <= 6'b100000; 
                     25: lcd_code <= 6'b100010; // space 
                     26: lcd_code <= 6'b100000; 
                     27: lcd_code <= 6'b100010; // space 
                     28: lcd_code <= 6'b100000;
                     29: lcd_code <= 6'b100010; // space 
                     30: lcd_code <= 6'b100000;
                     31: lcd_code <= 6'b100010; // space
                     32: lcd_code <= 6'b100000; 
                     33: lcd_code <= 6'b100010; // space 
                     34: lcd_code <= 6'b100000; 
                     35: lcd_code <= 6'b100010; // space
                     36: lcd_code <= 6'b100000; 
                     37: lcd_code <= 6'b100010; // space
                     38: lcd_code <= 6'b100000; 
                     39: lcd_code <= 6'b100010; // space
                     40: lcd_code <= 6'b100000; 
                     41: lcd_code <= 6'b001100; // move to line 2 hexC0
                     42: lcd_code <= 6'b000000; 
                     43: lcd_code <= 6'b100010; // space
                     44: lcd_code <= 6'b100000; 
                     45: lcd_code <= 6'b100010; // space
                     46: lcd_code <= 6'b100000; 
                     47: lcd_code <= 6'b100010; // space
                     48: lcd_code <= 6'b100000; 
                     49: lcd_code <= 6'b100010; // space
                     50: lcd_code <= 6'b100000;
                     51: lcd_code <= 6'b100010; // space
                     52: lcd_code <= 6'b100000; 
                     53: lcd_code <= 6'b100010; // space
                     54: lcd_code <= 6'b100000; 
                     55: count[k+7:k+2] <= 5;
                     default: lcd_code <= 6'b010000;
                endcase
             end
          SET_PASS: begin // SET_PASS
                case (count[k+7:k+2]) 
//                     0: lcd_code <= 6'b000010; // function set 
//                     1: lcd_code <= 6'b000010; 
//                     2: lcd_code <= 6'b001100;
//                     3: lcd_code <= 6'b000000; // display on/off control
//                     4: lcd_code <= 6'b001100; 
                     5: lcd_code <= 6'b000000; // display clear
                     6: lcd_code <= 6'b000001;
                     7: lcd_code <= 6'b000000; // entry mode set
                     8: lcd_code <= 6'b000110;
                     
                     9: lcd_code <= 6'b100101; // S 
                     10: lcd_code <= 6'b100011; 
                     11: lcd_code <= 6'b100100; // E 
                     12: lcd_code <= 6'b100101; 
                     13: lcd_code <= 6'b100101; // T 
                     14: lcd_code <= 6'b100100;
                     15: lcd_code <= 6'b100010; // space 
                     16: lcd_code <= 6'b100000; 
                     17: lcd_code <= 6'b100101; // P 
                     18: lcd_code <= 6'b100000; 
                     19: lcd_code <= 6'b100100; // A
                     20: lcd_code <= 6'b100001; 
                     21: lcd_code <= 6'b100101; // S 
                     22: lcd_code <= 6'b100011; 
                     23: lcd_code <= 6'b100101; // S 
                     24: lcd_code <= 6'b100011;
                     25: lcd_code <= 6'b100010; // space
                     26: lcd_code <= 6'b100000;
                     27: lcd_code <= 6'b100010; // space 
                     28: lcd_code <= 6'b100000;
                     29: lcd_code <= 6'b100010; // space 
                     30: lcd_code <= 6'b100000;
                     31: lcd_code <= 6'b100010; // space
                     32: lcd_code <= 6'b100000; 
                     33: lcd_code <= 6'b100010; // space 
                     34: lcd_code <= 6'b100000; 
                     35: lcd_code <= 6'b100010; // space
                     36: lcd_code <= 6'b100000; 
                     37: lcd_code <= 6'b100010; // space
                     38: lcd_code <= 6'b100000; 
                     39: lcd_code <= 6'b100010; // space
                     40: lcd_code <= 6'b100000; 
                     41: lcd_code <= 6'b001100; // move to line 2 hexC0
                     42: lcd_code <= 6'b000000; 
                     43: lcd_code <= input_0_1; // 1 A
                     44: lcd_code <= input_0_2; 
                     45: lcd_code <= input_1_1; // 2 B
                     46: lcd_code <= input_1_2; 
                     47: lcd_code <= input_2_1; // 3 C 
                     48: lcd_code <= input_2_2; 
                     49: lcd_code <= input_3_1; // 4 D
                     50: lcd_code <= input_3_2;
                     51: lcd_code <= 6'b100010; // space
                     52: lcd_code <= 6'b100000; 
                     53: lcd_code <= 6'b100010; // space
                     54: lcd_code <= 6'b100000; 
                     55: count[k+7:k+2] <= 5; 
                     default: lcd_code <= 6'b010000;
                endcase
             end
          ENTER_PASS: begin // NHAP MAT KHAU ~ ENTER_PASS
                 case (count[k+7:k+2]) 
//                 0: lcd_code <= 6'b000010; // function set 
//                 1: lcd_code <= 6'b000010; 
//                 2: lcd_code <= 6'b001100;
//                 3: lcd_code <= 6'b000000; // display on/off control
//                 4: lcd_code <= 6'b001100; 
                 5: lcd_code <= 6'b000000; // display clear
                 6: lcd_code <= 6'b000001;
                 7: lcd_code <= 6'b000000; // entry mode set
                 8: lcd_code <= 6'b000110;
                 
                 9: lcd_code <= 6'b100100; // N 
                 10: lcd_code <= 6'b101110; 
                 11: lcd_code <= 6'b100100; // H 
                 12: lcd_code <= 6'b101000; 
                 13: lcd_code <= 6'b100100; // A 
                 14: lcd_code <= 6'b100001;
                 15: lcd_code <= 6'b100101; // P 
                 16: lcd_code <= 6'b100000; 
                 17: lcd_code <= 6'b100010; // space 
                 18: lcd_code <= 6'b100000; 
                 19: lcd_code <= 6'b100100; // M
                 20: lcd_code <= 6'b101101; 
                 21: lcd_code <= 6'b100100; // A 
                 22: lcd_code <= 6'b100001; 
                 23: lcd_code <= 6'b100101; // T 
                 24: lcd_code <= 6'b100100; 
                 25: lcd_code <= 6'b100010; // space 
                 26: lcd_code <= 6'b100000; 
                 27: lcd_code <= 6'b100100; // K 
                 28: lcd_code <= 6'b101011;
                 29: lcd_code <= 6'b100100; // H 
                 30: lcd_code <= 6'b101000;
                 31: lcd_code <= 6'b100100; // A
                 32: lcd_code <= 6'b100001; 
                 33: lcd_code <= 6'b100101; // U 
                 34: lcd_code <= 6'b100101; 
                 35: lcd_code <= 6'b100010; // space
                 36: lcd_code <= 6'b100000; 
                 37: lcd_code <= 6'b100010; // space
                 38: lcd_code <= 6'b100000; 
                 39: lcd_code <= 6'b100010; // space
                 40: lcd_code <= 6'b100000; 
                 41: lcd_code <= 6'b001100; // move to line 2 hexC0
                 42: lcd_code <= 6'b000000; 
                 43: lcd_code <= input_0_1; // 1 A
                 44: lcd_code <= input_0_2; 
                 45: lcd_code <= input_1_1; // 2 B
                 46: lcd_code <= input_1_2; 
                 47: lcd_code <= input_2_1; // 3 C 
                 48: lcd_code <= input_2_2; 
                 49: lcd_code <= input_3_1; // 4 D
                 50: lcd_code <= input_3_2;
                 51: lcd_code <= 6'b100010; // space
                 52: lcd_code <= 6'b100000; 
                 53: lcd_code <= 6'b100010; // space
                 54: lcd_code <= 6'b100000; 
                 55: count[k+7:k+2] <= 5; 
                 default: lcd_code <= 6'b010000; 
             endcase
             end
              CHECK_PASS: begin // SET_PASS
                case (count[k+7:k+2]) 
//                     0: lcd_code <= 6'b000010; // function set 
//                     1: lcd_code <= 6'b000010; 
//                     2: lcd_code <= 6'b001100;
//                     3: lcd_code <= 6'b000000; // display on/off control
//                     4: lcd_code <= 6'b001100; 
                     5: lcd_code <= 6'b000000; // display clear
                     6: lcd_code <= 6'b000001;
                     7: lcd_code <= 6'b000000; // entry mode set
                     8: lcd_code <= 6'b000110;
                     
                     9: lcd_code <= 6'b100100; // C 
                     10: lcd_code <= 6'b100011; 
                     11: lcd_code <= 6'b100100; // H 
                     12: lcd_code <= 6'b101000; 
                     13: lcd_code <= 6'b100100; // E 
                     14: lcd_code <= 6'b100101;
                     15: lcd_code <= 6'b100100; // C 
                     16: lcd_code <= 6'b100011; 
                     17: lcd_code <= 6'b100100; // K 
                     18: lcd_code <= 6'b101011;
                     19: lcd_code <= 6'b100010; // spazce 
                     20: lcd_code <= 6'b100000;         
                     21: lcd_code <= 6'b100101; // P 
                     22: lcd_code <= 6'b100000; 
                     23: lcd_code <= 6'b100100; // A
                     24: lcd_code <= 6'b100001; 
                     25: lcd_code <= 6'b100101; // S 
                     26: lcd_code <= 6'b100011; 
                     27: lcd_code <= 6'b100101; // S 
                     28: lcd_code <= 6'b100011;
                     29: lcd_code <= 6'b100010; // space 
                     30: lcd_code <= 6'b100000;
                     31: lcd_code <= 6'b100010; // space
                     32: lcd_code <= 6'b100000; 
                     33: lcd_code <= 6'b100010; // space 
                     34: lcd_code <= 6'b100000; 
                     35: lcd_code <= 6'b100010; // space
                     36: lcd_code <= 6'b100000; 
                     37: lcd_code <= 6'b100010; // space
                     38: lcd_code <= 6'b100000; 
                     39: lcd_code <= 6'b100010; // space
                     40: lcd_code <= 6'b100000; 
                     41: lcd_code <= 6'b001100; // move to line 2 hexC0
                     42: lcd_code <= 6'b000000; 
                     43: lcd_code <= 6'b100010; // space
                     44: lcd_code <= 6'b100000; 
                     45: lcd_code <= 6'b100010; // space
                     46: lcd_code <= 6'b100000; 
                     47: lcd_code <= 6'b100010; // space
                     48: lcd_code <= 6'b100000; 
                     49: lcd_code <= 6'b100010; // space
                     50: lcd_code <= 6'b100000;
                     51: lcd_code <= 6'b100010; // space
                     52: lcd_code <= 6'b100000; 
                     53: lcd_code <= 6'b100010; // space
                     54: lcd_code <= 6'b100000; 
                     55: count[k+7:k+2] <= 5;
                     default: lcd_code <= 6'b010000;
                endcase
             end
              FAIL: begin 
                case (count[k+7:k+2])  // SAI MAT KHAU
//                 0: lcd_code <= 6'b000010; // function set 
//                 1: lcd_code <= 6'b000010; 
//                 2: lcd_code <= 6'b001100;
//                 3: lcd_code <= 6'b000000; // display on/off control
//                 4: lcd_code <= 6'b001100; 
                 5: lcd_code <= 6'b000000; // display clear
                 6: lcd_code <= 6'b000001;
                 7: lcd_code <= 6'b000000; // entry mode set
                 8: lcd_code <= 6'b000110;
                 
                 9: lcd_code <= 6'b100101; // S 
                 10: lcd_code <= 6'b100011; 
                 11: lcd_code <= 6'b100100; // A 
                 12: lcd_code <= 6'b100001; 
                 13: lcd_code <= 6'b100100; // I  
                 14: lcd_code <= 6'b101001;
                 15: lcd_code <= 6'b100010; // space 
                 16: lcd_code <= 6'b100000; 
                 17: lcd_code <= 6'b100010; // space 
                 18: lcd_code <= 6'b100000; 
                 19: lcd_code <= 6'b100100; // M
                 20: lcd_code <= 6'b101101; 
                 21: lcd_code <= 6'b100100; // A 
                 22: lcd_code <= 6'b100001; 
                 23: lcd_code <= 6'b100101; // T 
                 24: lcd_code <= 6'b100100; 
                 25: lcd_code <= 6'b100010; // space 
                 26: lcd_code <= 6'b100000; 
                 27: lcd_code <= 6'b100100; // K 
                 28: lcd_code <= 6'b101011;
                 29: lcd_code <= 6'b100100; // H 
                 30: lcd_code <= 6'b101000;
                 31: lcd_code <= 6'b100100; // A
                 32: lcd_code <= 6'b100001; 
                 33: lcd_code <= 6'b100101; // U 
                 34: lcd_code <= 6'b100101; 
                 35: lcd_code <= 6'b100010; // space
                 36: lcd_code <= 6'b100000; 
                 37: lcd_code <= 6'b100010; // space
                 38: lcd_code <= 6'b100000; 
                 39: lcd_code <= 6'b100010; // space
                 40: lcd_code <= 6'b100000; 
                 41: lcd_code <= 6'b001100; // move to line 2 hexC0
                 42: lcd_code <= 6'b000000; 
                 43: lcd_code <= i_trials_1;
                 44: lcd_code <= i_trials_2;
                 45: lcd_code <= 6'b100010; // space
                 46: lcd_code <= 6'b100000;
                 47: lcd_code <= 6'b100010; // space
                 48: lcd_code <= 6'b100000;
                 49: lcd_code <= 6'b100010; // space
                 50: lcd_code <= 6'b100000;
                 51: lcd_code <= 6'b100010; // space
                 52: lcd_code <= 6'b100000;
                 53: lcd_code <= 6'b100010; // space
                 54: lcd_code <= 6'b100000;
                 55: count[k+7:k+2] <= 5;
                 default: lcd_code <= 6'b010000; 
             endcase
             end
             
             FREEZE: begin // FREEZE
                case (count[k+7:k+2]) 
//                     0: lcd_code <= 6'b000010; // function set 
//                     1: lcd_code <= 6'b000010; 
//                     2: lcd_code <= 6'b001100;
//                     3: lcd_code <= 6'b000000; // display on/off control
//                     4: lcd_code <= 6'b001100; 
                     5: lcd_code <= 6'b000000; // display clear
                     6: lcd_code <= 6'b000001;
                     7: lcd_code <= 6'b000000; // entry mode set
                     8: lcd_code <= 6'b000110;
                     
                     9: lcd_code <= 6'b100100; // F 
                     10: lcd_code <= 6'b100110; 
                     11: lcd_code <= 6'b100101; // R 
                     12: lcd_code <= 6'b100010; 
                     13: lcd_code <= 6'b100100; // E 
                     14: lcd_code <= 6'b100101;
                     15: lcd_code <= 6'b100100; // E 
                     16: lcd_code <= 6'b100101; 
                     17: lcd_code <= 6'b100101; // Z 
                     18: lcd_code <= 6'b101010; 
                     19: lcd_code <= 6'b100100; // E
                     20: lcd_code <= 6'b100101; 
                     21: lcd_code <= 6'b100010; // space 
                     22: lcd_code <= 6'b100000; 
                     23: lcd_code <= 6'b100010; // space 
                     24: lcd_code <= 6'b100000;
                     25: lcd_code <= 6'b100010; // space
                     26: lcd_code <= 6'b100000;
                     27: lcd_code <= 6'b100010; // space 
                     28: lcd_code <= 6'b100000;
                     29: lcd_code <= 6'b100010; // space 
                     30: lcd_code <= 6'b100000;
                     31: lcd_code <= 6'b100010; // space
                     32: lcd_code <= 6'b100000; 
                     33: lcd_code <= 6'b100010; // space 
                     34: lcd_code <= 6'b100000; 
                     35: lcd_code <= 6'b100010; // space
                     36: lcd_code <= 6'b100000; 
                     37: lcd_code <= 6'b100010; // space
                     38: lcd_code <= 6'b100000; 
                     39: lcd_code <= 6'b100010; // space
                     40: lcd_code <= 6'b100000; 
                     41: lcd_code <= 6'b001100; // move to line 2 hexC0
                     42: lcd_code <= 6'b000000; 
                     43: lcd_code <= 6'b100010; // space
                     44: lcd_code <= 6'b100000; 
                     45: lcd_code <= 6'b100010; // space
                     46: lcd_code <= 6'b100000; 
                     47: lcd_code <= 6'b100010; // space
                     48: lcd_code <= 6'b100000; 
                     49: lcd_code <= 6'b100010; // space
                     50: lcd_code <= 6'b100000;
                     51: lcd_code <= 6'b100010; // space
                     52: lcd_code <= 6'b100000; 
                     53: lcd_code <= 6'b100010; // space
                     54: lcd_code <= 6'b100000; 
                     55: count[k+7:k+2] <= 5;
                     default: lcd_code <= 6'b010000;
                endcase
             end
             SUCCESS: begin
                case (count[k+7:k+2])  // DUNG MAT KHAU
//                         0: lcd_code <= 6'b000010; // function set 
//                         1: lcd_code <= 6'b000010; 
//                         2: lcd_code <= 6'b001100;
//                         3: lcd_code <= 6'b000000; // display on/off control
//                         4: lcd_code <= 6'b001100; 
                         5: lcd_code <= 6'b000000; // display clear
                         6: lcd_code <= 6'b000001;
                         7: lcd_code <= 6'b000000; // entry mode set
                         8: lcd_code <= 6'b000110;
                         
                         9: lcd_code <= 6'b100100; // D 
                         10: lcd_code <= 6'b100100; 
                         11: lcd_code <= 6'b100101; // U 
                         12: lcd_code <= 6'b100101; 
                         13: lcd_code <= 6'b100100; // N 
                         14: lcd_code <= 6'b101110;
                         15: lcd_code <= 6'b100100; // G 
                         16: lcd_code <= 6'b100111; 
                         17: lcd_code <= 6'b100010; // space 
                         18: lcd_code <= 6'b100000; 
                         19: lcd_code <= 6'b100100; // M
                         20: lcd_code <= 6'b101101; 
                         21: lcd_code <= 6'b100100; // A 
                         22: lcd_code <= 6'b100001; 
                         23: lcd_code <= 6'b100101; // T 
                         24: lcd_code <= 6'b100100; 
                         25: lcd_code <= 6'b100010; // space 
                         26: lcd_code <= 6'b100000; 
                         27: lcd_code <= 6'b100100; // K 
                         28: lcd_code <= 6'b101011;
                         29: lcd_code <= 6'b100100; // H 
                         30: lcd_code <= 6'b101000;
                         31: lcd_code <= 6'b100100; // A
                         32: lcd_code <= 6'b100001; 
                         33: lcd_code <= 6'b100101; // U 
                         34: lcd_code <= 6'b100101; 
                         35: lcd_code <= 6'b100010; // space
                         36: lcd_code <= 6'b100000; 
                         37: lcd_code <= 6'b100010; // space
                         38: lcd_code <= 6'b100000; 
                         39: lcd_code <= 6'b100010; // space
                         40: lcd_code <= 6'b100000; 
                         41: lcd_code <= 6'b001100; // move to line 2 hexC0
                         42: lcd_code <= 6'b000000; 
                         43: lcd_code <= 6'b100010; // space
                         44: lcd_code <= 6'b100000; 
                         45: lcd_code <= 6'b100010; // space
                         46: lcd_code <= 6'b100000; 
                         47: lcd_code <= 6'b100010; // space
                         48: lcd_code <= 6'b100000; 
                         49: lcd_code <= 6'b100010; // space
                         50: lcd_code <= 6'b100000;
                         51: lcd_code <= 6'b100010; // space
                         52: lcd_code <= 6'b100000; 
                         53: lcd_code <= 6'b100010; // space
                         54: lcd_code <= 6'b100000; 
                         55: count[k+7:k+2] <= 5;
                 default: lcd_code <= 6'b010000; 
             endcase end
             
             OPEN_DOOR: begin
              case (count[k+7:k+2])  // MO CUA
//                 0: lcd_code <= 6'b000010; // function set 
//                 1: lcd_code <= 6'b000010; 
//                 2: lcd_code <= 6'b001100;
//                 3: lcd_code <= 6'b000000; // display on/off control
//                 4: lcd_code <= 6'b001100; 
                 5: lcd_code <= 6'b000000; // display clear
                 6: lcd_code <= 6'b000001;
                 7: lcd_code <= 6'b000000; // entry mode set
                 8: lcd_code <= 6'b000110;
                 
                 9: lcd_code <= 6'b100100; // C 
                 10: lcd_code <= 6'b100011; 
                 11: lcd_code <= 6'b100101; // U 
                 12: lcd_code <= 6'b100101; 
                 13: lcd_code <= 6'b100100; // A 
                 14: lcd_code <= 6'b100001;
                 15: lcd_code <= 6'b100010; // space 
                 16: lcd_code <= 6'b100000; 
                 17: lcd_code <= 6'b100010; // space 
                 18: lcd_code <= 6'b100000; 
                 19: lcd_code <= 6'b100100; // M
                 20: lcd_code <= 6'b101101; 
                 21: lcd_code <= 6'b100100; // O 
                 22: lcd_code <= 6'b101111;
                 23: lcd_code <= 6'b100010; // space 
                 24: lcd_code <= 6'b100000; 
                 25: lcd_code <= 6'b100010; // space
                 26: lcd_code <= 6'b100000; 
                 27: lcd_code <= 6'b100010; // space 
                     28: lcd_code <= 6'b100000;
                     29: lcd_code <= 6'b100010; // space 
                     30: lcd_code <= 6'b100000;
                     31: lcd_code <= 6'b100010; // space
                     32: lcd_code <= 6'b100000; 
                     33: lcd_code <= 6'b100010; // space 
                     34: lcd_code <= 6'b100000; 
                     35: lcd_code <= 6'b100010; // space
                     36: lcd_code <= 6'b100000; 
                     37: lcd_code <= 6'b100010; // space
                     38: lcd_code <= 6'b100000; 
                     39: lcd_code <= 6'b100010; // space
                     40: lcd_code <= 6'b100000; 
                     41: lcd_code <= 6'b001100; // move to line 2 hexC0
                     42: lcd_code <= 6'b000000; 
                     43: lcd_code <= 6'b100010; // space
                     44: lcd_code <= 6'b100000; 
                     45: lcd_code <= 6'b100010; // space
                     46: lcd_code <= 6'b100000; 
                     47: lcd_code <= 6'b100010; // space
                     48: lcd_code <= 6'b100000; 
                     49: lcd_code <= 6'b100010; // space
                     50: lcd_code <= 6'b100000;
                     51: lcd_code <= 6'b100010; // space
                     52: lcd_code <= 6'b100000; 
                     53: lcd_code <= 6'b100010; // space
                     54: lcd_code <= 6'b100000; 
                     55: count[k+7:k+2] <= 5; 
                 default: lcd_code <= 6'b010000; 
             endcase
             end
             LOCK_DOOR: begin
              case (count[k+7:k+2])  // DONG CUA
//                 0: lcd_code <= 6'b000010; // function set 
//                 1: lcd_code <= 6'b000010; 
//                 2: lcd_code <= 6'b001100;
//                 3: lcd_code <= 6'b000000; // display on/off control
//                 4: lcd_code <= 6'b001100; 
                 5: lcd_code <= 6'b000000; // display clear
                 6: lcd_code <= 6'b000001;
                 7: lcd_code <= 6'b000000; // entry mode set
                 8: lcd_code <= 6'b000110;
                 
                 9: lcd_code <= 6'b100100; // C 
                 10: lcd_code <= 6'b100011; 
                 11: lcd_code <= 6'b100101; // U 
                 12: lcd_code <= 6'b100101; 
                 13: lcd_code <= 6'b100100; // A 
                 14: lcd_code <= 6'b100001;
                 15: lcd_code <= 6'b100010; // space 
                 16: lcd_code <= 6'b100000; 
                 17: lcd_code <= 6'b100010; // space 
                 18: lcd_code <= 6'b100000; 
                 19: lcd_code <= 6'b100100; // D
                 20: lcd_code <= 6'b100100; 
                 21: lcd_code <= 6'b100100; // O 
                 22: lcd_code <= 6'b101111; 
                 23: lcd_code <= 6'b100100; // N 
                 24: lcd_code <= 6'b101110; 
                 25: lcd_code <= 6'b100100; // G 
                 26: lcd_code <= 6'b100111;
                 27: lcd_code <= 6'b100010; // space 
                 28: lcd_code <= 6'b100000; 
                 29: lcd_code <= 6'b100010; // space 
                 30: lcd_code <= 6'b100000; 
                 31: lcd_code <= 6'b100010; // space
                     32: lcd_code <= 6'b100000; 
                     33: lcd_code <= 6'b100010; // space 
                     34: lcd_code <= 6'b100000; 
                     35: lcd_code <= 6'b100010; // space
                     36: lcd_code <= 6'b100000; 
                     37: lcd_code <= 6'b100010; // space
                     38: lcd_code <= 6'b100000; 
                     39: lcd_code <= 6'b100010; // space
                     40: lcd_code <= 6'b100000; 
                     41: lcd_code <= 6'b001100; // move to line 2 hexC0
                     42: lcd_code <= 6'b000000; 
                     43: lcd_code <= 6'b100010; // space
                     44: lcd_code <= 6'b100000; 
                     45: lcd_code <= 6'b100010; // space
                     46: lcd_code <= 6'b100000; 
                     47: lcd_code <= 6'b100010; // space
                     48: lcd_code <= 6'b100000; 
                     49: lcd_code <= 6'b100010; // space
                     50: lcd_code <= 6'b100000;
                     51: lcd_code <= 6'b100010; // space
                     52: lcd_code <= 6'b100000; 
                     53: lcd_code <= 6'b100010; // space
                     54: lcd_code <= 6'b100000; 
                     55: count[k+7:k+2] <= 5; 
                 default: lcd_code <= 6'b010000; 
             endcase 
             end
         endcase
             
        
                
 if (lcd_rw)
 lcd_busy <= 0;
 lcd_stb <= ^count[k+1:k+0] & ~lcd_rw & lcd_busy; // clkrate / 2^(k+2) 
 lcd_stuff <= {lcd_stb,lcd_code};
 {lcd_e,lcd_rs,lcd_rw,lcd_7,lcd_6,lcd_5,lcd_4} <= lcd_stuff;
 end
 endmodule
 
 