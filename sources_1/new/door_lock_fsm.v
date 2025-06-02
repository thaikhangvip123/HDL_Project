`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 02:14:55 PM
// Design Name: 
// Module Name: door_lock_fsm
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


module door_lock_fsm(
    password_in, confirm0, confirm1, confirm2, confirm3,
    rst, clk, clk_1Hz,
    correct, incorrect,
    trials, state, buzzer, servo
    );
    input [15:0] password_in;
    input confirm0;
    input confirm1;
    input confirm2;
    input confirm3;
    input rst;
    input clk;
    input clk_1Hz;

    output reg correct;
    output reg incorrect;
    output reg [1:0] trials;
    output  [3:0] state;
    output reg buzzer;
    output reg servo;

    reg [15:0] saved_password;
    reg [3:0] current_state;
    reg [3:0] next_state;
    reg r_correct;
    reg r_incorrect;
    reg [1:0] r_trials;
    reg r_buzzer;
    reg [15:0]pass_enter;
    reg r_servo;
    
    reg [31:0] r_count;
    reg [31:0] count;
    
    reg [31:0] count_open;
    reg [31:0] count_lock;

     
    parameter [3:0] INITIAL = 4'b0000;
    parameter [3:0] SET_PASS = 4'b0001;
    parameter [3:0] ENTER_PASS = 4'b0010;
    parameter [3:0] CHECK_PASS = 4'b0011;
    parameter [3:0] FAIL = 4'b0100;
    parameter [3:0] FREEZE = 4'b0101;
    parameter [3:0] SUCCESS = 4'b0110;
    parameter [3:0] OPEN_DOOR = 4'b0111;
    parameter [3:0] LOCK_DOOR = 4'b1000;

    always @ (posedge clk) begin
            current_state <= next_state;
            correct <= r_correct;
            incorrect <= r_incorrect;
            trials <= r_trials;
            buzzer <= r_buzzer;
            servo <= r_servo;
    end
    
    
    always @(posedge clk_1Hz) begin
            if(current_state == FREEZE) begin 
                count <= count +1;
                if(count == 60) count <=0;
            end else if(current_state == SUCCESS) begin
                count <= count +1;
                if(count == 11) count <=0;
            end else if(current_state == OPEN_DOOR) begin
                count_open <= count_open +1;
            end else if(current_state == LOCK_DOOR) begin
                 count_lock <= count_lock +1;
            end else begin count <=0;
                    count_open <=0;
                    count_lock <=0;
            end              
    end

    always @ (*) begin
                if(rst) begin
                        r_correct <= 0;
                        r_incorrect <= 0;
                        r_trials <= 0;
                        r_buzzer <= 0;
                        saved_password <= 0;
                        next_state <= INITIAL;
                end 
            case (current_state)
                INITIAL: begin
                    r_correct = 0;
                    r_incorrect = 0;
                    r_trials = 0;
                    r_correct =0;
                    r_incorrect =0;
                    saved_password =0;
                    if (confirm1) begin
//                        saved_password = i_password;
                        next_state = SET_PASS;
                    end else begin
                        next_state = current_state;
                    end
                end

                SET_PASS: begin
                     if(confirm0 == 1)begin
                                saved_password = password_in;
                        end
                     if (confirm1 == 1) begin
                        r_trials = 0;
                        r_correct = 0;
                        r_incorrect = 0;
                        next_state = ENTER_PASS;
                    end else begin
                        next_state = current_state;
                    end
                end
                
               ENTER_PASS: begin
                    r_buzzer =0;
                     if(confirm0 == 1)begin
                        pass_enter = password_in;
                    end else
                    if (confirm1 == 1) next_state = CHECK_PASS; 
                    else begin
                        next_state = current_state;
                    end
                end

                CHECK_PASS: begin
                    r_correct = correct;
                    r_incorrect = incorrect;
                    if (confirm1) begin
                        if (saved_password == pass_enter) begin
                            r_trials = 0;
                            next_state = SUCCESS;
                        end else begin
                            r_trials = trials + 1;
                            next_state = FAIL;
                        end
                    end else begin
                        r_trials = trials;
                        next_state = current_state;
                    end
                end

                FAIL: begin
                    r_correct = 0;
                    r_incorrect = 1;
                    r_trials = trials;
                    if (r_trials == 2'b11) begin
                        next_state = FREEZE;
                    end else if (confirm1 == 1) begin
                            next_state = ENTER_PASS;
                            r_correct = 0;
                            r_incorrect = 0;
                    end else begin
                        r_trials = trials;
                        next_state = current_state;
                    end
                end

                FREEZE: begin
                    r_correct = 0;
                    r_incorrect = 1;
                    r_trials = 3;
                    next_state = current_state;
                    if(count >= 60) begin
                        next_state = ENTER_PASS;
                        r_correct = 0;
                        r_incorrect = 0;
                    end else begin
                        next_state = current_state;
                    end
                end
                
                SUCCESS: begin
                    r_correct = 1;
                    r_incorrect = 0;
                    if(count >= 10) begin
                        next_state = ENTER_PASS;
                        r_correct = 0;
                        r_incorrect = 0;
                    end
                    else if (confirm2 == 1) begin
                        next_state = SET_PASS;
                    end
                    else if(confirm3 == 1) begin
                        next_state = OPEN_DOOR;
                        r_servo = 1;
                    end else begin
                        next_state = current_state;
                    end
                end
                
                OPEN_DOOR: begin
                    r_servo = 0;
                    r_correct = 1;
                    r_incorrect = 0;
                    r_buzzer = 0;
                    if(count_open >= 30) begin
                        r_buzzer = 1;
                        if( confirm3 == 1)begin
                                next_state = LOCK_DOOR;
                                r_servo = 1;
                                r_buzzer = 0;
                            end
                            else begin
                            next_state = current_state;
                        end
                    end    
                    if(confirm3 == 1) begin
                          next_state = LOCK_DOOR;
                          r_servo = 1;
                    end else begin
                        next_state = current_state;
                    end
                end
                            
                 LOCK_DOOR: begin
                    r_servo = 0;
                    r_correct = 1;
                    r_incorrect = 0;
                    r_buzzer = 0;
                    if(count_lock >= 10) begin next_state = ENTER_PASS; end
                    
                    else if(confirm3 == 1) begin
                        next_state = OPEN_DOOR;
                        r_servo = 1;
                        end
                    else begin
                        next_state = current_state;
                    end
                 end

                default: next_state = 4'b0000;
            endcase
        end
    
      assign state = next_state;

endmodule

