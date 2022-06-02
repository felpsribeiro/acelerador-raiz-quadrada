module dec(
    input [3:0] v,
    output [6:0] d
);

    always_comb
        case (v)
            0:          d = 7'b1000000; 
            1:          d = 7'b1111001;
            2:          d = 7'b0100100;
            3:          d = 7'b0110000;
            4:          d = 7'b0011001;
            5:          d = 7'b0010010;
            6:          d = 7'b0000010;
            7:          d = 7'b1111000;
            8:          d = 7'b0000000;
            9:          d = 7'b0011000;
            default:    d = 7'b1111111;
        endcase

endmodule