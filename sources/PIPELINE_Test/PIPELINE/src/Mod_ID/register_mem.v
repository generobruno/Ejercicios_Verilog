/**

**/

module register_mem
    #(
        // Parameters
        parameter   B   =   32,     // Number of bits
        parameter   W   =   5       // Number of address bits

    )
    (
        // Inputs
        input wire                      i_clk,                      // Clock
        input wire                      i_reset,                    // Reset
        input wire                      i_reg_write_MC,             // RegWrite Control Line
        input wire [W-1 : 0]            i_read_reg_1,               // Read Register 1
        input wire [W-1 : 0]            i_read_reg_2,               // Read Register 2
        input wire [W-1 : 0]            i_write_register,           // Write Register
        input wire [B-1 : 0]            i_write_data,               // Write Data
        input wire [W-1 : 0]            i_debug_addr,               // Debug Register Address
        // Outputs
        output wire [B-1 : 0]           o_read_data_1,              // Read Data 1
        output wire [B-1 : 0]           o_read_data_2,              // Read Data 2
        output wire [B-1 : 0]           o_reg
    );

    //! Signal Declaration
    reg [B-1 : 0]   regs [2**W-1 : 0];
    reg [B-1 : 0]   aux_1;
    reg [B-1 : 0]   aux_2;
    integer i;

    // Initial Registers Values
    initial 
    begin
        // Initialize all regs to 0
        for (i = 0; i < 2**W; i = i + 1) begin
            regs[i] = 32'h00000000;
        end

        // Initialize aux_1 and aux_2 to 0
        aux_1 = 32'h00000000;
        aux_2 = 32'h00000000;
    end

    // Body
    always @(posedge i_clk) // Write Cycle
    begin
        if(i_reset)
        begin
            regs[0] = 32'h00000000; //TODO regs[0] siempre es 0 -> no permitir que se cambie
        end
        else if(i_reg_write_MC)
        begin
            regs[i_write_register] <= i_write_data;
        end
    end
    always @(negedge i_clk) // Read Cycle
    begin
        aux_1 <= regs[i_read_reg_1];
        aux_2 <= regs[i_read_reg_2];
    end
    
    //! Assignments
    assign o_read_data_1 = aux_1;
    assign o_read_data_2 = aux_2;
    assign o_reg = regs[i_debug_addr];

endmodule