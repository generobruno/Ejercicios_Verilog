/**

**/

module instruction_mem
    #(
        // Parameters
        parameter   B   =   32,     // Number of bits
        parameter   W   =   5,      // Number of address bits
        parameter   PC  =   32

    )
    (
        // Inputs
        input wire                      i_clk,                      // Clock
        //input wire                      i_reset,                    // Reset
        input wire                      i_write,                    // Write Control Line
        input [PC-1 : 0]                i_addr,                     // Address (Program Counter)
        input [B-1 : 0]                 i_data,                     // Instructions to write
        // Outputs
        output [B-1 : 0]                o_data                      // Instructions to Read
    );

    //! Signal Declaration
    // TODO Registros para debug
    // Instruction memory
    reg [B-1 : 0]       array_reg [2**W-1 : 0];
    // Mask to select instruction. Default: 32 Instructions: (25-5-2) 0000000000000000000000000_11111_00
    reg [PC-1 : 0]   mask = {{(PC - W - 2){1'b0}} , {W{1'b1}} , 2'b00};

    // Body //TODO REVISAR -> el clk se deberia usar para debuggear y cargar insts, pero las insts las selecciona el pc en otro caso
    always @(posedge i_clk) 
    begin
        if(i_write)
            begin
                // Write Operation
                array_reg[i_addr] <= i_data;
            end 
    end

    //! Assignments //TODO Ver como enmascarar i_addr para seleccionar la instr
    assign o_data = array_reg[(i_addr & mask) >> 2];

endmodule