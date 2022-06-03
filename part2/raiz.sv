module raiz 
    #(parameter n = 8)
    (
        input [n-1:0] data_in,
        input [8:0] controler,
        input clock, reset,
        output [n-1:0] data_out,
        output [31:0] cycles = 0,
        output done
    );

    //-------------------- Outputs Modules -----------------------
    // Muxs
    logic [n-1:0] sig_muxD, sig_muxS, sig_muxA, sig_muxB;
    // Registers
    logic [n-1:0] sigD, sigS, sigR, sigX;
    // ULA
    logic [n-1:0] sig_ula;
    // Desl
    logic [n-1:0] sig_desl;

    //-------------------- Modules -------------------------------
    // Muxs
    mux2 #(n) muxD (.a(sig_ula), .b(2),       .s(controler[8]), .q(sig_muxD));
    mux2 #(n) muxS (.a(sig_ula), .b(4),       .s(controler[7]), .q(sig_muxS));
    mux2 #(n) muxA (.a(sigD),    .b(~(sigX)), .s(controler[2]), .q(sig_muxA));
    mux2 #(n) muxB (.a(sigS),    .b(2),       .s(controler[1]), .q(sig_muxB));
    // Registrers
    register #(n) rD (.data_in(sig_muxD), .enable(controler[6]), .data_out(sigD), .clock(clock), .reset(reset));
    register #(n) rS (.data_in(sig_muxS), .enable(controler[5]), .data_out(sigS), .clock(clock), .reset(reset));
    register #(n) rR (.data_in(sig_desl), .enable(controler[4]), .data_out(sigR), .clock(clock), .reset(reset));
    register #(n) rX (.data_in(data_in),  .enable(controler[3]), .data_out(sigX), .clock(clock), .reset(reset));
    // ULA
    adder #(n) ula(.a(sig_muxA), .b(sig_muxB), .cin(controler[0]), .q(sig_ula), .n(done));
    // Desl
    shifter #(n) desl(.in(sig_ula), .out(sig_desl));

    //-------------------- Outputs Raiz --------------------------
    assign data_out = sigR;

    always @(posedge clock, negedge reset)
        if(!reset) begin 
            data_out = 0;
            cycles = 0;
        end
        else cycles = cycles + 1;

endmodule