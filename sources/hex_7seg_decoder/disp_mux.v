module disp_mux
    (
        input wire clk, reset,
        input [7:0] in3, in2, in1, in0,

        output reg [3:0] an,    // Enable, 1 of 4 asserted low
        output reg [7:0] sseg   // Led segments
    );

    // Constant Declaration
    localparam N = 18;  // Refreshing rate around 800 Hz (50 MHz/2^16)

    // Signal Declaration
    reg [N-1:0] q_reg;
    wire [N-1:0] q_next;

    // N-bit counter

    // Register
    always @(posedge clk, posedge reset) 
        if  (reset)
            q_reg <= 0;
        else
            q_reg <= q_next;

    
    // Next-State Logic
    assign q_next = q_reg + 1;

    // 2 MSBs of counter to control 4-to-1 mpx and generate active-low enable signals
    always @(*)
        case (q_reg[N-1:N-2])
            2'b00:
                begin
                    an = 4'b1110;
                    sseg = in0;
                end
            2'b01:
                begin
                    an = 4'b1101;
                    sseg = in1;
                end
            2'b10:
                begin
                    an = 4'b1011;
                    sseg = in2;
                end
            default: 
                begin
                    an = 4'b0111;
                    sseg = in3;
                end
        endcase

endmodule
