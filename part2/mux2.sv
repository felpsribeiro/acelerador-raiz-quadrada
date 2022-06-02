 module mux2
    #(parameter n = 8)
    (
        input [n-1:0] a, b,
        input s, clock, reset,
        output [n-1:0] q
    );

    logic [n-1:0] aux;

    always @(posedge clock, negedge reset)
        if (!reset) aux = 0;
        else aux = s ? a : b;

    assign q = aux;
 endmodule