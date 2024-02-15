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
        parameter FORW_EQ       =   2
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
        (.i_clk(i_clk), .i_reset(i_reset), .i_write(i_write),
        .i_instruction_F(i_instruction), .i_branch_addr_D(), .i_jump_addr_D(), .i_rs_addr_D(),
        .i_pc_src_D(), .i_jump_D(), .i_jump_sel_D(), .i_stall_pc_HD(),
        .o_npc_F(o_npc_F), .o_branch_delay_slot_F(o_branch_delay_slot_F), .o_instruction_F(o_instruction_F));

    /**
                                IF/ID REGISTER
    **/
    IF_ID_Reg #(.INST_SZ(INST_SZ)) IF_ID
        (.i_clk(i_clk), .i_reset(i_reset), .i_enable(),
        .i_instruction(o_instruction_F), .i_npc(o_npc_F), .i_bds(o_branch_delay_slot_F),
        .o_instruction(i_instruction_D), .o_npc(i_npc_D), .o_bds());

    /**
                                INSTRUCTION DECODE
    **/
    ID #(.INST_SZ(INST_SZ), .REG_SZ(REG_SZ), .FORW_EQ(FORW_EQ)) InstructionDecode
        (.i_instruction_D(i_instruction_D), .i_npc_D(i_npc_D),
        .i_forward_eq_a_FU(), .i_forward_eq_b_FU(), .i_alu_result_M(),
        .i_branch_MC(), .i_equal_MC(),
        .i_reg_write_M(), .i_write_register_D(), .i_write_data_D(),
        .o_jump_addr_D(), .o_read_data_1_D(), .o_read_data_2_D(),
        .o_pc_src_D(), .o_instr_op_D(), .o_instr_funct_D(), .o_instr_index_D(),
        .o_instr_imm_D(), .o_instr_rs_D(), .o_instr_rt_D(), .o_instr_rd_D());

    /**
                                ID/EX REGISTER
    **/


    /**
                                EXECUTE INSTUCTION
    **/


    /**
                                EX/MEM REGISTER
    **/


    /**
                                MEMORY ACCESS
    **/


    /**
                                MEM/WB REGISTER
    **/


    /**
                                WRITE BACK
    **/


    /**
                                CONTROL UNITS
    **/
    
    //  Main Control Unit
    MainControlUnit #(.OPCODE_SZ(OPCODE_SZ), .FUNCT_SZ(FUNCT_SZ)) MainControlUnit
        ();


endmodule