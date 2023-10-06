`timescale 1ns/10ps

// The simulation time unit is 1 ns and the simulator time step is 10 ps

module bin_counter_tb();

    // Declarations
    localparam T = 20;      // Clock Period
    reg clk, reset;
    reg syn_clr, load, en, up;
    reg [2:0] d;
    wire max_tick, min_tick;
    wire [2:0] q;

    // Instantiation
    

    // Clock Generation -> 20ns clock
    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end

    // Reset for the first half cycle
    initial 
    begin
        reset = 1'b1;
        #(T/2);
        reset = 1'b0;    
    end

    // Simulations
    initial
    begin
        //  ==== initial input =====
        syn_clr = 1'b0;
        load = 1'b0;
        en = 1'b0;
        up = 1'b1; // count up
        d = 3'b000;
        @(negedge reset); // wait reset to deassert
        @ (negedge clk) ; // wait for one clock

        // ==== test load =====
        load = 1'b1;
        d = 3'b011;
        @ (negedge clk) ; // wait for one clock
        load = 1'b0;
        repeat (2) @(negedge clk) ;

        // ==== test syn-clear ====
        syn_clr = 1'b1; // assert clear
        @ (negedge clk) ;
        syn_clr = 1'b0;

        // ==== test up counter and pause ====
        en = 1 'b1; // count
        up = 1'b1;
        repeat (10) @(negedge clk) ;
        en = 1'b0; // pause
        repeat (2) @ (negedge clk) ;
        en = 1'b1;
        repeat (2) @(negedge clk) ;

        // ==== test down counter ====
        up = 1'b0;
        repeat (10) @(negedge clk) ;

        // ==== wait statement ====
        // continue until q=2
        wait (q==2) ;
        @(negedge clk) ;
        up = 1'b1;

        // continue until min-tick becomes 1
        @(negedge clk) ;
        wait (min-tick) ;
        @(negedge clk) ;
        up = 1'b0;

        // ==== absolute delay ====
        #(4*T); // wait for 80 ns
        en = 1'b0; // pause
        #(4+T); // wait for 80 ns

        // ==== stop simulation ====
        // return to interactive simulation mode
        $stop ;
    end

endmodule