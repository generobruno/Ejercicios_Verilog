`timescale 1ns/10ps

module uart_tb();

    // Parameters
    localparam T = 20;              // Clock Period [ns]
    localparam CLKS_PER_BIT = 2604; // 50MHz / 19200 baud rate = 2604 Clocks per bit
    localparam BIT_PERIOD = 52083;  // CLKS_PER_BIT * T_NS = Bit period
    localparam NUM_TESTS = 3;       // Number of tests

    // Operation parameters
    localparam ADD = 8'b00100000;
    localparam SUB = 8'b00100010;
    localparam AND = 8'b00100100;
    localparam OR  = 8'b00100101;
    localparam XOR = 8'b00100110;
    localparam SRA = 8'b00000011;
    localparam SRL = 8'b00000010;
    localparam NOR = 8'b00100111;

    // Declarations
    reg i_clk, i_reset, i_rx;
    wire o_tx;
    reg [7:0] data_to_send; // Data to be sent

    // Instantiate the UART module
    uart_alu_top top (
        .i_clk(i_clk),              // Clock
        .i_reset(i_reset),          // Reset
        .i_rx(i_rx),                // UART Receiver Input
        .o_tx(o_tx)                 // UART Data Transmitted
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
    integer bit_count;
    begin
        for (i = 0; i < NUM_TESTS; i = i + 1) begin
            if (i == 0)
                data_to_send = 8'b00100000; // ADD
            else
                data_to_send = 8'b00000010;

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
        @(negedge i_reset); // Wait for reset to deassert

        $display("\nTESTING UART...\n");

        //! Test: Send all data
        UART_RECEIVE_BYTE();

        // Stop simulation
        $stop;  
    end

endmodule

