`timescale 1ns / 1ps

 module top(
 input wire clk, //125MHz
 output wire led
 );
 
 //wrapper for the clock clk
 clk_div wrapper (
 .clk(clk),
 .divided_clk(led)
 );
 
 endmodule