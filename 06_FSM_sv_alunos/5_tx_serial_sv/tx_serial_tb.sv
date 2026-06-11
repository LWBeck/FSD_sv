/**************************************************************
    Fernando Moraes - 22/outubro/2025
**************************************************************/
module tb;

    logic clock = 0;
    logic reset, send;
    logic busy, linha, valid_o;
    logic [7:0] palavra, data_o;

    // DUT instantiation
    transmissor dut (  .clock(clock),     .reset(reset),   .send(send),
                       .palavra(palavra), .busy(busy),    .linha(linha)  );

    rx_serial u_rx (   .clock(clock),   .reset(reset),   .rx_i(linha),
                       .data_o(data_o), .valid_o(valid_o) );


    always #10 clock = ~clock;

    initial begin
        reset = 1;
        #3 reset = 0;
    end

    // Palavra de dados e send
    initial begin
        send = 0; 
        # 50
        palavra = 8'hA5;
        send = 1;  
        #20 
        send = 0;
        #300 palavra = 8'hC7;
        send = 1;  
        #20
        send = 0;
        #300 palavra = 8'h55;
        send = 1;  
        #20
        send = 0;
    end

endmodule
