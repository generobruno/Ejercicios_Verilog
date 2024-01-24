/**

**/

module EX
    #(
        // Parameters
        parameter INST_SZ = 32,
        parameter ALU_OP = 3,
        parameter FORW_ALU = 3
    )
    (
        // Inputs
        input [INST_SZ-1 : 0]           i_read_data_1_E,            // Read Data 1 (from reg mem)
        input [INST_SZ-1 : 0]           i_read_data_2_E,            // Read Data 2 (from reg mem)
        input [INST_SZ-1 : 0]           i_alu_result_M,             // Previous ALU Result (for Forwarding)
        input [INST_SZ-1 : 0]           i_read_data_W,              // Read Data (for Forwarding, from data mem)
        input                           i_alu_src_E,                // ALUSrc Control Line
        input                           i_reg_dst_E,                // RegDst Control Line
        input                           i_jal_sel_E,                // JalSel Control Line
        input [ALU_OP-1 : 0]            i_alu_op_E,                 // ALUOp Control Line
        input [FORW_ALU-1 : 0]          i_forward_a_FU,             // Forwarding A Control Line
        input [FORW_ALU-1 : 0]          i_forward_b_FU,             // Forwarding B Control Line
        input [15 : 0]                  i_instr_imm_D,              // Instruction Immediate
        input [25 : 21]                 i_instr_rs_D,               // Instruction RS
        input [20 : 16]                 i_instr_rt_D,               // Instruction RT
        input [15 : 11]                 i_instr_rd_D,               // Instruction RD

        // Outputs
        output [INST_SZ-1 : 0]          o_alu_result_E,             // ALU Result
        output [INST_SZ-1 : 0]          o_operand_b_E,              // Operand B (for Write Data)
        output                          o_condition_E               // Condition
    );

    // TODO Instanciar: ALU, Alu_Control, MPX (x5)

endmodule