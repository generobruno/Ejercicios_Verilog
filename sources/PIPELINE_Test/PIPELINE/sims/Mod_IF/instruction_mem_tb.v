`timescale 1ns/10ps

module instruction_mem_tb();
    // Parameters
    localparam T = 10;      // Clock Period [ns]
    localparam W = 5;
    localparam INST_SZ = 32;
    localparam PC_SZ = 32;

    // Declarations
    reg i_clk;
    reg i_enable;
    reg i_write;
    reg [INST_SZ-1 : 0] i_instruction;
    reg [PC_SZ-1 : 0] i_addr;

    wire [INST_SZ-1 : 0] o_instruction;

    integer i;

    // Instantiations
    instruction_mem #(.B(INST_SZ), .W(W), .PC(PC_SZ)) inst_mem
        (.i_clk(i_clk),
        .i_write(i_write & ~i_enable), .i_addr(i_addr), .i_data(i_instruction),
        .o_data(o_instruction));

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
        i_write = 1'b0;
        i_instruction = {INST_SZ{1'b0}};
        i_addr = {PC_SZ{1'b0}};

        #(T*2);

        // Write Instructions Test
        $display("\nWrite Instructions Test\n");
        i_write = 1'b1; 
        for (i = 0; i < 32; i = i + 1) 
        begin
            i_addr = i; 
            i_instruction = i;
            #(T*2); 
        end
        i_addr = {W{1'b0}}; 
        i_instruction = {INST_SZ{1'b0}};
        i_write = 1'b0; // Disable write
        i_enable = 1'b1;

        // Read Registers Test
        $display("\nRead Instructions Test\n");
        for (i = 0; i < 32; i = i +1)
        begin
            i_addr = i_addr + 4;
            #(T*2);
        end

        #100; 
        
        $stop;
    end

    always @(posedge i_clk)
    begin
        $display("Time: %t", $time);
        $display("Inputs:");
        $display("i_instruction   = %b - (%d)", i_instruction, i_instruction);
        $display("i_addr  = %b - (%d)", i_addr, i_addr);
        $display("Outputs:");
        $display("o_instruction = %b - (%d)", o_instruction, o_instruction);
    end

endmodule