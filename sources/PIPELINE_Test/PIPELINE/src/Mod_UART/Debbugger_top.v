

module debbugger_top
#(
    parameter   PC          =   32,
                REG_ADDR    =   5,
                INST_SZ     =   32


)
(
    input wire      i_clock,
    input wire      i_reset,
    input wire      i_rx,
    input wire      [2**5-1:0] i_register_data,
    input wire      [2**5-1:0] i_memory_data,
    input wire      [PC-1:0] i_pc,
    output wire     [INST_SZ-1:0] o_instruction,
    output wire     o_mem_w,
    output wire     o_mem_r,
    output wire     [PC-1:0] o_program_mem_addr,
    output wire     [REG_ADDR-1:0] o_addr_ID,
    output wire     [REG_ADDR-1:0] o_addr_M,
    
    output wire     [7:0] o_prog_sz,
    output wire     [7:0] o_state

);

wire [7:0] r_data_data;
wire rx_empty_fifo_empty;
wire tx_full_fifo_full;
wire [7:0] tx_data_w_data;
wire rd_rd_uart;
wire wr_wr_uart;

uart_top#(
    .DBIT(8),
    .SB_TICK(16),
    .DVSR(326),
    .FIFO_W(5)
)uart_unit(
    .i_clk(i_clock),
    .i_reset(i_reset),
    .i_rd_uart(rd_rd_uart),
    .i_wr_uart(wr_wr_uart),
    .i_rx(i_rx),
    .i_w_data(tx_data_w_data),
    .o_tx_full(tx_full_fifo_full),
    .o_rx_done(),
    .o_rx_empty(rx_empty_fifo_empty),
    .o_tx(),
    .o_r_data(r_data_data)
);

UART_INTERFACE#(
    .N(8),
    .PC(PC),
    .W(REG_ADDR),
    .PC_SZ(PC)
)debugger(
    .i_clock(i_clock),
    .i_reset(i_reset),
    .i_data(r_data_data),
    .i_fifo_empty(rx_empty_fifo_empty),
    .i_fifo_full(tx_full_fifo_full),
    .i_reg_read(i_register_data),
    .i_mem_read(i_memory_data),
    .i_pc(i_pc),
    .o_inst(o_instruction),
    .o_tx_data(tx_data_w_data),
    .o_write_mem(o_mem_w),
    .o_read_mem(o_mem_r),
    .o_addr(o_program_mem_addr),
    .o_addr_ID(o_addr_ID),
    .o_addr_M(o_addr_M),
    .o_wr(wr_wr_uart),
    .o_rd(rd_rd_uart),
    .o_prog_sz(o_prog_sz),
    .o_state(o_state)
);


endmodule