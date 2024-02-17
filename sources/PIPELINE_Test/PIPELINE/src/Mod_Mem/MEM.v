/**

**/

module MEM
    #(
        // Parameters
        parameter INST_SZ = 32,
    )
    (
        // Inputs
        input                           i_clk,                      // Clock
        input                           i_reset,                    // Reset
        input [INST_SZ-1 : 0]           i_alu_result_E,             // ALU Result
        input [INST_SZ-1 : 0]           i_operand_b_E,              // Operand B
        input [INST_SZ-1 : 0]           i_branch_delay_slot_E,      // Branch Delay Slot
        input [4 : 0]                   i_instr_rd_E,               // Instruction RD (instr[15:11])
        input                           i_mem_read_M,               // MemRead Control Line
        input                           i_mem_write_M,              // MemWrite Control Line
        // Outputs
        output [INST_SZ-1 : 0]          o_alu_result_M,             // ALU Result
        output [INST_SZ-1 : 0]          o_read_data_M,              // Read Data (from data mem)
        output [INST_SZ-1 : 0]          o_branch_delay_slot_M,      // Branch Delay Slot
        output [4 : 0]                  o_instr_rd_M                // Instruction RD  (instr[15:11])
    );

    // TODO Instanciar: Data_Memory
    //! Signal Declaration

    //! Instantiation
    data_mem #(.B(INST_SZ), .W()) data_mem
        (.i_clk(i_clk), // TODO Reset
        .i_mem_read(i_mem_read_M), .i_mem_write(i_mem_write_M),
        .i_addr(i_alu_result_E), .i_data(i_operand_b_E),
        .o_data(o_read_data_M));
    
    //! Assignments
    assign o_alu_result_M           =   i_alu_result_E;
    assign o_branch_delay_slot_M    =   i_branch_delay_slot_E;    

endmodule