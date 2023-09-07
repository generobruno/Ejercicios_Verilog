module counter
    #(
        parameter N_COUNT = 16,
        parameter N_ALARM = 8
    )
    (
        input           i_clock,
        input           i_valid,
        input           i_reset,
        input [3:0]     i_limit,
        output          o_count
    );

    reg     [N_COUNT - 1 : 0] cnt;
    wire    [N_COUNT - 1 : 0] next_cnt;

    // Variable usada para aumentar el contador sin conflictos
    assign next_cnt = cnt + {{N_COUNT-1 {1'b0}},{1'b1}};

    always @(posedge i_clock) 
    begin
        if(i_reset || o_count)
            cnt <= {N_COUNT {1'b0}};
        else if(i_valid)
            cnt <= next_cnt;
        else
            cnt <= {N_COUNT {1'b1}};
    end

    // Alarma para reiniciar cuenta
    assign o_count = (next_cnt == (N_ALARM || i_limit));

endmodule