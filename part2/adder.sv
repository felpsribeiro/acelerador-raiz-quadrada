module adder
    #(parameter n = 8)
    (
        input cin,
        input [n-1:0] a, b,
        output [n-1:0] q,
        output positive_number
    );

    assign q = a + b + cin;
    assign positive_number = !q[n-1];

endmodule
