//Coding State Machines on Three Blocks: Combinational Outputs 
//Author: Carlos Henrique Dantas da Costa 

module rcvr
(
  input  wire      clock   ,
  input  wire      reset   ,
  input  wire      data_in ,
  input  wire      reading ,
  output reg       ready   ,
  output reg       overrun ,
  output reg [7:0] data_out
);

  // For proper operation the FSM must hard-code the MATCH
  localparam [7:0] MATCH = 8'hA5 ; // 10100101

  reg [3:0] state, nstate ;

  // Opportunity for Gray encoding as path is mostly linear
  localparam [3:0] HEAD1=4'b0000, HEAD2=4'b0001, HEAD3=4'b0011, HEAD4=4'b0010,
                   HEAD5=4'b0110, HEAD6=4'b0111, HEAD7=4'b0101, HEAD8=4'b0100,
                   BODY1=4'b1100, BODY2=4'b1101, BODY3=4'b1111, BODY4=4'b1110,
                   BODY5=4'b1010, BODY6=4'b1011, BODY7=4'b1001, BODY8=4'b1000;

  reg [6:0] body_reg ;

  //Transitions of the states 
  always @* 
    case ( state )
      HEAD1: nstate = (data_in)  ? HEAD2 : HEAD1;
      HEAD2: nstate = (!data_in) ? HEAD3 : HEAD2;
      HEAD3: nstate = (data_in)  ? HEAD4 : HEAD1;
      HEAD4: nstate = (!data_in) ? HEAD5 : HEAD2;
      HEAD5: nstate = (!data_in) ? HEAD6 : HEAD4; 
      HEAD6: nstate = (data_in)  ? HEAD7 : HEAD1; 
      HEAD7: nstate = (!data_in) ? HEAD8 : HEAD2;
      HEAD8: nstate = (data_in)  ? BODY1 : HEAD1;
      BODY1: nstate = BODY2;
      BODY2: nstate = BODY3;
      BODY3: nstate = BODY4;
      BODY4: nstate = BODY5;
      BODY5: nstate = BODY6;
      BODY6: nstate = BODY7;
      BODY7: nstate = BODY8;
      BODY8: nstate = HEAD1;
    endcase

  //Transitions based on clock 
  always @(posedge clock)
    begin
      if (reset)
        state <= HEAD1;
      else if 
        state <= nstate; 
    end 

  //Actions of the each state
  always @* 
    begin
      // IF STATE IS BODY? THEN SHIFT DATA INPUT LEFT INTO BODY REGISTER
      if (state==BODY1 || state==BODY2 || state==BODY3 || state==BODY4 || 
          state==BODY5 || state==BODY6 || state==BODY7 || state==BODY8)
        body_reg <= {body_reg, data_in};

      // IF STATE IS BODY8 THEN COPY CONCATENATION OF BODY REGISTER AND INPUT
      // DATA TO OUTPUT REGISTER
      if (state==BODY8)
        data_out <= {body_reg, data_in};

      // IF STATE IS BODY8 THEN SET READY ELSE IF READING THEN CLEAR READY
      if (state==BODY8)
        ready <= 1'b1;
      else if (reading)
        ready <= 1'b0;

      // IF READING THEN CLEAR OVERRUN, ELSE
      // IF STATE IS BODY8 AND STILL READY THEN SET OVERRUN
        if (reading)
          overrun <= 1'b0;
        else if (state==BODY8 && ready)
          overrun <= 1'b1;  
    end 


endmodule