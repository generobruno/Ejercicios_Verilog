/**

**/

module MainControlUnit
    #(
        // Parameters
    )
    (
        // Inputs
        input [31 : 26]                 i_instr_op_D,               // Instruction Op Code
        input [5 : 0]                   i_instr_funct_D,            // Instruction Function
        // Output
        output                          o_reg_dst_MC,               // RegDst Control Line
        output                          o_jal_sel_MC,               // JALSel Control Line
        output                          o_alu_src_MC,               // ALUSrc Control Line
        output                          o_alu_op_0_MC,              // ALUOp0 Control Line
        output                          o_alu_op_1_MC,              // ALUOp1 Control Line
        output                          o_alu_op_2_MC,              // ALUOp2 Control Line
        output                          o_branch_MC,                // Branch Control Line
        output                          o_equal_MC,                 // Equal Control Line
        output                          o_mem_read_MC,              // MemRead Control Line
        output                          o_mem_write_MC,             // MemWrite Control Line
        output                          o_jump_MC,                  // Jump Control Line
        output                          o_jump_sel_MC,              // JumpSel Control Line
        output                          o_reg_write_MC,             // RegWrite Control Line
        output                          o_bds_sel_MC,               // BDSSel Control Line
        output                          o_mem_to_reg_MC             // MemToReg Control Line
    );

    // TODO Logica

endmodule