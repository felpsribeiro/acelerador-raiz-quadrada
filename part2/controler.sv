module controler(
    input clock,
    input reset,
    input done,
    output [8:0] out
);

    typedef enum logic [1:0] {A, B, C, D} statetype;
    statetype state = A, nextstate;

    always_ff @ (negedge reset, negedge clock)
        if (!reset) state <= A;
        else state <= nextstate;

    always_comb
        case(state)
            A: begin
                out <= 9'b001101000;
                nextstate <= B;
            end

            B: begin
                out <= 9'b101010100;
                nextstate <= C;
            end

            C: begin
                out <= 9'b010100111;
                nextstate <= D;
            end

            D: begin
                out <= 9'b000000011;
                if(done) nextstate <= A;
                else nextstate <= B;
            end
        endcase

endmodule