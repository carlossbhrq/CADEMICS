//Modeling the Arithmetic Logic Unit 
//Author: Carlos Henrique Dantas da Costa 

module alu #(
    parameter WIDTH = 8
)(
    input wire [WIDTH-1:0]  in_a, in_b, 
    input wire [2:0]            opcode,
    output reg [WIDTH-1:0]     alu_out,
    output wire               a_is_zero
);

    assign a_is_zero = (in_a == 8'b00000000) ? 1'b1 : 1'b0; 

    always @(in_a, in_b, opcode)
      begin
        case (opcode)
          3'b000 : alu_out = in_a;
          3'b001 : alu_out = in_a;
          3'b010 : alu_out = in_a + in_b;
          3'b011 : alu_out = in_a & in_b;
          3'b100 : alu_out = in_a ^ in_b;
          3'b101 : alu_out = in_b;
          3'b110 : alu_out = in_a;
          3'b111 : alu_out = in_a;
          default: alu_out = 8'b00000000;
        endcase 
      end   

endmodule 