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

    // TODO Manejar distintos tamaños de mem

    // Body //TODO REVISAR
    always @(posedge i_clk) 
    begin
        if(i_mem_write)
            begin
                // Write Operation
                case(i_addr[1:0])
                    2'b00:
                    begin
                        array_reg[i_addr] <= i_data;
                    end
                    2'b01:
                    begin

                    end
                    2'b10:
                    begin

                    end
                    2'b11:
                    begin

                    end
                endcase
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