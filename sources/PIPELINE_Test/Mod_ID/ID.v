/**

**/

module ID
    #(
        // Parameters
        parameter INST_SZ = 32,
        parameter REG_SZ = 5,
        parameter FORW_EQ = 2
    )
    (
        // Inputs
        input [INST_SZ-1 : 0]           i_instruction_D,            // Instruction Fetched
        input [INST_SZ-1 : 0]           i_npc_D,                    // NPC
        input [FORW_EQ-1 : 0]           i_forward_eq_a_FU,          // Forwarding Eq A Control Line
        input [FORW_EQ-1 : 0]           i_forward_eq_b_FU,          // Forwarding Eq B Control Line
        input [INST_SZ-1 : 0]           i_alu_result_M,             // Previous ALU Result (for Eq Forward)
        input                           i_branch_MC,                // Branch Control Line
        input                           i_equal_MC,                 // Equal Control Line
        input                           i_reg_write_W,              // RegWrite Control Line
        input [REG_SZ-1 : 0]            i_write_register_D,         // Write Register
        input [INST_SZ-1 : 0]           i_write_data_D,             // Write Data
        // Outputs
        output [INST_SZ-1 : 0]          o_jump_addr_D,              // Jump Address
        output [INST_SZ-1 : 0]          o_read_data_1_D,            // Read Data 1 (from reg mem)
        output [INST_SZ-1 : 0]          o_read_data_2_D,            // Read Data 2 (from reg mem)
        output                          o_pc_src_D,                 // PCSrc Control Line
        output [31 : 26]                o_instr_op_D,               // Instruction Op Code
        output [5 : 0]                  o_instr_funct_D,            // Instruction Function
        output [25 : 0]                 o_instr_index_D,            // Instruction Index
        output [15 : 0]                 o_instr_imm_D,              // Instruction Immediate
        output [25 : 21]                o_instr_rs_D,               // Instruction RS
        output [20 : 16]                o_instr_rt_D,               // Instruction RT
        output [15 : 11]                o_instr_rd_D                // Instruction RD
    );

    // TODO Instanciar: Branch_Addr_Adder, Register_Memory, Comparator, MPX (x2)

endmodule