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
        output [2 : 0]                  o_alu_op_MC,                // ALUOp0 Control Line
        output                          o_reg_dst_MC,               // RegDst Control Line
        output                          o_jal_sel_MC,               // JALSel Control Line
        output                          o_alu_src_MC,               // ALUSrc Control Line
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

    //! Local Parameters
    localparam R_TYPE   =       6'b000000;      // R-Type OpCode
    // ALU Operations Function Fields
    localparam ADDU =       6'b100001;      // Add Word Unsigned
    localparam SUBU =       6'b100011;      // Subtract Word Unsigned
    localparam AND  =       6'b100100;      // Logical bitwise AND 
    localparam OR   =       6'b100101;      // Logical bitwise OR
    localparam XOR  =       6'b100110;      // Logical bitwise XOR
    localparam NOR  =       6'b100111;      // Logical bitwise NOR

    localparam SLT  =       6'b101010;      // Set on Less Than

    localparam SRA  =       6'b000011;      // Shift Word Right Arithmetic
    localparam SRL  =       6'b000010;      // Shift Word Right Logic
    localparam SLL  =       6'b000000;      // Shift Word Left Logic

    localparam SLLV =       6'b000100;      // Shift Word Left Logic Variable
    localparam SRLV =       6'b000110;      // Shift Word Right Logic Variable
    localparam SRAV =       6'b000111;      // Shift Word Right Arithmetic Variable

    // Jump Function Fields
    localparam JR       =       6'b001000;
    localparam JALR     =       6'b001001;

    // OpCode Fields
    localparam LB       =       6'b100000;      // Load Byte
    localparam LH       =       6'b100001;      // Load Halfword
    localparam LW       =       6'b100011;
    localparam LWU      =       6'b100110;
    localparam LBU      =       6'b100100;
    localparam LHU      =       6'b100101;

    localparam SB       =       6'b101000;
    localparam SH       =       6'b101001;
    localparam SW       =       6'b101011;

    localparam ADDI     =       6'b001000;
    localparam ANDI     =       6'b001100;
    localparam ORI      =       6'b001101;
    localparam XORI     =       6'b001110;
    localparam LUI      =       6'b001111;
    localparam SLTI     =       6'b001010;

    localparam BEQ      =       6'b000100;
    localparam BNE      =       6'b000101;

    localparam J        =       6'b000010;
    localparam JAL      =       6'b000011;
    

    localparam LOAD     =       3'b100;
    localparam STORE    =       3'b101;
    localparam IMM      =       3'b001;
    localparam SPECIAL  =       3'b000;


    // Body
    always @(*) 
    begin
        case(i_instr_op_D[3+:3]) // bits 3 a 5
            SPECIAL: 
            begin
                case()  // bits 0 a 3
                    R_TYPE: 
                    begin
                        case(i_instr_funct_D) // Function Field

                        endcase
                    end

                endcase
            end
            LOAD:
            begin
                
            end
            STORE:
            begin

            end
            IMM:
            begin

            end
            default:
            begin   

            end
        endcase    
    end

endmodule