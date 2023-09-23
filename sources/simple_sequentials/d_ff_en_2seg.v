/**
    The enabling feature of this D FF is useful in maintaining synchronism
    between a fast and a slow subsystem. (p. 88)
**/

module d_ff_en_2seg
    (
        input wire clk, reset,
        input wire en,
        input wire d,
        input reg q
    );

    // Signal declaration
    reg r_reg, r_next;

    // D-FlipFlop
    always @(posedge clk, posedge reset) 
    begin
        if(reset)
            r_reg <= 1'b0;
        else
            r_reg <= r_next;
    end

    // Next-State Logic
    always @(*) 
    begin
        if(en)
            r_next = d;
        else 
            r_next = r_reg;    
    end

    // Output Logic
    always @(*) 
    begin
        q = r_reg;    
    end

endmodule