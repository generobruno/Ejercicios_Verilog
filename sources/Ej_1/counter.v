module counter
    #(
        // PARAMETERS
        parameter NB_DATA   = 160,
        parameter NB_CNT    = 64
    )
    (
        // OUTPUTS
        output wire [NB_CNT - 1 : 0]    o_counter,
        output wire                     o_alarm_cnt,
        // INPUTS
        input wire                      i_valid,
        // CLOCKS & RESET
        input wire                      i_reset,
        input wire                      i_clock
    );

    localparam MAX_COUNT = 8;

    wire [NB_CNT - 1 : 0]   next_count;
    reg [NB_CNT - 1 : 0]    count;

    assign next_count <= count + {NB_CNT-1{1'b0},1'b1};

    always @(posedge i_clock) 
    begin: counter_valid
        if(i_reset || o_alarm_cnt)      // Clean Registers
            count <= {NB_CNT{1'b0}};
        else if (i_valid)               // Counter Valid
            count <= next_count;
    end

    assign o_alarm_cnt = (count == MAX_COUNT);

endmodule