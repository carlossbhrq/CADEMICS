//Modeling a Data Driver 
//Author: Carlos Henrique Dantas da Costa 

module driver #(
  parameter WIDTH = 8
)(
  input [WIDTH-1:0]      data_in,
  input wire             data_en,
  output reg [WIDTH-1:0] data_out
);
  always @*
    begin
	   if (data_en == 1)
		  data_out = data_in;
		else 
		  data_out = {WIDTH{1'bz}};			//Repeat the 1'bz WIDTH times
	 end 
endmodule 