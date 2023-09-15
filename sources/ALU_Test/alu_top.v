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
        input wire                      i_clock,
        input wire                      i_reset,
        input wire [N_SW-1 : 0]         i_switches,
        input wire                      i_button_A,
        input wire                      i_button_B,
        input wire                      i_button_Op, 
        // Outputs
        output wire [N-1 : 0]           o_LED_Result,
        output wire                     o_overflow_Flag,
        output wire                     o_zero_Flag
    );

    //TODO Si N_SW es mayor a 16 -> error
    //wire [N-1 : 0] alu_A, alu_B, o_alu_Result;

    //! Instantiate the ALU Input Control
    alu_input_ctrl #(.N_SW(N_SW), .N_OP(NSel), .N_OPERANDS(N)) u_ctrl (
        .i_clock(i_clock),
        .i_reset(i_reset),
        .i_sw(i_sw),
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
        .o_overflow_Flag(o_ovf_flag),
        .o_zero_Flag(o_zero_flag)
    );

    //! Connect Result to LEDs
    assign o_LED_Result = o_alu_Result;

endmodule
