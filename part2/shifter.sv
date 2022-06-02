module shifter
    #(parameter n = 8)
    (
        input  [n-1:0] in,
        input clock, reset,
        output [n-1:0] out 
    );

    logic [n-1:0] aux;

    always @(posedge clock, negedge reset)
        if(!reset) aux = 0;
        else aux = in >> 1;

    assign out = aux;

endmodule