`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 09:18:16 PM
// Design Name: 
// Module Name: fsm
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


module fsm_door_lock (
    input wire clk,
    input wire rst,           // Reset signal to initialize the system
    input wire button0,
    input wire button1,
    input wire button2,
    input wire button3,
    output reg open_door_signal,
    output reg lock_door_signal,
    output reg buzzer_signal,
    output reg [1:0] led_blink
);

    // State definitions
    localparam INITIAL     = 4'd0,
               SET_PASS    = 4'd1,
               ENTER_PASS  = 4'd2,
               CHECK_PASS  = 4'd3,
               SUCCESS     = 4'd4,
               OPEN_DOOR   = 4'd5,
               LOCK_DOOR   = 4'd6,
               FAIL        = 4'd7,
               FREEZE      = 4'd8,
               BUZZER      = 4'd9;

    // Internal variables
    reg [3:0] state = INITIAL;
    reg [3:0] next_state;

    reg [15:0] saved_pass;    // Saved password
    reg [15:0] input_pass;    // Input password
    reg [3:0] trials;         // Number of failed attempts
    reg [15:0] lock_timer;    // Timer for locking
    reg [15:0] freeze_timer;  // Timer for freezing state

    // Clocked process for state transitions
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= INITIAL;
            trials <= 0;
            lock_timer <= 0;
            freeze_timer <= 0;
            open_door_signal <= 0;
            lock_door_signal <= 0;
            buzzer_signal <= 0;
            led_blink <= 2'b00;
        end
//        end else begin
//            state <= next_state;

//            // Timer logic
//            if (state == OPEN_DOOR || state == LOCK_DOOR) 
//                lock_timer <= lock_timer + 1;
//            else 
//                lock_timer <= 0;

//            if (state == FREEZE) 
//                freeze_timer <= freeze_timer + 1;
//            else 
//                freeze_timer <= 0;
//        end
    end

    // Combinational logic for state transitions and outputs
    always @(posedge clk) begin
        // Default outputs
        next_state = state;
        open_door_signal = 0;
        lock_door_signal = 0;
        buzzer_signal = 0;
        led_blink = 2'b00;

        case (state)
            INITIAL: begin
                if (button2) 
                    next_state = ENTER_PASS;
            end

            SET_PASS: begin
                if (button1) begin
                    saved_pass = input_pass;
                    next_state = CHECK_PASS;
                end
            end

            ENTER_PASS: begin
                if (button1) begin
                    next_state = CHECK_PASS;
                end
            end

            CHECK_PASS: begin
                if (input_pass == saved_pass) 
                    next_state = SUCCESS;
                else begin
                    trials = trials + 1;
                    if (trials > 3)
                        next_state = FREEZE;
                    else
                        next_state = FAIL;
                end
            end

            SUCCESS: begin
                if (button2) 
                    next_state = SET_PASS;
                else if (button3) 
                    next_state = OPEN_DOOR;
                else if (lock_timer >= 10) 
                    next_state = INITIAL;
            end

            OPEN_DOOR: begin
                open_door_signal = 1;
                if (button3) 
                    next_state = LOCK_DOOR;
                else if (lock_timer >= 30) 
                    next_state = BUZZER;
            end

            LOCK_DOOR: begin
                lock_door_signal = 1;
                if (lock_timer >= 10) 
                    next_state = INITIAL;
                else if (button3) 
                    next_state = OPEN_DOOR;
            end

            FAIL: begin
                if (trials <= 3)
                    next_state = ENTER_PASS;
            end

            FREEZE: begin
                if (freeze_timer >= 600000000) // Assuming 1 minute = 60000 clock cycles
                    next_state = INITIAL;
            end

            BUZZER: begin
                buzzer_signal = 1;
                led_blink = 2'b11; // Blink LED
            end

            default: next_state = INITIAL;
        endcase
    end
endmodule

