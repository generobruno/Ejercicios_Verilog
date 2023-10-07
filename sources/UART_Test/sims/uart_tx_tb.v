`timescale 1ns/10ps

module uart_tx_tb();

    // Parameters
    localparam T = 20;              // Clock Period [ns]
    localparam CLKS_PER_BIT = 2604; // 50MHz / 19200 baud rate = 2604 Clocks per bit 
    localparam BIT_PERIOD = 52083;  // CLKS_PER_BIT * T_NS = Bit period
    localparam TX_PERIOD = 520830;  // BIT_PERIOD * 10 = TX period
    localparam NUM_TESTS = 4;       // Number of tests

    // Declarations
    reg i_clk, i_reset, i_rd_uart, i_rx, i_wr_uart, i_w_data;
    wire o_tx_full, o_rx_empty;
    wire [7:0] o_r_data;
    reg [7:0] data_to_send; // Data to be sent
    reg [7:0] sent_data [NUM_TESTS-1:0]; // Data sent during each test
    integer bit_count;
    integer received_data_mismatch;
    integer test_num;

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
        .i_wr_uart(i_wr_uart),                   //
        .i_rx(tx_to_rx),                    // RX: RX input bit
        .i_w_data(i_w_data),                    //
        .o_tx_full(o_tx_full),          //
        .o_rx_empty(o_rx_empty),        // RX: RX FIFO Empty Signal
        .o_tx(tx_to_rx),                        //
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

    //! Task (automatic) UART_SEND_BYTE: Simulates TX FIFO being written
    task automatic UART_SEND_BYTE();
    integer i;
    begin
        for (i = 0; i < NUM_TESTS; i = i + 1) begin
            // Generate random data to be sent
            data_to_send = $random;
            $display("Written bits: %b", data_to_send);
            sent_data[i] = data_to_send;
            i_w_data = data_to_send;

            i_wr_uart = 1'b1;   // Write FIFO
            @(negedge i_clk);   // Assert i_wr_signal for 1 clk cycle to remove word
            i_wr_uart = 1'b0;
            @(negedge i_clk);
            #(TX_PERIOD);
        end
    end
    endtask
    
    

    // Test cases
    initial
    begin
        // Initialize testbench signals
        i_rd_uart = 1'b0;
        i_rx = 1'b1;
        received_data_mismatch = 0;

        @(negedge i_reset); // Wait for reset to deassert

        //! Test: Send all data
        UART_SEND_BYTE();

        // Test Case: Write random data into TX FIFO
        while ((o_rx_empty != 1) && (received_data_mismatch != 1)) begin
            for (test_num = 0; test_num < NUM_TESTS; test_num = test_num + 1) begin
                @(negedge i_clk);
                $display("Received bits: %b", o_r_data);

                // Compare received data with stored sent data
                if (o_r_data !== sent_data[test_num]) begin
                    $display("Data Mismatch! Received data does not match sent data.");
                    received_data_mismatch = 1;
                end

                i_rd_uart = 1'b1;   // Read FIFO
                @(negedge i_clk);   // Assert i_rd_signal for 1 clk cycle to remove word
                i_rd_uart = 1'b0;
                @(negedge i_clk);
            end
        end        

        if (received_data_mismatch == 0)
            $display("\nAll received data matches sent data. TX Test Passed!");
        else
            $display("\nFailed Receiving Data. Check UART FIFO_W Size.");

        // Stop simulation
        $stop;
    end

endmodule

