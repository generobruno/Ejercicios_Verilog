/**
    A mod-M counter counts from 0 to m-1 and wraps around. A parametrized mod-m counter is coded below.
    It has 2 parameters: M, which specifies the limit (m); and N, which specifies the number of bits needed
    and should be equal to log_2(M).
**/

module mod_m_counter
    #(
        parameter N = 4,        // Number of bits in counter
        parameter M = 10        // mod-M
    )
    (
        input wire clk, reset,
        output wire max_tick,
        output wire [N-1 : 0] q
    );

    // Signal Declaration
    reg [N-1 : 0] r_reg;
    wire [N-1 : 0] r_next;

    // Register
    always @(posedge clk, posedge reset) 
    begin
        if(reset)
            r_reg <= 0;
        else
            r_reg <= r_next;    
    end

    // Next-State Logic
    assign r_next = (r_reg==(M-1)) ? 0 : r_reg + 1;

    // Output Logic
    assign q = r_reg;
    assign max_tick = (r_reg==(M-1)) ? 1'b1 : 1'b0;

endmodule