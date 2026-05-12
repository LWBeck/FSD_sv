// =============================================================
// Módulo controlador:  prioridade + decodificador_semaforo
//
// Entradas: sensor_ns, sensor_lo, modo[1:0]
// Saídas:   nsLD[2:0], loLD[2:0], som
//
// =============================================================

module controlador (
    input logic sensor_ns,
    input logic sensor_lo,
    input logic [1:0] modo,
    output logic [2:0] nsLD,
    output logic [2:0] loLD,
    output logic som
);
  
  logic [2:0] cmd;

  assign cmd = 
    (modo == 2'b00 && sensor_ns == 1'b0 && sensor_lo == 1'b0) ? 3'b000 : // nsLD verde / loNSD vermelho
    (modo == 2'b00 && sensor_ns == 1'b1 && sensor_lo == 1'b0) ? 3'b001 : // nsLD verde / loNSD vermelho
    (modo == 2'b00 && sensor_ns == 1'b0 && sensor_lo == 1'b1) ? 3'b010 : // nsLD vermelho / loNSD verde
    (modo == 2'b00 && sensor_ns == 1'b1 && sensor_lo == 1'b1) ? 3'b011 : // nsLD verde / loNSD vermelho
    (modo == 2'b01) ? 3'b100 : // vermelho e som ligado
    (modo == 2'b10) ? 3'b101 : // vermelho
    3'b110; // laranja

    assign nsLD[2] = ~cmd[2] & (~cmd[1] | cmd[0]);
    assign nsLD[1] = cmd[2] & cmd[1] & ~cmd[0];
    assign nsLD[0] = (cmd[2] & ~cmd[1]) | (~cmd[2] & cmd[1] & ~cmd[0]);

    assign loLD[2] = ~cmd[2] & cmd[1] & ~cmd[0];
    assign loLD[1] = cmd[2] & cmd[1] & ~cmd[0];
    assign loLD[0] = ~cmd[1] | (~cmd[2] & cmd[0]);

    assign som = cmd[2] & ~cmd[1] & ~cmd[0];

endmodule


