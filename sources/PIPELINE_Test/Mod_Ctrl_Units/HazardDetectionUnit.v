/**

**/

module HazardDetectionUnit
    #(
        // Parameters
    )
    (
        // Inputs
        input                           i_mem_to_reg_M,             // MemToReg from MEM
        input                           i_mem_to_reg_E,             // MemToReg from EX
        input                           i_reg_write_E,              // RegWrite from EX
        input                           i_branch_D,                 // Branch from ID
        input [25 : 21]                 i_instr_rs_D,               // Instruction RS from ID
        input [20 : 16]                 i_instr_rt_D,               // Instruction RT from ID
        input [20 : 16]                 i_instr_rt_E,               // Instruction RT from EX
        input [15 : 11]                 i_instr_rd_E,               // Instruction RD from EX
        input [15 : 11]                 i_instr_rd_M,               // Instruction RD from MEM
        // Outputs
        output                          o_stall_pc_HD,              // Stall PC Control Line
        output                          o_stall_if_id_HD,           // Stall_IF/ID Control Line
        output                          o_flush_id_ex_HD            // Flush_ID/EX Control Line
    );

    // TODO Logica

endmodule