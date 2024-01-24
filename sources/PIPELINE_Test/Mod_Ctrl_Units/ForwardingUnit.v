/**

**/

module ForwardingUnit
    #(
        // Parameters
        parameter FORW_EQ = 2,
        parameter FORW_ALU = 3
    )
    (
        // Inputs
        input [25 : 21]                 i_instr_rs_D,               // Instruction RS from ID
        input [20 : 16]                 i_instr_rt_D,               // Instruction RT from ID
        input [25 : 21]                 i_instr_rs_E,               // Instruction RS from EX
        input [15 : 11]                 i_instr_rd_M,               // Instruction RD from MEM
        input [15 : 11]                 i_instr_rd_W,               // Instruction RD from WB
        input                           i_reg_write_M,              // RegWrite Control Line from MEM
        input                           i_reg_write_W,              // RegWrite Control Line from WB
        // Outputs
        output [FORW_EQ-1 : 0]           i_forward_eq_a_FU,         // Forwarding Eq A Control Line
        output [FORW_EQ-1 : 0]           i_forward_eq_b_FU,         // Forwarding Eq B Control Line
        output [FORW_ALU-1 : 0]          i_forward_a_FU,            // Forwarding A Control Line
        output [FORW_ALU-1 : 0]          i_forward_b_FU,            // Forwarding B Control Line
    );

    // TODO Logica

endmodule