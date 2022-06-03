 module mux2
    #(parameter n = 8)
    (
        input s,
        input [n-1:0] a, b,
        output [n-1:0] q
    );

    assign q = s ? a : b;
    
 endmodule