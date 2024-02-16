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
        output [5 : 0]                  o_instr_op_D,               // Instruction Op Code (instr[31:26])
        output [5 : 0]                  o_instr_funct_D,            // Instruction Function (instr[5:0])
        output [25 : 0]                 o_instr_index_D,            // Instruction Index (instr[25:0])
        output [15 : 0]                 o_instr_imm_D,              // Instruction Immediate (instr[15:0])
        output [4 : 0]                  o_instr_rs_D,               // Instruction RS (instr[25:21]) 
        output [4 : 0]                  o_instr_rt_D,               // Instruction RT (instr[20:16])
        output [4 : 0]                  o_instr_rd_D                // Instruction RD (instr[15:11])
    );

    // TODO Instanciar: Branch_Addr_Adder, Register_Memory, Comparator, MPX (x2)

endmodule