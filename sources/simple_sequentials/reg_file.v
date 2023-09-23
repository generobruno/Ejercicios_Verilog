/**
    A register file is a collection of registers with one input port and one or more output ports,
    usually used for fast temporary storage.
    The write address signal (w_addr) specifies where to store the data, and the read address signal
    (r_addr) specifies where to retrieve data.
    The following is the code for a parameterized 2^W x B register file.
**/

module reg_file
    #(
        parameter B = 8,        // Number of bits -> B bits in each word
                  W = 2         // Number of address bits -> 2^W words in file
    )
    (
        input wire clk,
        input wire wr_en,
        input wire [W-1 : 0] w_addr, r_addr,
        input wire [B-1 : 0] w_data,
        output wire [B-1 : 0] r_data
    );

    // Signal Declaration
    reg [B-1 : 0] array reg [2**W-1 : 0];   // 2-D Array -> array of 2^W elements of B size.

    // Write Operation
    always @(posedge clk) 
    begin
        if(wr_en)
            array_reg[w_addr] <= w_data;    // Signal w_addr used as index to access the reg file
    end

    // Read operation
    assign r_data = array_reg[r_addr];
    /*
        If we need to retrieve multiple data:
        r_data2 = array_reg[r_addr_2]
    */

endmodule