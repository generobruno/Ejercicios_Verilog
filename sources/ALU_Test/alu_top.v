/**
    Modulo alu_top
    Instancia el ALU con su control de entradas.
**/

module alu_top
    #(
        // Parameters
        parameter N = 5,
        parameter NSel = 6,
        parameter N_SW = (N*2) + NSel
    )
    (
        // Inputs
        input wire                      i_clock,            // Clock
        input wire                      i_reset,            // Reset Button
        input wire [N_SW-1 : 0]         i_switches,         // Switches
        input wire                      i_button_A,         // Button A operand
        input wire                      i_button_B,         // Button B operand
        input wire                      i_button_Op,        // Button Operation
        // Outputs
        output wire [N-1 : 0]           o_LED_Result,       // Result LEDs
        output wire                     o_overflow_Flag,    // Overflow LED
        output wire                     o_zero_Flag         // Zero LED
    );

    //TODO Si N_SW es mayor a 16 -> error

    // Signals
    wire [N-1 : 0] alu_A, alu_B, o_alu_Result;
    wire [N_OP-1 : 0] alu_Op;
    wire ovf_flag, zero_flag;

    //! Instantiate the ALU Input Control
    alu_input_ctrl #(.N_SW(N_SW), .N_OP(NSel), .N_OPERANDS(N)) u_ctrl (
        .i_clock(i_clock),
        .i_reset(i_reset),
        .i_sw(i_switches),
        .i_button_A(i_button_A),
        .i_button_B(i_button_B),
        .i_button_Op(i_button_Op),
        .o_alu_A(alu_A),            
        .o_alu_B(alu_B),
        .o_alu_Op(alu_Op)
    );

    //! Instantiate the ALU module
    alu #(.N(N), .NSel(NSel)) uut (
        .i_clock(i_clock),
        .i_reset(i_reset),
        .i_alu_A(alu_A),
        .i_alu_B(alu_B),
        .i_alu_Op(alu_Op),
        .o_alu_Result(o_alu_Result),
        .o_overflow_Flag(ovf_flag),
        .o_zero_Flag(zero_flag)
    );

    //! Connect Result and flag to LEDs
    assign o_LED_Result         =       o_alu_Result;
    assign o_overflow_Flag      =       ovf_flag;
    assign o_zero_Flag          =       zero_flag;

endmodule
