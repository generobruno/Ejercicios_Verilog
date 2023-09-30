/**
    The period counter takes a measurement when the start signal is
    asserted. We use a rising-edge detection circuit to generate a one-clock-cycle tick, edge, to
    indicate the rising edge of the input waveform. After start is asserted, the FSMD moves to
    the waite state to wait for the first rising edge of the input. It then moves to the count state
    when the next rising edge of the input is detected. In the count state, we use two registers
    to keep track of the time. The t register counts for 50,000 clock cycles, from 0 to 49,999,
    and then wraps around. Since the period of the system clock is 20 ns, the t register takes
    1 ms to circulate through 50,000 cycles. The p register counts in terms of milliseconds. It
    is incremented once when the t register reaches 49,999. When the FSMD exits the count
    state, the period of the input waveform is stored in the p register and its unit is milliseconds.
    The FSMD asserts the done-tick signal in the done state
**/

module period_counter
    (
        input wire clk, reset,
        input wire start, si,
        output reg ready, done_tick,
        output wire [9:0] prd
    );

    // State Declaration
    localparam [1:0]
        idle    =   2'b00,
        waite   =   2'b01,
        count   =   2'b10,
        done    =   2'b11;

    // Constante declaration
    localparam CLK_MS_COUNT = 50000;    // 1 ms tick

    // Signal declaration
    reg [1:0]   state_reg, state_next;  
    reg [15:0]  t_reg, t_next;          // Up to 50000
    reg [9:0]   p_reg, p_next;          // Up to 1 sec
    reg delay_reg;  
    wire edg;

    // FSMD State and data registers
    always @(posedge clk, posedge reset) 
    begin

        if(reset)
            begin
                state_reg <= idle;
                t_reg <= 0;
                p_reg <= 0;
                delay_reg <= 0;
            end
        else
            begin
                state_reg <= state_next;
                t_reg <= t_next;
                p_reg <= p_next;
                delay_reg <= si;
            end
    end

    // Rising edge tick
    assign edg = ~delay_reg & si;

    // FSMD next-state logic
    always @(*) 
    begin
        state_next = state_reg;
        ready = 1'b0;
        done_tick = 1'b0;
        p_next = p_reg;
        t_next = t_reg;

        case (state_reg)
            idle:
                begin
                    ready = 1'b1;
                    if(start)
                        state_next = waite;
                end
            waite:  // Wait for the first edge
                begin
                    state_next = count;
                    t_next = 0;
                    p_next = 0;
                end
            count:
                begin
                    if (edg)    // 2nd edge arrived
                        state_next = done;
                    else        // otherwise, count
                        if (t_reg == CLK_MS_COUNT - 1) // 1 ms tick
                            begin
                                t_next = 0;
                                p_next = p_reg + 1;
                            end
                        else
                            t_next = t_reg + 1;
                end
            done:
                begin
                    done_tick = 1'b1;
                    state_next = idle;
                end
            default: state_next = idle;
        endcase    
    end

    // Output
    assign prd = p_reg;

endmodule