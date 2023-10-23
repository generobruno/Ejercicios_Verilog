module uart_alu_top
    #(
        // Parameters
        parameter       DATA_BITS   =       8,
                        OPCODE_BITS =       6
    )
    (
        // Inputs
        input wire i_clk,                    // Clock
        input wire i_reset,                  // Reset
        input wire i_rx,   
        // Outputs
        output wire o_tx,
        output reg [DATA_BITS-1:0] result,
        output wire [32-1:0] o_inst,   
        output wire [DATA_BITS-1:0] COMM_result,
       
        output wire [DATA_BITS-1:0] val1_result,
        output wire [DATA_BITS-1:0] val2_result,
        output wire [OPCODE_BITS-1:0] opc_result
        
          
                
    );

    //! Signal Declaration
    wire rx_empty;                                  // Receiver FIFO Empty Signal
    wire tx_full;                                   // Transmitter FIFO Full Signal
    wire [DATA_BITS-1 :0]       r_data;             // UART Receiver Input
    wire [DATA_BITS-1 :0]       result_data;        // ALU Result Register
    wire [DATA_BITS-1 :0]       w_data;             // UART Data Transmitted
    wire wr_uart;                                   // Receiver FIFO Input Read Signal
    wire rd_uart;                                   // Transmitter FIFO Input Write Signal
    wire [DATA_BITS-1 :0]       op_a;               // ALU Operand A
    wire [DATA_BITS-1 :0]       op_b;               // ALU Operand B
    wire [OPCODE_BITS-1 :0]     op_code;            // ALU Operation Code

    assign val1_result = op_a;
    assign val2_result = op_b;
    assign opc_result = op_code;
    
    //! Instantiations
    // UART Module
    uart_top #(
        // Parameters
        .DBIT(DATA_BITS),
        .SB_TICK(16),
        .DVSR(326),
        .FIFO_W(2)
    ) uart_unit (
        // Inputs
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_rd_uart(rd_uart),
        .i_wr_uart(wr_uart),
        .i_rx(i_rx),
        .i_w_data(COMM_result),
        // Outputs
        .o_rx_done(o_rx_done),
        .o_tx_full(tx_full),
        .o_rx_empty(rx_empty),
        .o_tx(o_tx),
        .o_r_data(r_data)
    );
    
    // ALU Module
    alu #(
        // Parameters
        .N(DATA_BITS),  
        .NSel(OPCODE_BITS)  
    ) alu_unit (
        // Inputs
        .i_alu_A(op_a),
        .i_alu_B(op_b),
        .i_alu_Op(op_code),
        // Outputs
        .o_alu_Result(result_data)
    );
    
    
    //UART_ALU_COMM 
    UART_ALU_COMM #(
        .N(DATA_BITS),
        .OPC_N(OPCODE_BITS)
    )uart_alu_interface_unit_comm(
        .i_clock(i_clk),
        .i_reset(i_reset),
        .i_data(r_data),
        .i_available_data(o_rx_done),
        .i_fifo_empty(rx_empty),
        .i_result(result_data),
        .o_result(COMM_result),
        .o_inst(o_inst),
       
        .o_val1(op_a),
        .o_val2(op_b),
        .o_opc(op_code),
        
        .o_wr(wr_uart),
        .o_rd(rd_uart)
    );
   
    
    /*
    // UART-ALU Interface Module
    uart_alu_interface #(
        // Parameters
        .DATA_WIDTH(DATA_BITS),
        .SAVE_COUNT(3),
        .OP_SZ(DATA_BITS),
        .OPCODE_SZ(OPCODE_BITS)
    ) uart_alu_interface_unit (
        // Inputs
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_rx_empty(rx_empty),
        .i_tx_full(tx_full),
        .i_r_data(r_data),
        .i_result_data(result_data),
        // Outputs
        .o_w_data(COMM_result),
        .o_wr_uart(wr_uart),
        .o_rd_uart(rd_uart),
        .o_op_a(op_a),
        .o_op_b(op_b),
        .o_op_code(op_code)
    );
    */

    always @(posedge i_clk, posedge i_reset) 
    begin
        if (i_reset)        // Reset system 
            begin
                result <= {DATA_BITS{1'b0}};
                /*
                COMM_result<= {DATA_BITS{1'b0}};
                val1_result<= {DATA_BITS{1'b0}};
                val2_result<= {DATA_BITS{1'b0}};
                */
            end
        else                // Next state assignments
            begin
                /*
                COMM_result<= result_data;
                val1_result<=op_a;
                val2_result<=op_b;
                */
            end
    end

endmodule
