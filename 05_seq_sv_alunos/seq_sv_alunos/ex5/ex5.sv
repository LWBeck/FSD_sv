/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

// ************************************************************
// MÓDULO EX5 — Registradores com multiplexadores condicionais
// ************************************************************

module ex5 #(
    parameter int N = 8;
)(
    input logic clock, reset,
    input logic enableA, enableB,
    input logic SA, SB
    input logic [N-1:0] X, Y,
    output logic [N-1:0] RB
);

    logic [N-1:0] xmux, ymux, REGA, REGB;

    assign RB = REGB;
    assign xmux = (SA) ? X : REGB;
    assign ymux = (SB) ? Y : REGA;

    always_ff @( posedge clock or posedge reset ) begin
        if (reset) begin
            REGA <= '0;
            REGB <= '0;
        end else begin
            REGA <= (enableA) ? xmux : REGA;
            REGB <= (enableB) ? ymux : REGB;
        end
    end

endmodule
