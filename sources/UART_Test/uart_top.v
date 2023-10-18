/**
    UART Top Module
    Default Settings:
        19200 Baud Rate, 8 Data bits, 1 Stop Bit, 2² FIFO.
**/

module uart_top
    #(
        // Parameters
        parameter   DBIT        =       8,      // # Data bits
                    SB_TICK     =       16,     // # Ticks for stop bits (16/24/32 for 1/1.5/2 bits)
                    DVSR        =       163,    // Baud Rate divisor ( Clock/(BaudRate*16) )
                    FIFO_W      =       2       // # Address bits of FIFO ( # Words in FIFO = 2^FIFO_W )
    )
    (
        // Inputs
        input wire              i_clk,              // Clock
        input wire              i_reset,            // Reset
        input wire              i_rd_uart,          // Receiever FIFO Input Read Signal
        input wire              i_wr_uart,          // Transmiter FIFO Input Write Signal
        input wire              i_rx,               // UART Receiver Input
        input wire [7 : 0]      i_w_data,           //! Receiver FIFO Input from UART -> DATA TO BE TRANSMITED
        // Outputs
        output wire             o_tx_full,          // Transmiter FIFO Full Signal
        output wire             o_rx_done,
        output wire             o_rx_empty,         // Receiver FIFO Empty Signal
        output wire             o_tx,               // Data transmitted
        output wire [7 : 0]     o_r_data            //! Received data from Receiver FIFO -> DATA TO BE RECEIVED
    );

    //! Signal Declaration
    wire                tick;                       // Ticks for the UART rx and tx
    wire                rx_done_tick;               // Receiver Done Signal
    wire                tx_done_tick;               // Transmiter Done Signal
    wire                tx_empty;                   // Transmiter FIFO Empty Signal
    wire                tx_fifo_not_empty;          // Transmiter FIFO Not-Empty Signal
    wire [7 : 0]        tx_fifo_out;                // Data to send, from tx FIFO to tx
    wire [7 : 0]        rx_data_out;                // Data to receive, from rx to rx FIFO

    //! Instantiations
    mod_m_counter #(.M(DVSR)) baud_rate_gen
        (.i_clk(i_clk) , .i_reset(i_reset),
            .o_ticks() , .o_max_tick(tick));

    uart_rx #(.DBIT(DBIT) , .SB_TICK(SB_TICK)) uart_rx_unit
        (.i_clk(i_clk), .i_reset(i_reset),
            .i_rx(i_rx), . i_s_tick(tick),
            .o_rx_done_tick(o_rx_done), .o_data(rx_data_out));

    fifo #(.B(DBIT), .W(FIFO_W)) fifo_rx_unit
        (.i_clk(i_clk), .i_reset(i_reset),
            .i_rd(i_rd_uart), .i_wr(o_rx_done), .i_w_data(rx_data_out),
            .o_empty(o_rx_empty), .o_full(), .o_r_data(o_r_data));

    fifo #(.B(DBIT), .W(FIFO_W)) fifo_tx_unit
        (.i_clk(i_clk), .i_reset(i_reset),
            .i_rd(tx_done_tick), .i_wr(i_wr_uart), .i_w_data(i_w_data),
            .o_empty(tx_empty), .o_full(o_tx_full), .o_r_data(tx_fifo_out));

    uart_tx #(.DBIT(DBIT) , .SB_TICK(SB_TICK)) uart_tx_unit
        (.i_clk(i_clk), .i_reset(i_reset),
            .i_tx_start(tx_fifo_not_empty), .i_s_tick(tick), .i_data(tx_fifo_out),
            .o_tx_done_tick(tx_done_tick), .o_tx(o_tx));

    assign tx_fifo_not_empty = ~tx_empty;

endmodule