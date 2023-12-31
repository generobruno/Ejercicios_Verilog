/**
    A mod-M counter counts from 0 to m-1 and wraps around. A parametrized mod-m counter is coded below.
    It has 2 parameters: M, which specifies the limit (m); and N, which specifies the number of bits needed
    and should be equal to log_2(M).
**/

module mod_m_counter
    #(
        // Parameters
        parameter   N       =       4,          // Number of bits in counter
                    M       =       10          // mod-M
    )
    (
        // Inputs
        input wire i_clk,                       // Clock
        input wire i_reset,                     // Reset
        // Outputs
        output wire o_max_tick,                 // Max Tick signal
        output wire [N-1 : 0] o_ticks           // Ticks
    );

    // Signal Declaration
    reg     [N-1 : 0]   r_reg;        
    wire    [N-1 : 0]   r_next;      

    //! Registers
    always @(posedge i_clk, posedge i_reset) 
    begin
        if(i_reset)             // Reset system
            r_reg <= 0;
        else                    // Next state assignments
            r_reg <= r_next;    
    end

    //! Next-State Logic
    assign r_next = (r_reg==(M-1)) ? 0 : r_reg + 1;

    //! Output Logic
    assign o_ticks = r_reg;
    assign o_max_tick = (r_reg==(M-1)) ? 1'b1 : 1'b0;

endmodule