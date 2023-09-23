/**
    A Binary Counter circulates through a binary sequence repeatedly. A universal bin counter is more versatile.
    It can count up or down, pause, be loaded with a specific value, or be synchronously cleared.
    Note the difference between "reset" and "syn_clr" signals. The former is asynchronous and should only be
    used for system initialization. The latter is sampled at the rising edge of the clock and can be used in
    normal synchronous design.
**/

module univ_bin_counter
    #(
        parameter N = 8
    )
    (
        input wire clk, reset,
        input wire syn_clr, load, en, up,
        input wire [N-1 : 0] d,
        output wire max_tick, min_tick,
        output wire [N-1 : 0] q
    );

    // Signal Declaration
    reg [N-1 : 0] r_reg, r_next;

    // Register
    always @(posedge clk, posedge reset) 
    begin
        if(reset)
            r_reg <= 0;
        else
            r_reg <= r_next;    
    end

    // Next-State Logic
    always @(*) 
    begin
        if(syn_clr)
            r_next = 0;             // Synchronous clear
        else if(load)
            r_next = d;             // Parallel Load
        else if(en & up)
            r_next = r_reg + 1;     // Count Up
        else if(en & ~up)   
            r_next = r_reg - 1;     // Count Down
        else
            r_next = r_reg;         // Pause
    end

    // Output Logic
    assign q = r_reg;
    assign max_tick = (r_reg==2**N-1) ? 1'b1 : 1'b0;
    assing min_tick = (r_reg==0) ? 1'b1 : 1'b0;

endmodule