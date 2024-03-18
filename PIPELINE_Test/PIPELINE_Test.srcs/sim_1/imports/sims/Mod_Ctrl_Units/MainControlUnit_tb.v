`timescale 1ns/1ps

module MainControlUnit_tb();

    // Parameters
    localparam INST_SZ = 32;
    localparam OPCODE_SZ = 6;
    localparam FUNCT_SZ = 6;

    // Operation parameters
    localparam SLL      = 32'b000000_00000_00000_00000_00000_000000;
    localparam ADDU     = 32'b000000_00001_00010_00011_00000_100001;
    localparam LW       = 32'b100011_00001_00010_0000000000000000;
    localparam SW       = 32'b101011_00001_00010_0000000000000000;
    localparam ADDI     = 32'b001000_00001_00010_0000000000000000;
    localparam BEQ      = 32'b000100_00001_00010_0000000000000000;
    localparam BNE      = 32'b000101_00001_00010_0000000000000000;
    localparam J        = 32'b000010_00000000000000000000000000;
    localparam JAL      = 32'b000011_00000000000000000000000000;
    localparam JR       = 32'b000000_00001_000000000000000_00100;
    localparam JALR     = 32'b000000_00001_00000_00000_001001;

    // Declarations
    reg [INST_SZ-1 : 0] i_instruction_IF_ID;
    wire alu_op_MC;
    wire reg_dst_MC;
    wire jal_sel_MC;
    wire alu_src_MC;
    wire branch_MC;
    wire equal_MC;
    wire mem_read_MC;
    wire mem_write_MC;
    wire jump_MC;
    wire jump_sel_MC;
    wire reg_write_MC;
    wire bds_sel_MC;
    wire mem_to_reg_MC;

    // Instantiations
    MainControlUnit #(.OPCODE_SZ(OPCODE_SZ), .FUNCT_SZ(FUNCT_SZ)) MainControlUnit
        (
            // Inputs
            .i_instr_op_D(i_instruction_IF_ID[31 : 26]),
            .i_instr_funct_D(i_instruction_IF_ID[5 : 0]),
            // Output Control Lines
            .o_alu_op_MC(alu_op_MC),
            .o_reg_dst_MC(reg_dst_MC),
            .o_jal_sel_MC(jal_sel_MC),
            .o_alu_src_MC(alu_src_MC),
            .o_branch_MC(branch_MC),
            .o_equal_MC(equal_MC),
            .o_mem_read_MC(mem_read_MC),
            .o_mem_write_MC(mem_write_MC),
            .o_jump_MC(jump_MC),
            .o_jump_sel_MC(jump_sel_MC),
            .o_reg_write_MC(reg_write_MC),
            .o_bds_sel_MC(bds_sel_MC),
            .o_mem_to_reg_MC(mem_to_reg_MC)
        );
    
    // Task
    initial 
    begin
        // Shift Instrucion
        i_instruction_IF_ID = SLL;
        #50;
        // 3-Operand ALU Instrucion
        i_instruction_IF_ID = ADDU;
        #50;
        // Normal CPU Load Instrucion
        i_instruction_IF_ID = LW;
        #50;    
        // Normal CPU Store Instrucion
        i_instruction_IF_ID = SW;
        #50;    
        // ALU with imm Instrucion
        i_instruction_IF_ID = ADDI;
        #50;    
        // BEQ Instrucion
        i_instruction_IF_ID = BEQ;
        #50;    
        // BNE Instrucion
        i_instruction_IF_ID = BNE;
        #50;    
        // J Instrucion
        i_instruction_IF_ID = J;
        #50;
        // JAL Instrucion
        i_instruction_IF_ID = JAL;
        #50;
        // JR Instrucion
        i_instruction_IF_ID = JR;
        #50;
        // JALR Instrucion
        i_instruction_IF_ID = JALR;
        #50;          
    end

endmodule