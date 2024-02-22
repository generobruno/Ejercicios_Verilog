/**

**/

module ID
    #(
        // Parameters
        parameter INST_SZ = 32,
        parameter REG_SZ = 5,
        parameter FORW_EQ = 1
    )
    (
        // Inputs
        input                           i_clk,                      // Clock
        //input                           i_reset,                    // Reset
        input [INST_SZ-1 : 0]           i_instruction_D,            // Instruction Fetched
        input [INST_SZ-1 : 0]           i_npc_D,                    // NPC
        input                           i_forward_eq_a_FU,          // Forwarding Eq A Control Line
        input                           i_forward_eq_b_FU,          // Forwarding Eq B Control Line
        input [INST_SZ-1 : 0]           i_alu_result_M,             // Previous ALU Result (for Eq Forward)
        input                           i_branch_MC,                // Branch Control Line
        input                           i_equal_MC,                 // Equal Control Line
        input                           i_reg_write_W,              // RegWrite Control Line
        input [REG_SZ-1 : 0]            i_write_register_D,         // Write Register
        input [INST_SZ-1 : 0]           i_write_data_D,             // Write Data
        input [INST_SZ-1 : 0]           i_branch_delay_slot_F,      // Branch Delay Slot
        // Outputs
        output [INST_SZ-1 : 0]          o_jump_addr_D,              // Jump Address
        output [INST_SZ-1 : 0]          o_branch_addr_D,            // Branch Address
        output [INST_SZ-1 : 0]          o_read_data_1_D,            // Read Data 1 (from reg mem)
        output [INST_SZ-1 : 0]          o_read_data_2_D,            // Read Data 2 (from reg mem)
        output [INST_SZ-1 : 0]          o_branch_delay_slot_D,      // Branch Delay Slot
        output                          o_pc_src_D,                 // PCSrc Control Line
        output [15 : 0]                 o_instr_imm_D,              // Instruction Immediate (instr[15:0])
        output [4 : 0]                  o_instr_rs_D,               // Instruction RS (instr[25:21]) 
        output [4 : 0]                  o_instr_rt_D,               // Instruction RT (instr[20:16])
        output [4 : 0]                  o_instr_rd_D                // Instruction RD (instr[15:11])
    );

    //! Signal Declaration
    wire xnor_result;
    wire comparison;
    wire [INST_SZ-1:0] extended_imm;
    wire [INST_SZ-1:0] shifted_imm;
    wire [INST_SZ-1:0] read_data_1;
    wire [INST_SZ-1:0] read_data_2;

    //! Instantiations
    mpx_2to1 #(.N(INST_SZ)) forw_eq_a_mpx
        (.input_a(read_data_1), .input_b(i_alu_result_M),
        .i_select(i_forward_eq_a_FU),
        .o_output(o_read_data_1_D));

    mpx_2to1 #(.N(INST_SZ)) forw_eq_b_mpx
        (.input_a(read_data_2), .input_b(i_alu_result_M),
        .i_select(i_forward_eq_b_FU),
        .o_output(o_read_data_2_D));

    comparator #(.INST_SZ(INST_SZ)) comparator
        (.i_read_data_1(o_read_data_1_D),
        .i_read_data_2(o_read_data_2_D),
        .o_comparison(comparison));

    register_mem #(.B(INST_SZ), .W()) register_mem
        (.i_clk(i_clk), //TODO Reset?
        .i_reg_write_MC(i_reg_write_W),
        .i_read_reg_1(i_instruction_D[25 : 21]), .i_read_reg_2(i_instruction_D[20 : 16]),
        .i_write_register(i_write_register_D), .i_write_data(i_write_data_D),
        .o_read_data_1(read_data_1), .o_read_data_2(read_data_2));

    //! Assignments
    assign o_instr_imm_D        =      i_instruction_D[15 : 0]; 
    assign o_instr_rs_D         =      i_instruction_D[25 : 21]; 
    assign o_instr_rt_D         =      i_instruction_D[20 : 16]; 
    assign o_instr_rd_D         =      i_instruction_D[15 : 11]; 

    // Shift instruction index to get jump address
    assign o_jump_addr_D = {i_npc_D[31:28], {i_instruction_D[25 : 0] << 2} ,{2{1'b0}}}; //TODO Revisar bien

    // Decide if branch or not
    assign xnor_result = ~(comparison ^ i_equal_MC);
    assign o_pc_src_D = xnor_result & i_branch_MC;

    // Sign extension of o_instr_imm_D to INST_SZ length
    assign extended_imm = {{(INST_SZ-16){o_instr_imm_D[15]}}, o_instr_imm_D};
    // Left shift extended immediate by 2 bits
    assign shifted_imm = extended_imm << 2;
    // Adding shifted immediate to i_npc_D to get o_branch_addr_D
    assign o_branch_addr_D = shifted_imm + i_npc_D;

    assign o_branch_delay_slot_D    =   i_branch_delay_slot_F;    


endmodule