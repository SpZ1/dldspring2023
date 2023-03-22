`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  a;
   logic  b;
   logic  c;
   logic  reset;
   
   logic  y;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   fsmLight dut (clk, reset, a, b, c, y);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%b %b %b %b|| %b", 
		     reset, a, b, c, y);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1;
     #0   a = 1'b0;
     #0   b = 1'b0;
     #0   c = 1'b0;
	#10  reset = 1'b0;	
	#20  a = 1'b1;
	#20  a = 1'b0;
     #20  b = 1'b1;
	#20  b = 1'b0;
     #20  c = 1'b1;
	#20  c = 1'b0;
     end

endmodule // FSM_tb

