`timescale 1ns/10ps

module pipeline_tb();
    // Parameters
    localparam T             =   10;    // Clock Period [ns]
    localparam INST_SZ       =   32;
    localparam PC_SZ         =   32;
    localparam OPCODE_SZ     =   6;
    localparam FUNCT_SZ      =   6;
    localparam REG_SZ        =   5;
    localparam MEM_SZ        =   5;
    localparam FORW_EQ       =   1;
    localparam FORW_ALU      =   2;
    localparam ALU_OP        =   3;
    localparam ALU_SEL       =   6;
    localparam FUNCT         =   6;

    // Declarations
    reg i_clk;
    reg i_reset;
    reg i_enable;
    reg i_write;
    reg [INST_SZ-1 : 0]           i_instruction;

    wire [INST_SZ-1 : 0]          o_pc;
    wire [INST_SZ-1 : 0]          o_data;
    wire                          o_halt;

    reg [INST_SZ-1 : 0] seed;
    reg [INST_SZ-1 : 0] expected_res;    
    reg [4 : 0]         reg_instr_rt;
    reg [4 : 0]         reg_instr_rs;   
    reg [4 : 0]         reg_instr_rd;   
    reg [4 : 0]         reg_sa;  
    reg [4 : 0]         reg_base;
    reg [15 : 0]        reg_offset;
    reg [15 : 0]        reg_immediate;

    // Instantiations
    pipeline #() Pipeline
        (
        // Inputs 
        .i_clk(i_clk), .i_reset(i_reset),
        .i_write(i_write), .i_enable(i_enable),
        .i_instruction(i_instruction),
        // Outputs
        .o_pc(o_pc), .o_data(o_data), .o_halt(o_halt)
        );

    // Clock Generation
    always
    begin
        #(T) i_clk = ~i_clk;
    end
    
    // Task
    initial 
    begin
        i_clk = 1'b0;
        i_enable = 1'b0;
        i_reset = 1'b0;
        i_write = 1'b1;
        i_instruction = {INST_SZ{1'b0}};

        seed = 123456;
        expected_res = {INST_SZ{1'b0}};

        i_reset = 1'b1;
        #(T*2);
        i_reset = 1'b0;

        //! SW: Store Test: mem[base+offset] <- rt
        // Inputs
        reg_base = 5'b00000;
        reg_offset = 16'h0005;
        reg_instr_rt = 5'b00011;

        i_instruction = {6'b101011, reg_base, reg_instr_rt, reg_offset};

        #(T*2);

        //! LW: Load Test: rt <- mem[base+offset]
        // Inputs
        reg_base = 5'b00000;
        reg_offset = 16'h0005;
        reg_instr_rt = 5'b00011;

        i_instruction = {6'b100011, reg_base, reg_instr_rt, reg_offset};

        #(T*2);

        //! HALT
        i_instruction = 32'b000000_00000_00000_00000_111111;
        
        #(T*2);
        
        $display("LOADING PROGRAM...");

        i_write = 1'b0;
        i_enable = 1'b1;
        
        $display("RUNNING...");

        // Wait for HALT
        @(posedge o_halt);
        
        $display("PROGRAM FINISHED.");
        
        $stop;
    end

endmodule
