//Modeling a Single-Bidirectional-Port Memory
//Author: Carlos Henrique Dantas da Costa

module memory #(
    parameter integer AWIDTH = 5,
    parameter integer DWIDTH = 8
) (
  input wire [AWIDTH-1:0] addr,
  input wire               clk,
  input wire                wr,
  input wire                rd,
  inout wire [DWIDTH-1:0] data
);

  //Creating the array of address (memory intern)
  reg [DWIDTH-1:0] array [0:(2**AWIDTH)-1];

  //Memory write
  always @(posedge clk)
    begin
       if (wr)
         array[addr]=data;
    end
    
  //Memory read
  assign data = (rd) ? array[addr] : {DWIDTH{1'bZ}};

endmodule 