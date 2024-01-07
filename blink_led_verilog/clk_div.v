`timescale 1ns / 1ps

module clk_div(
input wire clk,  //125MHz
output reg divided_clk = 0  //1Hz => 0.5s ON and 0.5s OFF
    );

localparam div_value = 62499999;
//division value = 125Mhz/(2*desired freq)-1 => 49999999

//counter
integer counter_value = 0;  //32bit wide reg bus

always@ (posedge clk) //rising edge 0-1
begin
    //keep counting till 1000
    if(counter_value == div_value)
        counter_value <= 0;  //reset value
    else
        counter_value <= counter_value + 1;  //count up
end

//divide clock
always@ (posedge clk)
begin
    if(counter_value == div_value)
        divided_clk <= ~divided_clk;    //flip the signal 
    else
        divided_clk <= divided_clk;
end
endmodule