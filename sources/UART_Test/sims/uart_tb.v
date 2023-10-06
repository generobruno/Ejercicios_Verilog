`timescale 1ns/10ps

// The simulation time unit is 1 ns and the simulator time step is 10 ps

module uart_tb();

    // Parameters
    localparam T = 20;              // Clock Period [ns]
    localparam CLKS_PER_BIT = 2604; // 50Mhz / 19200 baud rate = 2604 Clocks per bit 
    localparam BIT_PERIOD = 52083;  // CLKS_PER_BIT * T_NS = Bit period

    // Declarations
    reg i_clk, i_reset, i_rd_uart, i_rx;
    wire o_tx_full, o_rx_empty;
    wire [7:0] o_r_data;
    reg [7:0] data_to_send; // Data to be sent
    integer bit_count;

    // Instantiate the UART module
    uart_top #(
        .DBIT(8),
        .SB_TICK(16),
        .DVSR(163),
        .FIFO_W(2)
    ) uart (
        .i_clk(i_clk),                  // Clock
        .i_reset(i_reset),              // Reset
        .i_rd_uart(i_rd_uart),          // RX: Read RX FIFO Signal
        .i_wr_uart(),                   //
        .i_rx(i_rx),                    // RX: RX input bit
        .i_w_data(),                    //
        .o_tx_full(o_tx_full),          //
        .o_rx_empty(o_rx_empty),        // RX: RX FIFO Empty Signal
        .o_tx(),                        //
        .o_r_data(o_r_data)             // RX: RX FIFO Data packed
    );

    // Clock Generation
    always
    begin
        i_clk = 1'b1;
        #(T/2);
        i_clk = 1'b0;
        #(T/2);
    end

    // Reset for the first half cycle
    initial 
    begin
        i_reset = 1'b1;
        #(T/2);
        i_reset = 1'b0;    
    end

    //! Task UART_RECEIVE_BYTE: Simulates data being sent to the UART
    task UART_RECEIVE_BYTE(input [7:0] data);
    integer i;
    begin
        // Send Start bit
        i_rx = 1'b0;
        #(BIT_PERIOD);

        // Send Data
        while (bit_count < 8) begin
            i_rx = data[0]; // Set i_rx to the next bit to transmit (LSB to MSB)
            #(BIT_PERIOD);

            $display("data_to_send: %b", data);
            $display("Transmitted bit %0d: %b", bit_count, i_rx);

            data = data >> 1; // Shift right to get the next bit
            bit_count = bit_count + 1;
        end
        $display("ALL DATA SENT\n");

        // Send Stop bit
        i_rx = 1'b1;
        #(BIT_PERIOD);
    end 
    endtask

    // Test cases
    initial
    begin
        // Initialize testbench signals
        i_rd_uart = 1'b0;
        i_rx = 1'b1;
        data_to_send = 8'b10101010; // Data to be sent
        bit_count = 0;

        @(negedge i_reset); // Wait for reset to deassert

        //! Test: Send all data 
        UART_RECEIVE_BYTE(data_to_send);

        // Test Case: Read received data 
        wait(o_rx_empty == 0);
        i_rd_uart = 1'b1; // Start reading
        $display("Received bits: %b", o_r_data);
        @(negedge i_clk);
        wait(o_rx_empty == 1);
        i_rd_uart = 1'b0;

        // Stop simulation
        $stop;
    end

endmodule
