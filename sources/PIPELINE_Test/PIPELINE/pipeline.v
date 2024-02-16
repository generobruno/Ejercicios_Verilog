/**

**/

module pipeline
    #(
        // Parameters
        parameter INST_SZ       =   32,
        parameter PC_SZ         =   32,
        parameter OPCODE_SZ     =   6,
        parameter FUNCT_SZ      =   6,
        parameter REG_SZ        =   5,
        parameter FORW_EQ       =   2,
        parameter FORW_ALU      =   3,
        parameter ALU_OP        =   3,
        parameter FUNCT         =   6
    )
    (
        // Inputs
        input                           i_clk,                      // Clock
        input                           i_reset,                    // Reset
        input                           i_write,                    // Write Memory Control Line
        input [INST_SZ-1 : 0]           i_instruction,              // Saved Instruction
        // Outputs

    );

    //! Signal Declaration
    // TODO Declarar registros para debuggear

    //! Instantiations
    /**
                                INSTUCTION FETCH
    **/
    IF #(.INST_SZ(INST_SZ), .PC_SZ(PC_SZ)) InstructionFetch
        (
        // Sync Signals
        .i_clk(i_clk), .i_reset(i_reset), .i_write(i_write),
        // Inputs
        .i_instruction_F(i_instruction), .i_branch_addr_D(), .i_jump_addr_D(), .i_rs_addr_D(),
        // Input Control Lines
        .i_pc_src_D(), .i_jump_D(), .i_jump_sel_D(), .i_stall_pc_HD(),
        // Outputs
        .o_npc_F(o_npc_F), .o_branch_delay_slot_F(o_branch_delay_slot_F), .o_instruction_F(o_instruction_F)
        );

    /**
                                IF/ID REGISTER
    **/
    IF_ID_Reg #(.INST_SZ(INST_SZ)) IF_ID
        (
        // Sync Signals
        .i_clk(i_clk), .i_reset(i_reset), .i_enable(), //TODO En reset tambien van PCSrc, Jump y JumpSel
        // Inputs
        .i_instruction(o_instruction_F), .i_npc(o_npc_F), .i_bds(o_branch_delay_slot_F),
        // Outputs
        .o_instruction(i_instruction_D), .o_npc(i_npc_D), .o_bds()
        );

    /**
                                INSTRUCTION DECODE
    **/
    ID #(.INST_SZ(INST_SZ), .REG_SZ(REG_SZ), .FORW_EQ(FORW_EQ)) InstructionDecode
        (
        // Inputs
        .i_instruction_D(i_instruction_D), .i_npc_D(i_npc_D),
        // Input Control Lines
        .i_forward_eq_a_FU(), .i_forward_eq_b_FU(), .i_alu_result_M(),
        .i_branch_MC(), .i_equal_MC(),
        .i_reg_write_M(), .i_write_register_D(), .i_write_data_D(),
        // Outputs
        .o_jump_addr_D(), .o_read_data_1_D(), .o_read_data_2_D(),
        .o_pc_src_D(), .o_instr_op_D(), .o_instr_funct_D(), .o_instr_index_D(),
        .o_instr_imm_D(), .o_instr_rs_D(), .o_instr_rt_D(), .o_instr_rd_D()
        );

    /**
                                ID/EX REGISTER
    **/
    ID_EX_Reg #(.INST_SZ(INST_SZ)) ID_EX
        (
        // Sync Signals
        .i_clk(i_clk), .i_reset(i_reset), .i_enable(),
        // Input Control Lines //TODO Agregar SXL/SXLV Control Line
        .i_alu_src(), .i_alu_op(), .i_reg_dst(), .i_jal_sel(), 
        .i_jump(), .i_jump_sel(), .i_mem_read(), .i_mem_write(), 
        .i_reg_write(), .i_mem_to_reg(), .i_bds_sel(),
        // Inputs
        .i_read_data_1(), .i_read_data_2(),
        .i_instr_imm(), .i_instr_rt(), .i_instr_rd(), .i_instr_rs(),
        // Output Control Lines //TODO Agregar SXL/SXLV Control Line
        .o_alu_src(), .o_alu_op(), .o_reg_dst(), .o_jal_sel(), 
        .o_jump(), .o_jump_sel(), .o_mem_read(), .o_mem_write(), 
        .o_reg_write(), .o_mem_to_reg(), .o_bds_sel(),
        // Outputs
        .o_read_data_1(), .o_read_data_2(),
        .o_instr_imm(), .o_instr_rt(), .o_instr_rd(), .o_instr_rs(),
        );


    /**
                                EXECUTE INSTUCTION
    **/
    EX #(.INST_SZ(INST_SZ), .REG_SZ(REG_SZ), .FORW_EQ(FORW_EQ)) ExecuteInstruction
        (
        // Inputs 
        .i_read_data_1_E(), .i_read_data_2_E(),
        .i_alu_result_M(), .i_read_data_W(),
        .i_instr_imm_D(), .i_instr_rs_D(),
        .i_instr_rt_D(), .i_instr_rd_D(),
        // Input Control Lines //TODO Agregar SXL/SXLV Control Line
        .i_alu_src_MC(), .i_reg_dst_MC(), .i_jal_sel_MC(),
        .i_alu_op_MC(), .i_forward_a_FU(), .i_forward_b_FU(),
        // Outputs
        .o_jump_addr_D(), .o_read_data_1_D(), .o_read_data_2_D(),
        .o_pc_src_D(), .o_instr_op_D(), .o_instr_funct_D(), .o_instr_index_D(),
        .o_instr_imm_D(), .o_instr_rs_D(), .o_instr_rt_D(), .o_instr_rd_D()
        );

    /**
                                EX/MEM REGISTER
    **/
    EX_MEM_Reg #(.INST_SZ(INST_SZ)) EX_MEM
        (
        // Sync Signals
        .i_clk(i_clk), .i_reset(i_reset), .i_enable(),
        // Input Control Lines 
        .i_jump(), .i_jump_sel(), .i_mem_read(), .i_mem_write(), 
        .i_reg_write(), .i_mem_to_reg(), .i_bds_sel(),
        // Inputs
        .i_alu_result(), .i_write_data(),
        .i_write_register(), .i_bds(),
        // Output Control Lines 
        .o_jump(), .o_jump_sel(), .o_mem_read(), .o_mem_write(), 
        .o_reg_write(), .o_mem_to_reg(), .o_bds_sel(),
        // Outputs
        .o_alu_result(), .o_write_data(),
        .o_write_register(), .o_bds(),
        );

    /**
                                MEMORY ACCESS
    **/
    MEM #(.INST_SZ(INST_SZ)) MemoryAccess
        (
        // Inputs 
        .i_alu_result_E(), .i_operand_b_E(),
        // Input Control Lines 
        .i_mem_read_M(), .i_mem_write_M(),
        // Outputs
        .o_alu_result_M(), .o_read_data_M(), .o_instr_rd_M()
        );

    /**
                                MEM/WB REGISTER
    **/
    MEM_WB_Reg #(.INST_SZ(INST_SZ)) MEM_WB
        (
        // Sync Signals
        .i_clk(i_clk), .i_reset(i_reset), .i_enable(),
        // Input Control Lines 
        .i_reg_write(), .i_mem_to_reg(), .i_bds_sel(),
        // Inputs
        .i_read_data(), .i_alu_result(),
        .i_write_register(), .i_bds(),
        // Output Control Lines 
        .o_reg_write(), .o_mem_to_reg(), .o_bds_sel(),
        // Outputs
        .o_read_data(), .o_alu_result(),
        .o_write_register(), .o_bds(),
        );

    /**
                                WRITE BACK
    **/
    WB #(.INST_SZ(INST_SZ)) WriteBack
        (
        // Inputs 
        .i_alu_result_M(), .i_read_data_M(),
        .i_branch_delay_slot_M(),
        // Input Control Lines 
        .i_mem_to_reg_W(), .i_bds_sel_W(),
        // Outputs
        .o_write_data_W()
        );

    /**
                                CONTROL UNITS
    **/
    
    //  Main Control Unit
    MainControlUnit #(.OPCODE_SZ(OPCODE_SZ), .FUNCT_SZ(FUNCT_SZ)) MainControlUnit
        (
            // Inputs
            .i_instr_op_D(),
            .i_instr_funct_D(),
            // Output Control Lines
            .o_alu_op_MC(),
            .o_reg_dst_MC(),
            .o_jal_sel_MC(),
            .o_alu_src_MC(),
            .o_branch_MC(),
            .o_equal_MC(),
            .o_mem_read_MC(),
            .o_mem_write_MC(),
            .o_jump_MC(),
            .o_jump_sel_MC(),
            .o_reg_write_MC(),
            .o_bds_sel_MC(),
            .o_mem_to_reg_MC()
        );

    //  Hazard Detection Unit
    HazardDetectionUnit #() HazardDetectionUnit
        (
            // Inputs
            .i_mem_to_reg_M(),             
            .i_mem_read_E(),               
            .i_reg_write_E(),              
            .i_branch_D(),                 
            .i_instr_rs_D(),
            .i_instr_rt_D(),
            .i_instr_rt_E(),
            .i_instr_rd_E(),
            .i_instr_rd_M(),
            // Output Control Lines
            .o_stall_pc_HD(),              
            .o_stall_if_id_HD(),            
            .o_flush_id_ex_HD()             
        );

    //  Forwarding Unit
    ForwardingUnit #(.FORW_EQ(FORW_EQ), .FORW_ALU(FORW_ALU)) ForwardingUnit
        (
            // Inputs
            .i_instr_rs_D(),
            .i_instr_rt_D(),
            .i_instr_rt_E(),
            .i_instr_rs_E(),
            .i_instr_rd_M(),
            .i_instr_rd_W(),
            .i_reg_write_M(),
            .i_reg_write_W(),
            // Output Control Lines
            .o_forward_eq_a_FU(),
            .o_forward_eq_b_FU(),
            .o_forward_a_FU(),
            .o_forward_b_FU(),

        );

    // ALU Control Unit
    ALUControlUnit #(.ALU_OP(ALU_OP), .FUNCT(FUNCT)) ALUControlUnit
        (
            // Inputs
            .i_instr_funct_E(),            
            .i_alu_op_MC(),                 
            // Output Control Lines
            .o_alu_sel_AC(),
        );


endmodule