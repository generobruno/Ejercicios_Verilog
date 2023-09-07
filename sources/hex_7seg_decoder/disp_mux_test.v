module disp_mux_test
    (
        input wire clk,
        input wire [3:0] btn,
        input wire [7:0] sw,

        output wire [3:0] an,
        output wire [7:0] sseg
    );

    // Signal declaration
    reg [7:0] d3_reg, d2_reg, d1_reg, d0_reg;

    // Instantiate 7-seg display time-mpx module
    disp_mux disp_unit
        (.clk(clk), .reset(1'b0),
        .in0(d0_reg), .in1(d1_reg), .in2(d2_reg), .in3(d3_reg),
        .an(an), .sseg(sseg));

    // Registers for 4 led patterns
    always @(posedge clk) 
    begin
        if(btn[3])
            d3_reg <= sw;
        if(btn[2])
            d2_reg <= sw;
        if(btn[1])
            d1_reg <= sw;
        if(btn[0])
            d0_reg <= sw;
    end

endmodule
