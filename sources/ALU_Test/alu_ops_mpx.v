/**

**/

module alu_ops_mpx
    #(
        // Parameters
        parameter N_SW = 16,
        parameter N_BUTTON = 3
    )(
        // Inputs
        input                     i_clock,
        input [N_COUNT-1 : 0]     i_SW_A,
        input [N_COUNT-1 : 0]     i_SW_B,
        input [N_COUNT-1 : 0]     i_SW_OP,
        // Outputs
        output [N_COUNT]          o_SW_OUT  
    );



endmodule