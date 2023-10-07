`timescale 1ns/10ps

module uart_tb();

    // Parameters
    localparam T = 20;              // Clock Period [ns]
    localparam CLKS_PER_BIT = 2604; // 50MHz / 19200 baud rate = 2604 Clocks per bit 
    localparam BIT_PERIOD = 52083;  // CLKS_PER_BIT * T_NS = Bit period
    localparam NUM_TESTS = 4;       // Number of tests

    // Declarations
    reg i_clk, i_reset, i_rd_uart, i_rx;
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

    //! Task (automatic) UART_RECEIVE_BYTE: Simulates data being sent to the UART
    task automatic UART_RECEIVE_BYTE();
    integer i;
    begin
        for (i = 0; i < NUM_TESTS; i = i + 1) begin
            // Generate random data to be sent
            $display("DATA N° %d", i);
            data_to_send = $random;
            sent_data[i] = data_to_send; // Store sent data

            // Send Start bit
            i_rx = 1'b0;
            #(BIT_PERIOD);

            // Send Data
            for (bit_count = 0; bit_count < 8; bit_count = bit_count + 1) begin
                i_rx = data_to_send[0]; // Set i_rx to the next bit to transmit (LSB to MSB)
                #(BIT_PERIOD);

                $display("data_to_send: %b", data_to_send);
                $display("Transmitted bit %0d: %b", bit_count, i_rx);

                data_to_send = data_to_send >> 1; // Shift right to get the next bit
            end
            $display("ALL DATA SENT\n");

            // Send Stop bit
            i_rx = 1'b1;
            #(BIT_PERIOD);
        end
    end
    endtask
    
    
    //! Task (automatic) UART_RECEIVE_BYTE: Simulates data being sent to the UART
    task automatic UART_SEND_BYTE();
    integer i;
    begin
        for (i = 0; i < NUM_TESTS; i = i + 1) begin
            // Generate random data to be sent
            $display("DATA N° %d", i);
            data_to_send = $random;
            sent_data[i] = data_to_send; // Store sent data

            // Send Start bit
            i_rx = 1'b0;
            #(BIT_PERIOD);

            // Send Data
            for (bit_count = 0; bit_count < 8; bit_count = bit_count + 1) begin
                i_rx = data_to_send[0]; // Set i_rx to the next bit to transmit (LSB to MSB)
                #(BIT_PERIOD);

                $display("data_to_send: %b", data_to_send);
                $display("Transmitted bit %0d: %b", bit_count, i_rx);

                data_to_send = data_to_send >> 1; // Shift right to get the next bit
            end
            $display("ALL DATA SENT\n");

            // Send Stop bit
            i_rx = 1'b1;
            #(BIT_PERIOD);
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
        UART_RECEIVE_BYTE();

        // Test Case: Read received data and compare with sent data
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
            $display("\nAll received data matches sent data. Test Passed!");
        else
            $display("\nFailed Receiving Data. Check UART FIFO_W Size.");

        // Stop simulation
        $stop;
    end

endmodule

