//Modeling a Generic Counter 
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

  //Intern variable to counter storage
  reg [WIDTH-1:0] cnt_tmp;

  //Implementation using blocking assignment because the if's doesn't can occur the same time (priority order)
  always @*
    begin
        if (rst)
          cnt_tmp = 0;
        else if (load)
          cnt_tmp = cnt_in;
        else if (enab)
          cnt_tmp = cnt_out + 1;
        else 
          cnt_tmp = cnt_out;
    end

  always @(posedge clk)
    cnt_out <= cnt_tmp;

endmodule 