// =============================================================
// Testbench
// Verifica o módulo controlador (top-level)
//
// Cobertura:
//   - Modo normal (modo=00): todos os 4 casos de sensor
//   - Modo pedestre (modo=01): com e sem veículos
//   - Modo emergência (modo=10): sensores ignorados
//   - Modo manutenção (modo=11): sensores ignorados
//   - Prioridade entre modos
//
// Saída: log com OK/FAIL por teste + resumo final
// =============================================================

module tb;

    // --- Sinais ---
    logic       sensor_ns, sensor_lo, som;
    logic [1:0] modo;
    logic [2:0] nsLD, loLD;

    // --- Constantes de luz ---
    localparam logic [2:0]
        VERDE   = 3'b100,
        LARANJA = 3'b010,
        VERM    = 3'b001;

    // --- DUT ---
    controlador dut (
        .sensor_ns (sensor_ns),
        .sensor_lo (sensor_lo),
        .modo      (modo),
        .nsLD      (nsLD),
        .loLD      (loLD),
        .som       (som)
    );

    // --- Contadores ---
    int pass_cnt = 0, fail_cnt = 0;

    function automatic string cor_luz(input logic [2:0] luz);
       case (luz)
        VERDE   : cor_luz = "VERDE";
        LARANJA : cor_luz = "LARANJA";
        VERM    : cor_luz = "VERM";
        default : cor_luz = "INV";
      endcase
    endfunction

    // --- Task de verificação ---
    task automatic check (
        input logic       sns,
        input logic       sle,
        input logic [1:0] md,
        input logic [2:0] exp_ns,
        input logic [2:0] exp_lo,
        input logic       exp_som,
        input string      label
    );
        sensor_ns = sns;
        sensor_lo = sle;
        modo      = md;
        #5;
        if (nsLD === exp_ns && loLD === exp_lo && som === exp_som) begin
            $display("  OK   [%-20s]  [modo=%b%b sns=%b sle=%b] ns=%b%b%b %-8s le=%b%b%b %-8s som=%b",
                     label, md[1], md[0], sns, sle,
                            nsLD[2], nsLD[1], nsLD[0], cor_luz(nsLD),
                            loLD[2], loLD[1], loLD[0], cor_luz(loLD), som);
            pass_cnt++;
        end else begin
            $display("  FAIL [%-20s]  esp: [modo=%b%b sns=%b sle=%b] ns=%b%b%b %-8s le=%b%b%b %-8s som=%b",
                     label, md[1], md[0], sns, sle,
                            nsLD[2], nsLD[1], nsLD[0], cor_luz(nsLD),
                            loLD[2], loLD[1], loLD[0], cor_luz(loLD), som);
            fail_cnt++;
        end
    endtask

    // --- Vetores de teste ---
    initial begin
        $display("\n============================================================");
        $display("  TESTBENCH — Controlador de Semáforo");
        $display("============================================================");

        $display("\n--- Modo normal ---------");
        check(0,0, 2'b00, VERDE,   VERM,    0, "normal");
        check(1,0, 2'b00, VERDE,   VERM,    0, "normal");
        check(0,1, 2'b00, VERM,    VERDE,   0, "normal");
        check(1,1, 2'b00, VERDE,   VERM,    0, "normal");

        $display("\n--- Modo pedestre ---------");
        check(0,0, 2'b01, VERM,    VERM,    1, "pedestre");
        check(0,1, 2'b01, VERM,    VERM,    1, "pedestre");
        check(1,0, 2'b01, VERM,    VERM,    1, "pedestre");
        check(1,1, 2'b01, VERM,    VERM,    1, "pedestre");

        $display("\n--- Modo emergencia ---------");
        check(0,0, 2'b10, VERM,    VERM,    0, "emergencia");
        check(1,1, 2'b10, VERM,    VERM,    0, "emergencia");
        check(1,0, 2'b10, VERM,    VERM,    0, "emergencia");
        check(0,1, 2'b10, VERM,    VERM,    0, "emergenciao");

        $display("\n--- Modo manutenção ------");
        check(0,0, 2'b11, LARANJA, LARANJA, 0, "manutencao");
        check(0,1, 2'b11, LARANJA, LARANJA, 0, "manutencao");
        check(1,0, 2'b11, LARANJA, LARANJA, 0, "manutencao");
        check(1,1, 2'b11, LARANJA, LARANJA, 0, "manutencao");

        $display("\n--- Alternancia entre modos ---");
        check(0,0, 2'b10, VERM,    VERM,    0, "emergencia");
        check(1,1, 2'b00, VERDE,   VERM,    0, "normal 11");
        check(1,1, 2'b01, VERM,    VERM,    1, "pedestre");
        check(0,1, 2'b00, VERM,    VERDE,   0, "normal 00");
        check(1,1, 2'b11, LARANJA, LARANJA, 0, "manutencao");
        check(1,0, 2'b00, VERDE,   VERM,    0, "normal 10");

        // --------------------------------------------------------
        $display("\n============================================================");
        $display("  RESULTADO FINAL");
        $display("  Passou : %0d", pass_cnt);
        $display("  Falhou : %0d", fail_cnt);
        $display("  Total  : %0d", pass_cnt + fail_cnt);
        if (fail_cnt == 0)
            $display("  Status : TODOS OS TESTES PASSARAM");
        else
            $display("  Status : %0d TESTE(S) FALHARAM", fail_cnt);
        $display("============================================================\n");

        $finish;
    end

endmodule
