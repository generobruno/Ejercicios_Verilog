module counter_tb;
    // Declaraciones
    localparam  N_COUNT = 16;
    reg     i_clock;
    reg     i_reset;
    wire    o_count;
    reg     i_valid;

    initial // Inicializacion de señales
    begin
        i_clock = 0;
        i_reset = 0;
        #50
        i_reset=1;
        #50
        i_reset=0;
    end

    initial // Generamos inputs aleatorios
    begin
        i_valid = 0;
        #25
        i_valid = 1;
        forever #50 i_valid = ~$random;
    end
    
    // Generación de Clock
    always #25 i_clock = ~i_clock;

    // Instanciamos el contador
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
    );

endmodule