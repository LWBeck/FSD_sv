/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

module ex8 (
    input  logic  clock, reset, send, req,
    input  logic [3:0]  entrada,
    output logic [3:0]  saida
);
    logic [3:0] A, B, C, D;
    logic [1:0] contIn, contOut;
    logic [17:0] vet, regSoma;

    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            contIn <= 2'b00;
            A <= '0;
            B <= '0;
            C <= '0;
            D <= '0;
        end else if (send) begin
            contIn <= contIn + 1;
            A <= entrada;
            B <= A;
            C <= B;
            D <= C;
        end
    end

    assign vet = {A, B, C, D};




   /// completar


endmodule
