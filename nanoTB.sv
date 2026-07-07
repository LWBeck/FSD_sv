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
      0: 'h0141,   // R1 = PMEM[20] | A
      1: 'h0152,   // R2 = PMEM[21] | B

      2: 'h7312,   // R3 = (A<B)
      3: 'h3083,   // se R3 = 1 pula para 8
      4: 'h7321,   // R3 = (B<A)
      5: 'h30a3,   // se R3 = 1 pula para 10

      6: 'h1161,   // escreve A em PMEM[22]
      7: 'hF000,   // se não fazer nenhum salto termina

      8: 'h5221,   // R2 = R2 - R1 
      9: 'h2020,   // salto para 2

      10: 'h5112,   // R1 = R1 - R2
      11: 'h2020,   // salto para 2

      20: 'd2528,
      21: 'd294,
      22: 'h0000,
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
