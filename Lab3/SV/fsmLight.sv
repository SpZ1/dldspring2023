module fsmLight (clk, reset, a, b, c, y);

   input logic  clk;
   input logic  reset;
   input logic 	a;
   input logic 	b;
   input logic 	c;
   
   output logic [3:0] y;

   typedef enum 	logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)

       S0: begin
	  y <= 4'b0000;	  
	  if (c) nextstate <= S7;
	  else if (b) nextstate <= S4;
    else if (a) nextstate <= S1;
    else nextstate <= S0;
       end

       S1: begin
          y <= 4'b0001;	  	  
          nextstate <= S2;
       end

       S2: begin
	  y <= 4'b0010;	  	  
	  nextstate <= S3;
       end

       S3: begin
    y <= 4'b0011;
    nextstate <= S0;
       end

       S4: begin
	  y <= 4'b0100;	  	  
	  nextstate <= S5;
       end

       S5: begin
	  y <= 4'b0101;	  	  
	  nextstate <= S6;
       end

       S6: begin
    y <= 4'b0110;
    nextstate <= S0;
       end

      S7: begin
	  y <= 4'b0111;	  	  
	  nextstate <= S8;
       end

       S8: begin
	  y <= 4'b1000;	  	  
	  nextstate <= S9;
       end

       S9: begin
    y <= 4'b1001;
    nextstate <= S0;
       end
       default: begin
	  y <= 4'b0000;	  	  
	  nextstate <= S0;
       end
     endcase
   
endmodule
