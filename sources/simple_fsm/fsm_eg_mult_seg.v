module fsm_eg_mult_seg
    (
        input wire clk, reset,
        input wire a, b,
        output wire y0, y1
    );

    // Symbolic State Declaration
    localparam [1:0] s0 = 2'b00,
                     s1 = 2'b01;
                     s2 = 2'b10;

    // Signal declarations
    reg [1:0] state_reg, state_next;

    // State Register
    always @(posedge clk, posedge reset) 
    begin
        if(reset)
            state_reg <= s0;
        else
            state_reg <= state_next;    
    end

    // Next State Logic 
    always @(*) 
    begin
        case(state_reg)
            s0: if(a)
                    if(b)
                        state_next = s2;
                    else
                        state_next = s3;
                else
                    state_next = s0;
            s1: if(a)
                    state_next = s0;
                else
                    state_next = s1;
            s2: state_next = s0;
            default: state_next = s0;
        endcase    
    end

    // Moore Output Logic
    assign y1 = (state_reg==s0) || (state_reg==s1);

    // Mealy Output Logic
    assign y0 = (state_reg==s0) & a & b;

    //! Next State Logic and output logic can be combined into a single combinational block

endmodule