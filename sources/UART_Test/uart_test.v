module uart_test (
    // Inputs
    input wire i_clk,           // Clock
    input wire i_reset,         // Reset
    input wire i_rx,            // UART Receiver Input
    // Outputs
    output wire o_tx           // UART Data Transmitted
);


    //! States
    reg [2:0] state_reg, state_next;
    localparam  IDLE = 3'b000, 
                SAVE_OPCODE = 3'b001, 
                SAVE_OP1 = 3'b010, 
                SAVE_OP2 = 3'b011, 
                COMPUTE_RESULT = 3'b100;

    // Registers to save data
    reg [7:0] opcode_reg, opcode_next;
    reg [7:0] op1_reg, op1_next;
    reg [7:0] op2_reg, op2_next;
    reg [7:0] result_reg, result_next;
    reg i_rd_uart_reg, i_wr_uart_reg;

    wire i_rd_uart, i_wr_uart;
    wire [7:0] o_r_data;
    wire o_tx_full, o_rx_empty;

    uart_top #(.DBIT(8), .SB_TICK(16), .DVSR(163), .FIFO_W(2)) uart (
        .i_clk(i_clk),                  // Clock
        .i_reset(i_reset),              // Reset
        .i_rd_uart(i_rd_uart),          // RX: Read RX FIFO Signal
        .i_wr_uart(i_wr_uart),          // TX: Write RX FIFO Signal
        .i_rx(i_rx),                    // RX: RX input bit
        .i_w_data(i_w_data),            // TX: TX Packed Data to transmit
        .o_tx_full(o_tx_full),          // TX: TX FIFO Full Signal
        .o_rx_empty(o_rx_empty),        // RX: RX FIFO Empty Signal
        .o_tx(o_tx),                    // TX: TX Output bit
        .o_r_data(o_r_data)             // RX: RX FIFO Data packed
    );

    // FSM to control the data processing
    always @(posedge i_clk, posedge i_reset) begin
        if (i_reset) 
            begin
                state_reg <= IDLE;
                opcode_reg <= 8'b0;
                op1_reg <= 8'b0;
                op2_reg <= 8'b0;
                result_reg <= 8'b0;
            end 
        else 
            begin
                state_reg <= state_next;
                opcode_reg <= opcode_next;
                op1_reg <= op1_next;
                op2_reg <= op2_next;
                result_reg <= result_next;
            end
    end

    // Next-State Logic
    always @(*) begin

        state_next = state_reg;
        opcode_next = opcode_reg;
        op1_next = op1_reg;
        op2_next = op2_reg;
        result_next = result_reg;
        i_rd_uart_reg = 1'b0;
        i_wr_uart_reg = 1'b0;

        case (state_reg)
            IDLE:
            begin
                if (o_rx_empty == 0) // TODO or o_r_data == 0?
                    begin
                        state_next = SAVE_OPCODE;
                        opcode_next = o_r_data;
                        i_rd_uart_reg = 1'b1; 
                    end
                else 
                    begin
                        state_next = IDLE;
                        i_rd_uart_reg = 1'b0;
                        i_wr_uart_reg = 1'b0;
                    end
            end
            SAVE_OPCODE:
            begin
                state_next = SAVE_OP1;
                op1_next = o_r_data;
                i_rd_uart_reg = 1'b1;
            end
            SAVE_OP1:
            begin
                state_next = SAVE_OP2;
                op2_next = o_r_data;
                i_rd_uart_reg = 1'b1;
            end
            SAVE_OP2:
            begin
                state_next = COMPUTE_RESULT;
                i_rd_uart_reg = 1'b1;
            end
            COMPUTE_RESULT: //TODO Hace falta hacer i_rd_uart = 0??
            begin
                if(o_tx_full == 0)
                    begin
                        state_next = IDLE;
                        result_next = op1_reg + op2_reg;
                        i_wr_uart_reg = 1'b1;
                    end // TODO Else???
            end
            default: state_next = IDLE;
        endcase
    end
    
    // Assignments
    assign i_rd_uart = i_rd_uart_reg;
    assign i_wr_uart = i_wr_uart_reg;
    assign i_w_data = result_next; //TODO ???

endmodule
