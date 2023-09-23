/**
    A Universal Shift Register can load parallel data, shift its content left or right, or remain in
    the same state. It can perform parallel-to-serial operation (first loading parallel input and then
    shifting) or serial-to-parallel operation (first shifting and then retrieving parallel output).
    The desired operation is specified by a 2-bit control signal (ctrl).
**/
module univ_shift_reg
    #(
        parameter N = 8
    )
    (
        input wire clk, reset,
        input wire [1:0] ctrl,
        input wire [N-1 : 0] d,
        output wire [N-1 : 0] q
    );

    // Signal declaration
    reg [N-1 : 0] r_reg, r_next;

    // Register
    always @(posedge clk, posedge reset) 
    begin
        if(reset)
            r_reg <= 0;
        else 
            r_reg <= r_next;
    end

    // Next-state logic
    always @(*) 
    begin
        case(ctrl)
            2'b00: r_next = r_reg;                      // No Op
            2'b01: r_next = {r_reg[N-2:0], d[0]};       // Shift Left
            2'b10: r_next = {d[N-1], r_reg[N-1:1]};     // Shift Right
            default: r_next = d;                        // Load
        endcase    
    end

    // Output logic
    assign q = r_reg;

endmodule