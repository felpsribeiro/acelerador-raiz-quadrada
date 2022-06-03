module adder
    #(parameter n = 8)
    (
        input cin,
        input [n-1:0] a, b,
        output [n-1:0] q,
        output n
    );

    assign q = a + b + cin;
    assign n = !q[n-1];

endmodule
