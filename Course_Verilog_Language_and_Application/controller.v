//Modeling a Controller 
//Author: Carlos Henrique Dantas da Costa 

module controller (
    input wire       zero   , 
    input wire [2:0] phase  ,
    input wire [2:0] opcode ,

    output reg       sel    ,
    output reg       rd     , 
    output reg       ld_ir  , 
    output reg       halt   ,
    output reg       inc_pc ,
    output reg       ld_ac  ,
    output reg       wr     ,
    output reg       ld_pc  ,
    output reg       data_e   
);
  
  localparam integer HLT=0, SKZ=1, ADD=2, AND=3, XOR=4, LDA=5, STO=6, JMP=7;
  
  reg A, H, Z, J, S;

  always @*
  begin 
    A = (opcode==ADD || opcode==AND || opcode==XOR || opcode==LDA);
    H = (opcode==HLT);
    Z = (opcode==SKZ && zero);
    J = (opcode==JMP);
    S = (opcode==STO);

    case (phase)
      0: begin  sel=1; rd=0; ld_ir=0; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
      1: begin  sel=1; rd=1; ld_ir=0; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
      2: begin  sel=1; rd=1; ld_ir=1; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
      3: begin  sel=1; rd=1; ld_ir=1; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end 
      4: begin  sel=0; rd=0; ld_ir=0; halt=H; inc_pc=1; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
      5: begin  sel=0; rd=A; ld_ir=0; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
      6: begin  sel=0; rd=A; ld_ir=0; halt=0; inc_pc=Z; ld_ac=0; ld_pc=J; wr=0; data_e=S; end
      7: begin  sel=0; rd=A; ld_ir=0; halt=0; inc_pc=0; ld_ac=A; ld_pc=J; wr=S; data_e=S; end
    endcase
  end 

endmodule