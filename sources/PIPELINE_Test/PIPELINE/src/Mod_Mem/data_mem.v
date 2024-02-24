/**

**/

module data_mem
    #(
        // Parameters
        parameter   B   =   32,     // Number of bits
        parameter   W   =   5       // Number of address bits

    )
    (
        // Inputs
        input wire                      i_clk,                      // Clock
        input wire                      i_mem_read,                 // Read Control Line
        input wire                      i_mem_write,                // Write Control Line
        input [W-1 : 0]                 i_addr,                     // Address
        input [B-1 : 0]                 i_data,                     // Data to Write
        // Outputs
        output [B-1 : 0]                o_data                      // Data to Read
    );

    //! Signal Declaration
    reg [B-1 : 0]   array_reg [2**W-1 : 0];
    reg [B-1 : 0]   read_reg;

    // TODO Manejar distintos tamaños de mem y leer valor de memoria para debug

    // Body
    always @(posedge i_clk) 
    begin
        if(i_mem_write)
            begin
                // Write Operation (Aligned)
                array_reg[i_addr>>2] <= i_data;
            end
        else if(i_mem_read)
            begin
                // Read Operation (Aligned)
                read_reg <= array_reg[i_addr>>2];
            end
        else
            begin
                // Default
                read_reg <= array_reg[i_addr>>2];
            end   
    end

    //! Assignments
    assign o_data = read_reg;

endmodule