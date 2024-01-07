`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DevHeads
// Engineer: Navadeep
// 
// Create Date: 26.12.2023 18:57:11
// Design Name: FSM_Demo_DevHeads
// Module Name: led_pattern_async
// Project Name: finite state machine implementation for getting LED patterns
// Target Devices: PYNQ_Z2 (suitable on any AMD-Xilinx device with appropriate .xdc file imported)
// Tool Versions: Vivado 2021.1
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//FSM module for LED patterns without using a clock signal (asynchronous)
module led_pattern_async(
input [1:0] mode,           //modes for selecting the pattern - connected to switches
input rst,                  //reset signal
input tick,                 //external tick signal for asynchronous operation
output reg [3:0] led        //LED register of 4 bit size
);

//state reg declerations
 reg [3:0] state, nextstate;

//encode switch states
 parameter s0 = 2'b00;
 parameter s1 = 2'b01;
 parameter s2 = 2'b10;
 parameter s3 = 2'b11;

//handle the reset case and enter the state machine
 always @(posedge rst or posedge tick)
    if(rst) 
        state <= s0;
    else
        state <= nextstate;

always @(*)
    begin
        case(state)
            s0: if(mode == 2'b00) nextstate = s0;
                    else nextstate = s3;
            s1: if(mode == 2'b01) nextstate = s1;
                    else nextstate = s0;
            s2: if(mode == 2'b10) nextstate = s2;
                    else nextstate = s1;
            s3: if(mode == 2'b11) nextstate = s3;
                    else nextstate = s2;
            default: nextstate = s0;
        endcase
    end

//LED driver code taking the external ticks
always @(posedge rst or posedge tick)
    if(rst) 
    begin
        led <= 4'h00;
    end
    else 
    begin
        case(state)
            s0: led = 4'h01;                // single LED on
            s1: led = {led[0], led[3:1]};   // flow pattern left
            s2: led = {led[2:0], led[3]};   // flow pattern right
            s3: led = 4'h11;                // all LED on
            default: led = led;             // do nothing
        endcase
    end

endmodule