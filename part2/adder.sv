module adder
    #(parameter n = 8)
    (
        input [n-1:0] a, b,
        input cin, clock, reset, 
        output [n-1:0] q
    );
    
    logic [n-1:0] aux;

    always @(posedge clock, negedge reset)
        if (!reset) aux = 0;
        else aux = a + b + cin;

    assign q = aux;

endmodule
