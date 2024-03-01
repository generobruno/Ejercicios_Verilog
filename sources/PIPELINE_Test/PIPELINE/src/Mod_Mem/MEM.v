/**

**/

module MEM
    #(
        // Parameters
        parameter INST_SZ = 32,
        parameter MEM_SZ  = 5
    )
    (
        // Inputs
        input                           i_clk,                      // Clock
        //input                           i_reset,                    // Reset
        input [INST_SZ-1 : 0]           i_alu_result_E,             // ALU Result
        input [INST_SZ-1 : 0]           i_operand_b_E,              // Operand B
        input                           i_mem_read_M,               // MemRead Control Line
        input                           i_mem_write_M,              // MemWrite Control Line
        // Outputs
        output [INST_SZ-1 : 0]          o_debug_mem,                // Data to send to debugger
        output [INST_SZ-1 : 0]          o_alu_result_M,             // ALU Result
        output [INST_SZ-1 : 0]          o_read_data_M               // Read Data (from data mem)
    );

    //! Instantiation
    data_mem #(.B(INST_SZ), .W(MEM_SZ)) data_mem
        (.i_clk(i_clk), // TODO Reset?
        .i_mem_read(i_mem_read_M), .i_mem_write(i_mem_write_M),
        .i_addr(i_alu_result_E[MEM_SZ-1:0]), .i_data(i_operand_b_E), //TODO Que parte de alu_result se usa?
        .o_data(o_read_data_M), .o_debug_mem(o_debug_mem));
    
    //! Assignments
    assign o_alu_result_M           =   i_alu_result_E;

endmodule