module shifter
    #(parameter n = 8)
    (
        input  [n-1:0] in,
        output [n-1:0] out 
    );

    assign out = in >> 1;

endmodule