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
        input wire                      i_reg_write_MC,             // RegWrite Control Line
        input wire [W-1 : 0]            i_read_reg_1,               // Read Register 1
        input wire [W-1 : 0]            i_read_reg_2,               // Read Register 2
        input wire [W-1 : 0]            i_write_register,           // Write Register
        input wire [B-1 : 0]            i_write_data,               // Write Data
        // Outputs
        output wire [B-1 : 0]           o_read_data_1,              // Read Data 1
        output wire [B-1 : 0]           o_read_data_2               // Read Data 2
    );

    //! Signal Declaration
    reg [B-1 : 0]   regs [2**W-1 : 0];

    // Initial Registers Values
    initial 
    begin
        regs[0] = 0; // TODO Declarar todos los regs?
    end

    // Body
    always @(posedge i_clk) // Write Cycle
    begin
        if(i_reg_write_MC)
        begin
            regs[i_write_register] <= i_write_data;
        end
    end
    always @(negedge i_clk) // Read Cycle
    begin
        o_read_data_1 <= regs[i_read_reg_1];
        o_read_data_2 <= regs[i_read_reg_2];
    end

endmodule