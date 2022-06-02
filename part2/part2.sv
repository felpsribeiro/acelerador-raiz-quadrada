module part2(
    // -------------------- Entradas -------------------------------------
    input   KEY[0],                         // RESET
    input   KEY[1],                         // CLOCK     
    input   KEY[3],                         // DATA_READY       
    input   [7:0] SW,                       // DATA_IN
    // -------------------- Saidas ---------------------------------------
    output  LEDG[0],                        // saida DONE
    output  [6:0] HEX0, HEX1, HEX2, HEX3,   // valor de entrada da raiz
    output  [6:0] HEX4, HEX5,               // valor do resultado da raiz
    output  [6:0] HEX6, HEX7                // quantidades de ciclos
);

    // -------------------- Registradores --------------------------------
    logic [7:0] entrada = SW;
    logic [3:0] resultado = 0;
    logic [3:0] ciclos = 0;
    logic       done;
    logic [8:0] comando;

    // -------------------- Calcular Raiz --------------------------------
    controler c (.clock(KEY[1]), .reset(KEY[0]), .flag(done), .saida(comando));
    raiz #(.n(8)) r (.data_in(entrada), .controle(comando), .clock(KEY[1]), .reset(KEY[0]), .raiz(resultado), .ciclos(ciclos), .done(done));

    // -------------------- Setar Saidas ---------------------------------
    // sai­da DONE
    assign LEDG = done;
    // exibir valor da entrada
    dec ent0(.v(entrada % 10),          .d(HEX0));  // digito 0
    dec ent1(.v((entrada % 100) / 10),  .d(HEX1));  // digito 1
    dec ent3(.v(entrada / 100),         .d(HEX2));  // digito 2
    dec ent3(.v(15),                    .d(HEX3));  // apagar display
    // exibir valor do resultado
    dec res0(.v(resultado % 10), .d(HEX4));         // digito 0
    dec res1(.v(resultado / 10), .d(HEX5));         // digito 1
    // exibir quantidade de ciclos
    dec cic0(.v(ciclos % 10), .d(HEX4));            // digito 0
    dec cic1(.v(ciclos / 10), .d(HEX5));            // digito 1

endmodule