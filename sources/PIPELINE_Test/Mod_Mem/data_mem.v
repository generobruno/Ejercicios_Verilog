/**

**/

module data_memory
    #(
        // Parameters
        parameter   B   =   32,     // Number of bits
        parameter   W   =   2       // Number of address bits

    )
    (
        // Inputs
        input wire                      i_clk,                      //
        input wire                      i_mem_read,                 //
        input wire                      i_mem_write,                //
        input [W-1 : 0]                 i_addr,                     // 
        input [B-1 : 0]                 i_data,                     // 
        // Outputs
        output [B-1 : 0]                o_data,                     // 
    );

    //! Signal Declaration
    reg [B-1 : 0]   array_reg [2**W-1 : 0];
    reg [B-1 : 0]   read_reg;

    // TODO Manejar distintos tamaños de mem

    // Body
    always @(posedge i_clk) 
    begin
        if(i_mem_write)
            begin
                // Write Operation
                array_reg[i_addr] <= i_data;
            end
        else if(i_mem_read)
            begin
                // Read Operation
                read_reg <= array_reg[i_addr];
            end
        else
            begin
                // Default
                read_reg <= {B {1'b0}};
            end   
    end

    //! Assignments
    assign o_data = read_reg;

endmodule