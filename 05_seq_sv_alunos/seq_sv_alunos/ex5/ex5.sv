/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

// ************************************************************
// MÓDULO EX5 — Registradores com multiplexadores condicionais
// ************************************************************

module ex5 #(
    parameter int N = 8
)(
    input logic clock, reset,
    input logic enableA, enableB,
    input logic SA, SB,
    input logic [N-1:0] X, Y,
    output logic [N-1:0] RB
);

    logic [N-1:0] xmux, ymux, regA, regB;

    assign RB = regB;
    assign xmux = (SA) ? X : regB;
    assign ymux = (SB) ? Y : regA;

    always_ff @( posedge clock or posedge reset ) begin
        if (reset) begin
            regA <= '0;
            regB <= '0;
        end else begin
            regA <= (enableA) ? xmux : regA;
            regB <= (enableB) ? ymux : regB;
        end
    end

endmodule
