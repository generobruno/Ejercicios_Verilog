/**
    TEST:
    Hay 4 7seg Displays en la fpga. Para guardar el valor de los
    I/Os del chip, se usa un esquema de mpx en el tiempo. 
**/

module hex_to_sseg_test
    (
        input wire clk,         // Clock
        input wire [7:0] sw,    // 8-bit switch of board

        output wire [3:0] an,   // 
        output wire [7:0] sseg  // 7seg Display value 
    );

    // Signal declaration
    wire [7:0] inc;
    wire [7:0] led0, led1, led2, led3;

    // Increment input
    assign inc = sw + 1;

    // Instantiate 4 insances of hex decoders 

    // Instance for 4 LSBs of input
    hex_to_sseg sseg_unit_0
        (.hex(sw[3:0]), .dp(1'b0), .sseg(led0));
    // Instance for 4 MSBs of input
    hex_to_sseg sseg_unit_1
        (.hex(sw[3:0]), .dp(1'b0), .sseg(led1));
    // Instance for 4 LSBs of incremented value
    hex_to_sseg sseg_unit_2
        (.hex(inc[3:0]), .dp(1'b1), .sseg(led2));
    // Instance for 4 MSBs of incremented value
    hex_to_sseg sseg_unit_3
        (.hex(inc[3:0]), .dp(1'b1), .sseg(led3));

    // Instantiate 7-seg LED Display time-mpx module
    disp_mux disp_unit
        (.clk(clk), .reset(1'b0), .in0(led0), .in1(led1),
        .in2(led2), .in3(led3), .an(an), .sseg(sseg));

endmodule