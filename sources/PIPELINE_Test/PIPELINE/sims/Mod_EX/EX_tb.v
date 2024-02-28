`timescale 1ns/10ps

module EX_tb();
    // Parameters
    localparam INST_SZ = 32;
    localparam ALU_OP = 3;
    localparam FORW_ALU = 2;
    localparam ALU_SEL = 6;

    // Declarations
    reg [INST_SZ-1 : 0]           i_instruction;

    reg [INST_SZ-1 : 0]           read_data_1;            
    reg [INST_SZ-1 : 0]           read_data_2;            
    reg [INST_SZ-1 : 0]           alu_result;             
    reg [INST_SZ-1 : 0]           read_data;              
    reg                           alu_src; 
    reg                           reg_dst; 
    reg                           jal_sel; 
    reg [ALU_OP-1 : 0]            alu_op;  
    reg [FORW_ALU-1 : 0]          forward_a;          
    reg [FORW_ALU-1 : 0]          forward_b;          
    wire [INST_SZ-1 : 0]          instr_imm;              
    wire [4 : 0]                  instr_rt;   
    wire [4 : 0]                  instr_rd;   
    wire [4 : 0]                  sa;       

    wire [INST_SZ-1 : 0]          o_alu_result;      
    wire [INST_SZ-1 : 0]          o_operand_b;        
    wire [4 : 0]                  o_instr_rd; 

    reg [INST_SZ-1 : 0] seed;
    reg [INST_SZ-1 : 0] expected_res;    
    reg [4 : 0]         reg_instr_rt;   
    reg [4 : 0]         reg_instr_rd;   
    reg [4 : 0]         reg_sa;  

    // Instantiations
    EX #(.INST_SZ(INST_SZ), .ALU_OP(ALU_OP), .FORW_ALU(FORW_ALU), .ALU_SEL(ALU_SEL)) ExecuteInstruction
        (
        // Inputs 
        .i_read_data_1_E(read_data_1), .i_read_data_2_E(read_data_2),
        .i_alu_result_M(alu_result), .i_read_data_W(read_data),
        .i_instr_imm_D(instr_imm), .i_instr_rt_D(instr_rt), 
        .i_instr_rd_D(instr_rd),
        // Input Control Lines //TODO Agregar SXL/SXLV Control Line
        .i_alu_src_MC(alu_src), .i_reg_dst_MC(reg_dst), .i_jal_sel_MC(jal_sel),
        .i_alu_op_MC(alu_op), .i_forward_a_FU(forward_a), .i_forward_b_FU(forward_b),
        // Outputs 
        .o_alu_result_E(o_alu_result), .o_operand_b_E(o_operand_b),
        .o_instr_rd_E(o_instr_rd)
        );
    
    // Task
    initial 
    begin
        seed = 123456;
        expected_res = {INST_SZ{1'b0}};

        read_data_1 = {INST_SZ{1'b0}};
        alu_result = {INST_SZ{1'b0}};
        read_data = {INST_SZ{1'b0}};

        //! SLL Test
        // Control Lines
        reg_dst = 1'b1;
        alu_op = 3'b010;
        alu_src = 1'b0;
        jal_sel = 1'b0;
        forward_a = 1'b0;
        forward_b = 1'b0;

        // Inputs
        reg_instr_rt = $random(seed) % 32;   
        reg_instr_rd = $random(seed) % 32;   
        read_data_2 = $random(seed) & 32'hFFFFFFFF;
        reg_sa = $random(seed) & 5'b11111;

        i_instruction = {6'b000000, 5'b00000, reg_instr_rt, reg_instr_rd, reg_sa, 6'b000000};

        #100;

        // Result Check
        expected_res = read_data_2 << reg_sa;
        if(o_alu_result != expected_res) 
        begin
            $display("\nSLL DID NOT PASS!!!");
            $display("Expected Result: %b", expected_res);
            $display("Actual Result: %b\n", o_alu_result);
            $stop;
        end
        else
        begin
            $display("\nSLL PASSED!");
            $display("Expected Result: %b", expected_res);
            $display("Actual Result: %b\n", o_alu_result);
        end

        //! ADDU Test


        //! LW Test


        //! SW Test


        //! ADDI Test


        //! BEQ Test 

        $stop;
    end

    // Assign instr_rt, instr_rd, and sa using assign statements
    assign instr_rt = i_instruction[25:21];
    assign instr_rd = i_instruction[20:16];
    assign sa = i_instruction[10:6];
    assign instr_imm = {{INST_SZ-16{i_instruction[15]}}, i_instruction[15:0]}; 


endmodule
