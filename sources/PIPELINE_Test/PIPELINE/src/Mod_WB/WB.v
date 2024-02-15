/**

**/

module WB
    #(
        // Parameters
        parameter INST_SZ = 32,
    )
    (
        // Inputs
        input [INST_SZ-1 : 0]           i_alu_result_M,             // ALU Result
        input [INST_SZ-1 : 0]           i_read_data_M,              // Read Data (from data mem)
        input [INST_SZ-1 : 0]           i_branch_delay_slot_M,      // Branch Delay Slot
        input                           i_mem_to_reg_W,             // MemToReg Control Line
        input                           i_bds_sel_W,                // BDSSel Control Line
        // Outputs
        output [INST_SZ-1 : 0]          o_write_data_W,             // Write Data
    );

    // TODO Instanciar: MPX (x2)

endmodule