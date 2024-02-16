/**

**/

module MEM
    #(
        // Parameters
        parameter INST_SZ = 32,
    )
    (
        // Inputs
        input [INST_SZ-1 : 0]           i_alu_result_E,             // ALU Result
        input [INST_SZ-1 : 0]           i_operand_b_E,              // Operand B
        input                           i_mem_read_M,               // MemRead Control Line
        input                           i_mem_write_M,              // MemWrite Control Line
        // Outputs
        output [INST_SZ-1 : 0]          o_alu_result_M,             // ALU Result
        output [INST_SZ-1 : 0]          o_read_data_M,              // Read Data (from data mem)
        output [4 : 0]                  o_instr_rd_M                // Instruction RD  (instr[15:11])
    );

    // TODO Instanciar: Data_Memory

endmodule