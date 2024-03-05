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
        input wire                      i_mem_write,                // Write Control Line
        input wire [1 : 0]              i_bhw,                      // Memory Size Control Line
        input [W-1 : 0]                 i_addr,                     // Address
        input [W-1 : 0]                 i_debug_addr,               // Debug Memory Address 
        input [B-1 : 0]                 i_data,                     // Data to Write
        // Outputs
        output [B-1 : 0]                o_debug_mem,                // Data to send to debugger
        output [B-1 : 0]                o_data                      // Data to Read
    );

    // BHW Load-Store //TODO Agregar bit para unsigned
    localparam BYTE     =       2'b00;         // Load-Store Byte
    localparam HALFWORD =       2'b01;         // Load-Store HalfWord
    localparam WORD     =       2'b11;         // Load-Store Word

    localparam BYTE_SZ      =       8;
    localparam HALFWORD_SZ  =       (B / 2);   

    //! Signal Declaration
    reg [B-1 : 0]   array_reg [2**W-1 : 0];
    integer i;

    // Initial Registers Values
    initial 
    begin
        // Initialize all regs to 0
        for (i = 0; i < 2**W; i = i + 1) begin
            array_reg[i] = {B{1'b0}};
        end
    end

    // Signed Byte Data
    wire [BYTE_SZ-1 : 0] byte_data = {i_data[B-1], i_data[BYTE_SZ-2 : 0]};
    // Signed HalfWord Data
    wire [HALFWORD_SZ-1 : 0] halfword_data = {i_data[B-1], i_data[HALFWORD_SZ-2 : 0]};

    // Body
    always @(posedge i_clk) 
    begin
        if(i_mem_write)
            begin // Write Operations
                case (i_bhw)
                    BYTE: // SB - LB
                    begin
                        case(i_addr[1:0]) // Select Byte
                            2'b00:
                            begin
                                array_reg[i_addr>>2][W-1 : 0] <= byte_data;
                            end
                            2'b01:
                            begin
                                array_reg[i_addr>>2][W*2-1 : W] <= byte_data;
                            end
                            2'b10:
                            begin
                                array_reg[i_addr>>2][W*3-1 : W*2] <= byte_data;
                            end
                            2'b11:
                            begin
                                array_reg[i_addr>>2][B-1 : W*3] <= byte_data;
                            end
                        endcase
                    end
                    HALFWORD: // SH - LH
                    begin
                        case(i_addr[1]) // Select HalwWord
                            1'b1:
                            begin
                                array_reg[i_addr>>2] <= halfword_data;
                            end
                            1'b0:
                            begin
                                array_reg[i_addr>>2] <= halfword_data;
                            end
                        endcase
                    end// SB - LB
                    WORD: // SW - LW
                    begin
                        array_reg[i_addr>>2] <= i_data;
                    end 
                    default: // Default Op (Word)
                    begin
                        array_reg[i_addr>>2] <= i_data;
                    end 
                endcase
            end

    end

    //! Assignments
    assign o_data = array_reg[i_addr>>2];
    assign o_debug_mem = array_reg[i_debug_addr];

endmodule