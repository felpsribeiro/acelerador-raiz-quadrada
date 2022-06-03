module part2(
    // -------------------- Inputs ----------------------------------------
    input   [3:0] KEY,                    // 0 = RESET, 1 = CLOCK, 3 = DATA_READY       
    input   [7:0] SW,                     // DATA_IN
    // -------------------- Outputs ---------------------------------------
    output  [0:0] LEDG,                   // DONE
    output  [6:0] HEX0, HEX1, HEX2, HEX3, // DATA_IN
    output  [6:0] HEX4, HEX5,             // DATA_OUT
    output  [6:0] HEX6, HEX7              // CYCLES
);

    // -------------------- Registers ------------------------------------
    logic [7:0] data_in;
    logic [3:0] data_out;
    logic [3:0] cycles;
    logic       done;
    logic [8:0] states_controler;

    always @(posedge KEY[3])
        data_in <= SW;

    // -------------------- Calculate Root --------------------------------
    controler c (.clock(KEY[1]), .reset(KEY[0]), .done(done), .out(states_controler));
    raiz #(.n(8)) r (.data_in(data_in), .controler(states_controler), .clock(KEY[1]), .reset(KEY[0]), .data_out(data_out), .cycles(cycles), .done(done));


    // -------------------- Set Outputs -----------------------------------
    // done
    assign LEDG[0] = done;

    // data_in
    dec ent0(.v(data_in % 10),          .d(HEX0));
    dec ent1(.v((data_in % 100) / 10),  .d(HEX1));
    dec ent2(.v(data_in / 100),         .d(HEX2));
    dec ent3(.v(15),                    .d(HEX3));

    // data_out
    dec res0(.v(data_out % 10), .d(HEX4));
    dec res1(.v(data_out / 10), .d(HEX5));

    // number of cycles
    dec cic0(.v(cycles % 10), .d(HEX6));
    dec cic1(.v(cycles / 10), .d(HEX7));

endmodule