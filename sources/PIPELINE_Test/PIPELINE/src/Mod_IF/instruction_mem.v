/**

**/

module instruction_mem
    #(
        // Parameters
        parameter   B   =   32,     // Number of bits
        parameter   W   =   5       // Number of address bits

    )
    (
        // Inputs
        input wire                      i_clk,                      // Clock
        input wire                      i_reset,                    // Reset
        input wire                      i_write,                    // Write Control Line
        input [W-1 : 0]                 i_addr,                     // Address (Program Counter)
        input [B-1 : 0]                 i_data,                     // Instructions to write
        // Outputs
        output [B-1 : 0]                o_data                      // Instructions to Read
    );

    //! Signal Declaration
    // TODO Registros para debug
    reg [B-1 : 0]   array_reg [2**W-1 : 0];

    // Body
    always @(posedge i_clk) 
    begin
        if(i_write)
            begin
                // Write Operation
                array_reg[i_addr] <= i_data;
            end 
    end

    //! Assignments
    assign o_data = array_reg[i_addr >> 2];

endmodule