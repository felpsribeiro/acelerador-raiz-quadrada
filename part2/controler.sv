module controler(
    input clock,
    input reset,
    input flag,
    output [8:0] saida
);

    typedef enum logic [1:0] {A, B, C, D} statetype;
    statetype state, nextstate;

    always_ff @ (negedge reset, negedge clock)
        if (!reset) state <= A;
        else state <= nextstate;

    always_comb
        case(state)
            A: begin
                saida <= 9'b001101000;
                nextstate <= B;
            end

            B: begin
                saida <= 9'b101010101;
                nextstate = C;
            end

            C: begin
                saida <= 9'b010100110;
                nextstate = D;
            end

            D: begin
                saida <= 9'b000000011;
                if(flag) nextstate = A; // encerra o processo
                else nextstate = B; // continua o processo
            end
        endcase

endmodule