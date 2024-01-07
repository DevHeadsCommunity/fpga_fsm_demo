`timescale 1ns / 1ps

module clk_div(
input wire clk,             //125MHz source in the FPGA
output reg divided_clk = 0  //1Hz => 0.5s ON and 0.5s OFF
    );

//formula for division value = [125Mhz/(2*desired freq)]-1
localparam div_value = 15624999;    // set to 8Hz; 1Hz is 62499999;

integer counter_value = 0;          //32bit wide reg bus

//keeping track of the count and resetting it while the div_value is reached
always@ (posedge clk)                       //works at the rising edge of 0-1
begin
    if(counter_value == div_value)
        counter_value <= 0;                 //reset the value
    else
        counter_value <= counter_value + 1; //count up until div_value is reached
end

//dividing the clock signal
always@ (posedge clk)
begin
    if(counter_value == div_value)
        divided_clk <= ~divided_clk;
    else
        divided_clk <= divided_clk;
end
endmodule