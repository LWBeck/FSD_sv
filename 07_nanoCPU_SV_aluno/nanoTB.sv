/*
 * 
 * TEST BEHNCH PARA A NANO CPU 
 * Fernando Gehm Moraes
 * 02/maio/2025
 * 
*/
module nanoCPU_TB;

  timeunit 1ns;
  timeprecision 1ps;

  logic ck, rst;
  logic [15:0] dataR, dataW;
  logic [7:0] address;
  logic we, ce;

  // Memory array signal for 256 x 16-bit positions
  typedef logic [15:0] memory_array_t [0:255];

  memory_array_t memory = '{
      0: 'h0141,   // R1 = PMEM[20]
      1: 'h0152,   // R2 = PMEM[21]

      2: 'h4000,   // R0 = R0 xor R0 (zera o R0)
      3: 'h8000,   // inc R0 (R0 = 1)
      4: 'h7320,   // R3 = (R2 < R0) 
      5: 'h3103,   // se R3 = 1 salta para o fim

      6: 'h4000,   // R0 = R0 xor R0 (zera o R0/quociente)

      7: 'h5112,   // R1 = R1 - R2

      8: 'h4333,   // R3 = R3 xor R3 (zera o R3)
      9: 'h7313,   // R3 = (R1 < 0)
      10: 'h30D3,   // pula para save (13) se R3 = 1
      
      11: 'h8000,  // inc R0 (incrementa o quociente)
      12: 'h2070,  // loop (salto para 7)

      13: 'h6112, // R1 = R1 + R2
      14: 'h1160, // grava R0 (quociente) na memória
      15: 'h1171, // grava R1 (resto) na memória

      16: 'hF000,

      20: 'd100,
      21: 'd22,
      22: 'd0,
      23: 'd0,
    default: 'h0000
  };

    always #1 ck = ~ck;

  NanoCPU CPU ( .ck(ck), .rst(rst), .address(address), .dataR(dataR), .dataW(dataW), .ce(ce), .we(we) );

  always_ff @(posedge ck) begin  // Write to memory
    if (we) begin
      memory[address] <= dataW;
    end
  end
  
  assign dataR = memory[address];   // Read from memory

    // Generate clock and reset signals
  initial begin
    ck = 1'b0;
    rst = 1'b1;
    #2 rst = 1'b0;
  end

endmodule
