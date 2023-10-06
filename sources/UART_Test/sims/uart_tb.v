module uart_tb();

    // Declarations
    localparam T = 20; // Clock Period
    reg i_clk, i_reset, i_rd_uart, i_wr_uart, i_rx;
    wire o_tx_full, o_rx_empty, o_tx;
    wire [7:0] o_r_data;
    reg [7:0] data_to_send; // Data to be sent
    integer i;

    // Instantiate the UART module
    uart_top #(
        .DBIT(8),
        .SB_TICK(16),
        .DVSR(163),
        .FIFO_W(2)
    ) uut (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_rd_uart(i_rd_uart),
        .i_wr_uart(i_wr_uart),
        .i_rx(i_rx), // Connect i_rx to UART receiver input
        .i_w_data(), 
        .o_tx_full(o_tx_full),
        .o_rx_empty(o_rx_empty),
        .o_tx(o_tx),
        .o_r_data(o_r_data)
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

    // Test cases
    initial
    begin
        // Initialize testbench signals
        i_rd_uart = 1'b0;
        i_wr_uart = 1'b0;
        i_rx = 1'b0;
        data_to_send = 8'b01010101; // Data to be sent

        @(negedge i_reset); // Wait for reset to deassert

        // Test Case: Send all data first
        for (i = 0; i < 8; i = i + 1) begin
            i_wr_uart = 1'b1;
            i_rx = data_to_send[0]; // Set i_rx to the next bit to transmit
            @(negedge i_clk);
            $display("Transmitted bit %0d: %b", 7 - i, i_rx);
            $display("data_to_send: %b", data_to_send);
            i_wr_uart = 1'b0;
            #100; // Wait before transmitting the next bit
            data_to_send = data_to_send >> 1; // Shift right to get the next bit
        end

        // Wait for a while to ensure data reception
        #500;

        // Test Case: Read received data
        i_rd_uart = 1'b1; // Start reading
        for (i = 0; i < 8; i = i + 1) begin
            @(negedge i_clk);
            $display("Received bit %0d: %b", 7 - i, o_r_data);
            #100; // Wait before reading the next bit
        end
        i_rd_uart = 1'b0;

        // Stop simulation
        $stop;
    end

endmodule
