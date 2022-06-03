 module register
    #(parameter n = 8)
    (
        input [n-1:0] data_in,
        input clock, reset, enable,
        output [n-1:0] data_out
    );

    logic [n-1:0] data_aux;

    always @(posedge clock, negedge reset) begin
        if(!reset) data_aux = 0;
        else if (enable) data_aux = data_in;
    end

    assign data_out = data_aux;

endmodule