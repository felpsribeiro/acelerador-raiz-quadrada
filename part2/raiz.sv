module raiz 
    #(parameter n = 8)
    (
        input [n-1:0] data_in,
        input [8:0] controle,
        input clock, reset,
        output [n-1:0] raiz,
        output [] ciclos,
        output done
    );

    logic [n-1:0] sig_ula, sig_desl;

    logic [n-1:0] sig_muxD, sigD;
    mux2 muxD (.a(sig_ula), .b(2), .s(controle[8]), .clock(clock), .reset(reset), .q(sig_muxD));
    register D (.data_in(sig_muxD), .write_enable(controle[6]), .clock(clock), .reset(reset), .data_out(sigD));
    
    logic [n-1:0] sig_muxS, sigS;
    mux2 muxS (.a(sig_ula), .b(4), .s(controle[7]), .clock(clock), .reset(reset), .q(sig_muxS));
    register S (.data_in(sig_muxS), .write_enable(controle[5]), .clock(clock), .reset(reset), .data_out(sigS));
 
    logic [n-1:0] sigR;
    register R (.data_in(sig_desl), .write_enable(controle[4]), .clock(clock), .reset(reset), .data_out(sigR));
    
    logic [n-1:0] sigX;
    register X (.data_in(data_in), .write_enable(controle[3]), .clock(clock), .reset(reset), .data_out(sigX));
    
    logic [n-1:0] sig_muxA;
    mux2 muxA (.a(sigD), .b(~(sigX)), .s(controle[2]), .clock(clock), .reset(reset), .q(sig_muxA));
    
    logic [n-1:0] sig_muxB;
    mux2 muxB (.a(2), .b(sigS), .s(controle[1]), .clock(clock), .reset(reset), .q(sig_muxB));
    
    logic sig_cin;
    mux2 #(.n(1)) muxULA (.a(controle[1]), .b(controle[2]), .s(controle[0]), .clock(clock), .reset(reset), .q(sig_cin));

    adder ula(.a(sig_muxA), .b(sig_muxB), .cin(sig_cin), .clock(clock), .reset(reset), .q(sig_ula));

    shifter desl(.in(sig_ula), .clock(clock), .reset(reset), .out(sig_desl));

endmodule