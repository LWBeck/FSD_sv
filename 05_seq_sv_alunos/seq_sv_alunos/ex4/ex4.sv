/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

// ************************************************************
// MÓDULO EX4 — Acumulador com Soma de Dois Operandos
// ************************************************************

module ex4 #(
    parameter int N = 8
)(
    input  logic             clock,
    input  logic             reset,
    output logic [N-1:0]     saida
);

    logic [N-1:0] opA, opB, soma;

    assign soma = opA + opB;
    assign saida = opB;

    always_ff @( posedge clock or posedge reset ) begin
        if (reset) begin
            opA <= '0;
            opB <= '0;
        end else begin
            opA <= opA + 1;
            opB <= soma;
        end
        
    end

endmodule
