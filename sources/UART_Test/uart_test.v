module uart_alu_interface
    #(
        // Parameters
        parameter       DATA_WIDTH      = 8,                // Data width (number of bits)
                        SAVE_COUNT      = 3,                // Number of data words to save
                        OP_SZ           = DATA_WIDTH,       // Operand size
                        OPCODE_SZ       = 6                 // Opcode size
    )
    (
        // Inputs
        input wire i_clk,                           // Clock
        input wire i_reset,                         // Reset
        input wire i_rx_empty,                      // Receiver FIFO Empty Signal
        input wire i_tx_full,                       // Transmitter FIFO Full Signal
        input wire [DATA_WIDTH-1:0] i_r_data,       // UART Receiver Input
        input wire [DATA_WIDTH-1:0] i_result_data,  // ALU Result Register
        
        // Outputs
        output wire [DATA_WIDTH-1:0] o_w_data,      // UART Data Transmitted
        output wire o_wr_uart,                      // Receiver FIFO Input Read Signal
        output wire o_rd_uart,                      // Transmitter FIFO Input Write Signal
        output wire [OP_SZ-1:0] o_op_a,             // ALU Operand A
        output wire [OP_SZ-1:0] o_op_b,             // ALU Operand B
        output wire [OPCODE_SZ-1:0] o_op_code       // ALU Opcode
    );

    //! State Declaration
    localparam [2:0]
        IDLE        =   3'b000,
        SAVE_OP1    =   3'b001,
        SAVE_OP2    =   3'b010,
        COMPUTE_ALU =   3'b011,
        SEND_RESULT =   3'b100;

    //! Signal Declaration
    //reg [DATA_WIDTH-1 : 0] r_data, w_data;
    reg [2:0] state_reg, state_next;
    reg rd_uart_reg, wr_uart_reg;

    // Registers to store received data //TODO Cambiar a array de regs?
    reg [OPCODE_SZ-1 : 0] opcode;
    reg [DATA_WIDTH-1 : 0] op1; 
    reg [DATA_WIDTH-1 : 0] op2;
    reg [DATA_WIDTH-1 : 0] result;

    //! FSMD States and data registers
    always @(posedge i_clk, posedge i_reset) begin
        if (i_reset) 
        begin
            // State
            state_reg <= IDLE;
            // Control
            rd_uart_reg = 1'b0;
            wr_uart_reg = 1'b0;
            // Data
            opcode = {OPCODE_SZ {1'b0}};
            op1 = {DATA_WIDTH{1'b0}};
            op2 = {DATA_WIDTH{1'b0}};
            result = {DATA_WIDTH{1'b0}};
        end 
        else 
        begin
            state_reg <= state_next;
        end
    end

    //! Next-State Logic
    always @(*) begin
        // Initial assignments
        state_next = state_reg;
        wr_uart_reg = 1'b0;
        rd_uart_reg = 1'b0;
        op1 = {DATA_WIDTH{1'b0}};
        op2 = {DATA_WIDTH{1'b0}};
        opcode = {OPCODE_SZ {1'b0}};
        result = {DATA_WIDTH{1'b0}};

        case (state_reg)
            IDLE: 
            begin
                wr_uart_reg = 1'b0;
                if (~i_rx_empty) 
                begin
                    state_next = SAVE_OP1;
                    opcode = i_r_data[OPCODE_SZ-1 : 0];
                    rd_uart_reg = 1'b1;
                end
            end
            SAVE_OP1: 
            begin
                state_next = SAVE_OP2;
                op1 = i_r_data;
                rd_uart_reg = 1'b1;
            end
            SAVE_OP2: 
            begin
                state_next = COMPUTE_ALU;
                op2 = i_r_data;
                rd_uart_reg = 1'b1;
            end
            COMPUTE_ALU: 
            begin
                rd_uart_reg = 1'b0;
                state_next = SEND_RESULT;
            end
            SEND_RESULT: 
            begin
                result = i_result_data; 
                if (~i_tx_full) 
                    begin
                        state_next = IDLE;
                        wr_uart_reg = 1'b1;
                    end 
                // Else, if the transmitter FIFO is full, stay in the current state
            end
            default: state_next = IDLE;
        endcase
       
    end

    //! Assignments
    assign o_rd_uart = rd_uart_reg;     // Read UART Signal
    assign o_w_data = result;           // Write UART (TX)
    assign o_wr_uart = wr_uart_reg;     // Write UART Signal
    assign o_op_code = opcode;          // ALU Operation Code
    assign o_op_a = op1;                // ALU Operand A
    assign o_op_b = op2;                // ALU Operand B

endmodule
