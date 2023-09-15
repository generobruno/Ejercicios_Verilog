module data_tb();

    parameter                                           N_REPT          =          2                    ;
    parameter                                           N_REPT_2        =          3                    ;
    parameter                                           N_BITS_OUT      =          8                    ;
    parameter                                           N_BITS_IN       =          3                    ;
    wire              [N_BITS_OUT   -1  : 0]            o_extended_bits           [1:0]                 ;
    reg               [N_BITS_IN    -1  : 0]            i_bits                                          ;
    reg                                                 i_clock                                         ;

    initial begin
        i_clock                               =  1'b0;
        i_bits                               <=  0;
    end

    always @(posedge i_clock)
    begin
        i_bits [N_BITS_IN    -1  : 0] <= {1'b1,1'b1,1'b0,1'b1};
    end

    always #20  i_clock = ~i_clock;

    data_repeater 
    #(.N_REPT           (N_REPT),
      .N_BITS_IN        (N_BITS_IN),
      .N_BITS_OUT       (N_BITS_OUT)
    ) u_data_repeater 
    (
      .i_clock          (i_clock),
      .i_bits           (i_bits),
      .o_extended_bits  (o_extended_bits[0])
    );

data_repeater 
    #(.N_REPT           (N_REPT_2),
      .N_BITS_IN        (N_BITS_IN),
      .N_BITS_OUT       (N_BITS_OUT)
    ) u_data_repeater_2 
    (
      .i_clock          (i_clock),
      .i_bits           (i_bits),
      .o_extended_bits  (o_extended_bits[1])
    );

endmodule