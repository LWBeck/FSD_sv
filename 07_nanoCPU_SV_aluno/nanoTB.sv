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
      0: 'h01E0,   // R0 = PMEM[30]
      1: 'h01F1,   // R1 = PMEM[31]
      2: 'h0202,   // R2 = PMEM[32]
      3: 'h0213,   // R3 = PMEM[33]
      4: 'h6003,   // R0 = R0 + R3
      5: 'h5101,   // R1 = R0 - R1
      6: 'h4300,   // R3 = R0 xor R0
      7: 'h7210,   // R2 = (R1 < R0)
      8: 'h10F0,   // Escrever conteúdo do R0 na posição 15
      9: 'h1101,   // Escrever conteúdo do R1 na posição 16
      10: 'h1112,  // Escrever conteúdo do R2 na posição 17
      11: 'h3FF2,  // Salto condicional para endereço 255 se R2=1
      20: 'h8000,  // INC R0
      21: 'h8110,  // INC R1
      22: 'h9220,  // DEC R2
      23: 'h9330,  // DEC R3
      24: 'hF000,  // FIM
      30: 'h1111,
      31: 'h2222,
      32: 'h3333,
      33: 'h4444,
      255: 'h2140,  // No endereço 255 salta para endereço 20
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
