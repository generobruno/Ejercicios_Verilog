/**

**/

module ForwardingUnit
    #(
        // Parameters
        parameter FORW_EQ = 2,
        parameter FORW_ALU = 3
    )
    (
        // Inputs
        input [4 : 0]                   i_instr_rs_D,               // Instruction RS from ID (instr[25:21])
        input [4 : 0]                   i_instr_rt_D,               // Instruction RT from ID (instr[20:16])
        input [4 : 0]                   i_instr_rt_E,               // Instruction RT from EX (instr[20:16])
        input [4 : 0]                   i_instr_rs_E,               // Instruction RS from EX (instr[25:21])
        input [4 : 0]                   i_instr_rd_M,               // Instruction RD from MEM (instr[15:11])
        input [4 : 0]                   i_instr_rd_W,               // Instruction RD from WB (instr[15:11])
        input                           i_reg_write_M,              // RegWrite Control Line from MEM
        input                           i_reg_write_W,              // RegWrite Control Line from WB
        // Outputs
        output [FORW_EQ-1 : 0]           o_forward_eq_a_FU,         // Forwarding Eq A Control Line
        output [FORW_EQ-1 : 0]           o_forward_eq_b_FU,         // Forwarding Eq B Control Line
        output [FORW_ALU-1 : 0]          o_forward_a_FU,            // Forwarding A Control Line
        output [FORW_ALU-1 : 0]          o_forward_b_FU             // Forwarding B Control Line
    );

    //! Signal Declaration
    reg forward_eq_a;         
    reg forward_eq_b;         
    reg forward_a;
    reg forward_b;

    // Body
    always @(*) 
    begin
        // ALU Forward A
        if((i_instr_rs_E != 0) & (i_instr_rs_E == i_instr_rd_M) & i_reg_write_M)
            begin
                forward_a = 2'b10;
            end
        else if((i_instr_rs_E != 0) & (i_instr_rs_E == i_instr_rd_W) & i_reg_write_W)
            begin
                forward_a = 2'b01;
            end
        else
            begin
                forward_a = 2'b00;
            end

        // ALU Forward B
        if((i_instr_rt_E != 0) & (i_instr_rt_E == i_instr_rd_M) & i_reg_write_M)
            begin
                forward_b = 2'b10;
            end
        else if((i_instr_rt_E != 0) & (i_instr_rt_E == i_instr_rd_W) & i_reg_write_W)
            begin
                forward_b = 2'b01;
            end
        else
            begin
                forward_b = 2'b00;
            end

        // Comparator Forwarding
        if((i_instr_rs_D != 0) & (i_instr_rs_D == i_instr_rd_M) & i_reg_write_M)
            begin
                forward_eq_a = 1'b1;
            end
        else if((i_instr_rt_D != 0) & (i_instr_rt_D == i_instr_rd_M) & i_reg_write_M)
            begin
                forward_eq_b = 1'b1;
            end
        else 
            begin
                forward_eq_a = 1'b0;
                forward_eq_b = 1'b0;
            end
    end

    //! Assignments
    assign o_forward_eq_a_FU    =   forward_eq_a;     
    assign o_forward_eq_b_FU    =   forward_eq_b;
    assign o_forward_a_FU       =   forward_a;
    assign o_forward_b_FU       =   forward_b;

endmodule