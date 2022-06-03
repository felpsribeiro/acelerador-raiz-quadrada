module part2(
    // -------------------- Inputs -------------------------------------
    input   KEY[0],                         // RESET
    input   KEY[1],                         // CLOCK     
    input   KEY[3],                         // DATA_READY       
    input   [7:0] SW,                       // DATA_IN
    // -------------------- Outputs ---------------------------------------
    output  LEDG[0],                        // DONE
    output  [6:0] HEX0, HEX1, HEX2, HEX3,   // DATA_IN
    output  [6:0] HEX4, HEX5,               // DATA_OUT
    output  [6:0] HEX6, HEX7                // CYCLES
);

    // -------------------- Registers ------------------------------------
    logic [7:0] data_in = SW;
    logic [3:0] data_out = 0;
    logic [3:0] cycles = 0;
    logic       done;
    logic [8:0] states_controler;


    // -------------------- Calculate Root --------------------------------
    controler c (.clock(KEY[1]), .reset(KEY[0]), .done(done), .out(states_controler));
    raiz #(.n(8)) r (.data_in(data_in), .controler(states_controler), .clock(KEY[1]), .reset(KEY[0]), .data_out(data_out), .cycles(cycles), .done(done));


    // -------------------- Set Outputs -----------------------------------
    // done
    assign LEDG = done;

    // data_in
    dec ent0(.v(data_in % 10),          .d(HEX0));
    dec ent1(.v((data_in % 100) / 10),  .d(HEX1));
    dec ent3(.v(data_in / 100),         .d(HEX2));
    dec ent3(.v(15),                    .d(HEX3));

    // data_out
    dec res0(.v(data_out % 10), .d(HEX4));
    dec res1(.v(data_out / 10), .d(HEX5));

    // number of cycles
    dec cic0(.v(cycles % 10), .d(HEX4));
    dec cic1(.v(cycles / 10), .d(HEX5));

endmodule