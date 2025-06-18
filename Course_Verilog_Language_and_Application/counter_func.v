//Modeling the Counter Using Functions 
//Author: Carlos Henrique Dantas da Costa 

module counter #(
    parameter integer WIDTH = 5
)(
    input wire [WIDTH-1:0] cnt_in,
    input wire               enab,
    input wire               load,
    input wire                clk,
    input wire                rst,
    output reg [WIDTH-1:0] cnt_out
);

  //Function declaration 
  function [WIDTH-1:0] cnt_func (
    input [WIDTH-1:0] cnt_in,               //Inputs the function are always reg type
    input               enab,               //Can be integer, real, time and realtime, but not wire
    input               load,
    input                clk,
    input [WIDTH-1:0] cnt_out
  );
  
    begin
      if (rst)
        cnt_func = 0;
      else if (load)
        cnt_func = cnt_in;
      else if (enab)
        cnt_func = cnt_out + 1;
      else
        cnt_func = cnt_out;
    end
  endfunction 

  always @(posedge clk)
    cnt_out <= cnt_fun(cnt_in, enab, load, clk, cnt_out);   //The same order declaration of inputs the function

endmodule 