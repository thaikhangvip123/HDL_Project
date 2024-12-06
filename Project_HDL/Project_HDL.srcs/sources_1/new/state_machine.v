`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 04:15:54 PM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
    i_password,
    i_confirm,
    i_switch,
    rst,
    clk,
    button1,
    button2,
    button3,
    button0,
    
    o_correct,
    o_incorrect,
    o_trials,
    o_state,
    led1,
    led2
);

    input [15:0] i_password;
    input i_confirm;
    input i_switch;
    input rst;
    input clk;
    input button1;
    input button2;
    input button3;
    input button0;
    
    output reg o_correct;
    output reg o_incorrect;
    output reg [1:0] o_trials;
    output [3:0] o_state;
    
    output reg led1;
    output reg led2;
    
    reg [15:0] saved_password = 16'h1111;
    reg [3:0] current_state;
    reg [3:0] next_state;
    reg r_correct;
    reg r_incorrect;
    reg [1:0] r_trials;

    localparam [3:0] INITIAL     = 4'b0000;
    localparam [3:0] SET_PASS    = 4'b0001;
    localparam [3:0] ENTER_PASS  = 4'b0010;
    localparam [3:0] CHECK_PASS  = 4'b0011;
    localparam [3:0] SUCCESS     = 4'b0100;
    localparam [3:0] OPEN_DOOR   = 4'b0101;
    localparam [3:0] LOCK_DOOR   = 4'b0110;
    localparam [3:0] FAIL        = 4'b0111;
    localparam [3:0] FREEZE      = 4'b1000;
    localparam [3:0] BUZZER      = 4'b1001;

    always @ (posedge clk) begin
        if (rst) begin
            r_correct <= 0;
            r_incorrect <= 0;
            r_trials <= 0;
            saved_password <= 16'h1111;
            next_state = INITIAL;
        end else begin
            current_state <= next_state;
            o_correct <= r_correct;
            o_incorrect <= r_incorrect;
            o_trials <= r_trials;
        end
    end

    always @ (current_state or button1 or i_switch or rst) begin
            r_correct = 0;
            r_incorrect = 0;
            r_trials = 0;

            case (current_state)
                INITIAL: begin
                    r_correct = 0;
                    r_incorrect = 0;
                    r_trials = 0;
                    if (button1) begin
                        led1 <= 1'b1;
                        saved_password = i_password;
                        next_state = CHECK_PASS;
                    end else begin
                        led1 <= 1'b0;
                        next_state = INITIAL;
                    end
                end
                CHECK_PASS: begin
                    r_correct = o_correct;
                    r_incorrect = o_incorrect;
                    if(next_state == CHECK_PASS) begin
                        led2 <= 1'b1;    
                    end else begin
                        led2 <= 1'b0;
                    end
                    if (button1) begin
                        if (saved_password == i_password) begin
                            r_trials = 0;
                            next_state = SUCCESS;
                        end else begin
                            r_trials = o_trials + 1;
                            next_state = FAIL;
                        end
                    end else if (i_switch) begin
                        r_trials = o_trials;
                        next_state = SET_PASS;
                    end else begin
                        r_trials = o_trials;
                        next_state = current_state;
                    end
                end

                SUCCESS: begin
                    r_correct = 1;
                    r_incorrect = 0;
                    if (i_confirm) begin
                        if (saved_password == i_password) begin
                            r_trials = 0;
                            next_state = SUCCESS;
                        end else begin
                            r_trials = o_trials + 1;
                            next_state = FAIL;
                        end
                    end else if (i_switch) begin
                        r_trials = o_trials;
                        next_state = SET_PASS;
                    end else begin
                        r_trials = o_trials;
                        next_state = current_state;
                    end
                end

                FAIL: begin
                    r_correct = 0;
                    r_incorrect = 1;
                    if (o_trials == 2'd3) begin
                        r_trials = o_trials;
                        next_state = FREEZE;
                    end else if (i_confirm) begin
                        if (saved_password == i_password) begin
                            r_trials = 0;
                            next_state = SUCCESS;
                        end else begin
                            r_trials = o_trials + 1;
                            next_state = FAIL;
                        end
                    end else if (i_switch) begin
                        r_trials = o_trials;
                        next_state = SET_PASS;
                    end else begin
                        r_trials = o_trials;
                        next_state = current_state;
                    end
                end

                SET_PASS: begin
                    if (i_confirm) begin
                        saved_password = i_password;
                        r_trials = 0;
                        r_correct = 0;
                        r_incorrect = 0;
                        next_state = SUCCESS;
                    end else if (i_switch) begin
                        r_trials = o_trials;
                        r_correct = o_correct;
                        r_incorrect = o_incorrect;
                        next_state = SUCCESS;
                    end else begin
                        r_trials = o_trials;
                        r_correct = o_correct;
                        r_incorrect = o_incorrect;
                        next_state = current_state;
                    end
                end

                FREEZE: begin
                    r_correct = 0;
                    r_incorrect = 1;
                    r_trials = 3;
                    next_state = current_state;
                end

                default: begin
                    r_correct = 1'bx;
                    r_incorrect = 1'bx;
                    r_trials = 2'bxx;
                    next_state = 3'bxxx;
                end
            endcase
        end
        
    assign o_state = current_state;

endmodule



    
