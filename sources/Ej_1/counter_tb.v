module counter_tb                  ;
    localparam  N_COUNT= 5               ;
    reg     i_clock                      ;
    reg     i_reset                      ;
    wire    o_count                      ;
    reg     i_valid                      ;
    initial
    begin
            i_clock = 0                  ;
            i_reset = 0                  ;
        #50
        i_reset=1                        ;
        #50
        i_reset=0                        ;
    end


    initial 
    begin
        i_valid = 0;
        #25
        i_valid = 1;
        forever #50 i_valid = ~$random   ;
    end
    
    always #25 i_clock = ~i_clock        ;

    counter 
    #(
        .N_COUNT(N_COUNT)
    )
    u_counter
    (
        .i_clock(i_clock),
        .i_valid(i_valid),
        .i_reset(i_reset), 
        .o_count(o_count)
    )                                   ;

endmodule