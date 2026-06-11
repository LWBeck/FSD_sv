/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module mult_serial (
    input  logic  clock, reset, start,
    input  logic [31:0]  A,
    input  logic [31:0]  B,
    output logic         end_mul,
    output logic [63:0]  produto
);

    // DECLARAR  OS ESTADOS 
    typedef enum logic [1:0] { INIT, SUM, SHIFT, FIM } state;    

    state EA, PE;
    logic [4:0] cont;
    logic [64:0] regP;

    //****************** Bloco de controle ******************
    
    always_ff @(posedge clock or posedge reset) begin
        if (reset)
            EA <= INIT;
        else
            EA <= PE;
    end

    always_comb begin
        unique case (EA)
        INIT : PE = (start) ? SUM : INIT;
        SUM : PE = SHIFT;
        SHIFT : PE = (cont == 0) ? FIM : SUM;
        default : PE = INIT;
        endcase
    end

    //****************** Bloco de dados ******************
    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            regP     <= '0;
            cont     <= '0;
            produto  <= '0;
            end_mul  <= '0;
        end else begin
            case (EA)
                INIT: begin
                    regP[64:32] <= '0;
                    regP[31:0]  <= A;
                    cont        <= '0;
                    end_mul     <= '0;
                     end_mul  <= '0;
                end
                SUM: begin
                    cont <= cont - 1;
                    if (regP[0] == 1'b1)
                        regP[64:32] <= regP[64:32] + {1'b0, B}; // extensão para 33 bits
                end
                SHIFT: begin
                    if (cont == 0)
                        end_mul <= 1'b1;
                    regP <= {1'b0, regP[64:1]};
                end
                FIM: begin
                    produto <= regP[63:0];
                end
            endcase
        end
    end

endmodule
