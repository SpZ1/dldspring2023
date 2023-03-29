`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2021 06:40:11 PM
// Design Name: 
// Module Name: top_demo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_demo
(
  // input
  input  logic [7:0] sw,
  input  logic [3:0] btn,
  input  logic       sysclk_125mhz,
  input  logic       rst,
  // output  
  output logic [7:0] led,
  output logic sseg_ca,
  output logic sseg_cb,
  output logic sseg_cc,
  output logic sseg_cd,
  output logic sseg_ce,
  output logic sseg_cf,
  output logic sseg_cg,
  output logic sseg_dp,
  output logic [3:0] sseg_an
);

  logic [16:0] CURRENT_COUNT;
  logic [16:0] NEXT_COUNT;
  logic        smol_clk;
  
  // Place FSM instantiation here
  logic clk_en;
  logic [3:0] state;
  clk_div slow (sysclk_125mhz,btn[3],clk_en);
  fsmLight dut (clk_en, btn[3], btn[0], btn[1], btn[2], state);
  always_comb
     case (state)
     
       4'd0: begin
            led[6:1] <= 6'b000000;
       end

       4'd1: begin
            led[6:1] <= 6'b001000;
       end

       4'd2: begin
            led[6:1] <= 6'b011000;
       end

       4'd3: begin
            led[6:1] <= 6'b111000;
       end

       4'd4: begin
            led[6:1] <= 6'b000100;
       end

       4'd5: begin
            led[6:1] <= 6'b000110;
       end

       4'd6: begin
            led[6:1] <= 6'b000111;
       end

       4'd7: begin
            led[6:1] <= 6'b001100;
       end

       4'd8: begin
            led[6:1] <= 6'b011110;
       end

       4'd9: begin
            led[6:1] <= 6'b111111;
       end
       default: begin
            led[6:1] <= 6'b000000;
       end
     endcase
  // 7-segment display
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
  .digit0(sw[3:0]),
  .digit1(4'b0111),
  .digit2(sw[7:4]),
  .digit3(4'b1111),
  .decimals({1'b0, btn[2:0]}),
  .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
  .digit_anodes(sseg_an)
  );

// Register logic storing clock counts
  always@(posedge sysclk_125mhz)
  begin
    if(btn[3])
      CURRENT_COUNT = 17'h00000;
    else
      CURRENT_COUNT = NEXT_COUNT;
  end
  
  // Increment logic
  assign NEXT_COUNT = CURRENT_COUNT == 17'd100000 ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = CURRENT_COUNT == 17'd100000 ? 1'b1 : 1'b0;

endmodule
