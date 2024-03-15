module UART_INTERFACE#(
    N   =   8,
    PC  =   32,     // Numbrer of addres bits for Inst mem    
    W   =   5,       // Number of address bits for reg mem
    PC_SZ = 32
)(
        input wire i_clock, 
        input wire i_reset,
        input wire [N-1:0] i_data,
        input wire i_fifo_empty,
        input wire i_fifo_full,
        input wire [32-1:0] i_reg_read, // Data from register memory
        input wire [32-1:0] i_mem_read, // Data from data memory
        input wire [PC_SZ-1:0] i_pc,
        output wire [32-1:0] o_inst,
        output wire [N-1:0] o_tx_data,
        output wire o_write_mem,
        output wire o_read_mem,
        output wire [PC-1 : 0] o_addr,
        output wire [W-1: 0] o_addr_ID,
        output wire [W-1: 0] o_addr_M,   
        
        
        output wire o_wr,
        output wire o_rd
        
    );
    
    reg [2:0]           counter;
    reg [2:0]           counter_next;
    reg [2:0]           cont;
    reg [2:0]           cont_next;
    reg [W-1:0]         reg_counter;
    reg [W-1:0]         reg_counter_next;
    reg [32-1:0]        inst_reg;
    reg [32-1:0]        inst_reg_next;
    reg [N-1: 0]        to_tx_fifo;
    reg [N-1: 0]        to_tx_fifo_next;
    reg                 rd_reg;
    reg                 rd_reg_next;
    reg                 wr_reg;
    reg                 wr_reg_next;
    reg                 write_mem_reg;
    reg                 write_mem_reg_next;
    reg                 read_mem_reg;
    reg                 read_mem_reg_next;
    reg [8-1: 0]        mode_reg;
    reg [8-1: 0]        mode_reg_next;
    reg [8-1: 0]        prog_size_reg;
    reg [8-1: 0]        prog_size_reg_next;
    reg [8-1: 0]        inst_n;                //Number of instructions received
    reg [8-1: 0]        inst_n_next;
    reg [PC-1: 0]       addr_reg;
    reg [PC-1: 0]       addr_reg_next;
    reg [W-1: 0]        addr_ID_reg;
    reg [W-1: 0]        addr_ID_reg_next;
    reg [W-1: 0]        addr_M_reg;
    reg [W-1: 0]        addr_M_reg_next;

    /* Codigos para modo de funcionamiento */
    localparam [7:0] START                = 8'b00000111;
    localparam [7:0] REC_PROG             = 8'b11111111;
    localparam [7:0] LOAD_PROG_SIZE       = 8'b11111110;
    localparam [7:0] LOAD_PROG            = 8'b11111101;
    localparam [7:0] DEBUG                = 8'b11111100;
    localparam [7:0] SEND_STATE_REG       = 8'b11111011;
    localparam [7:0] SEND_STATE_MEM       = 8'b11111010;
    localparam [7:0] SEND_PC              = 8'b11111001;
    localparam [7:0] END_DEBUG            = 8'b11111000;
    localparam [7:0] NEXT                 = 8'b00000001;
    localparam [7:0] WAIT                 = 8'b00000000;
    localparam [7:0] NO_DEBUG             = 8'b11110000;

    
    
    
    


    assign o_tx_data = to_tx_fifo;
    assign o_inst = inst_reg;
    assign o_write_mem = write_mem_reg;
    assign o_read_mem = read_mem_reg;
    assign o_addr = addr_reg;
    assign o_addr_ID = addr_ID_reg;
    assign o_addr_M = addr_M_reg;
    
    assign o_rd = rd_reg;
    assign o_wr = wr_reg; 
    
    
    always @(posedge i_clock, posedge i_reset)begin
        if(i_reset)begin
            inst_reg <= {32{1'b0}};
            to_tx_fifo <= {N{1'b0}};
            rd_reg <= 1'b0;
            wr_reg <= 1'b0;
            counter <= {3{1'b0}};
            reg_counter <= {W{1'b0}};
            mode_reg <= START;
            write_mem_reg <= 1'b0;
            read_mem_reg <= 1'b0;
            cont <= {3{1'b0}};
            prog_size_reg <= {8{1'b0}};
            inst_n <= {8{1'b0}};
            addr_reg <= {32{1'b0}};
            addr_ID_reg <= {W{1'b0}};
            addr_M_reg <= {W{1'b0}};
        end
        else begin
            inst_reg <= inst_reg_next;
            counter <= counter_next;
            cont <= cont_next;
            to_tx_fifo <= to_tx_fifo_next;
            mode_reg <= mode_reg_next;
            write_mem_reg <= write_mem_reg_next;
            read_mem_reg <= read_mem_reg_next;
            prog_size_reg <= prog_size_reg_next;
            inst_n <= inst_n_next;
            addr_reg <= addr_reg_next;
            addr_ID_reg <= addr_ID_reg_next;
            addr_M_reg <= addr_M_reg_next;
            reg_counter <= reg_counter_next;
            rd_reg <= rd_reg_next;
            wr_reg <= wr_reg_next;
        end
        
    end
    
    always@(*)begin
         
         inst_reg_next = inst_reg;
         counter_next = counter;
         cont_next = cont;
         rd_reg_next = rd_reg;
         wr_reg_next = wr_reg;
         to_tx_fifo_next = to_tx_fifo;
         mode_reg_next = mode_reg;
         write_mem_reg_next = write_mem_reg;
         read_mem_reg_next = read_mem_reg;
         prog_size_reg_next = prog_size_reg;
         inst_n_next = inst_n;
         addr_reg_next = addr_reg;
         addr_ID_reg_next = addr_ID_reg;
         addr_M_reg_next = addr_M_reg;
         reg_counter_next = reg_counter;
    
        /* RX */
         if(!i_fifo_empty)begin
                
                wr_reg_next = 1'b0;
                write_mem_reg_next = 1'b0;

                case(mode_reg)
                    default: begin
                        rd_reg_next = 1'b1;
                        mode_reg_next = i_data;
                    end
                    START: begin
                        rd_reg_next = 1'b1;
                        mode_reg_next = i_data;
                    end
                    REC_PROG: begin
                        rd_reg_next = 1'b1;
                        mode_reg_next = LOAD_PROG_SIZE;
                    end
                    LOAD_PROG_SIZE: begin
                        rd_reg_next = 1'b1;
                        prog_size_reg_next = i_data;
                        mode_reg_next = LOAD_PROG;
                    end
                    LOAD_PROG: begin
                        rd_reg_next = 1'b1;
                        // TODO: add halt instruction at end of program
                        if(inst_n == prog_size_reg)begin
                            mode_reg_next = START;
                            inst_n_next = 8'b00000000;
                            addr_reg_next = {32{1'b0}};
                        end
                        else if(counter < 4)begin
                            mode_reg_next = LOAD_PROG_SIZE;
                            inst_reg_next[8*(counter)+:8] = i_data;
                            counter_next = counter +1;
                        end
                        else if(counter == 4)begin
                            rd_reg_next = 1'b0;
                            write_mem_reg_next = 1'b1;
                            addr_reg_next = addr_reg +1;
                            counter_next = 3'b000;
                            inst_n_next = inst_n + 1;
                            mode_reg_next = WAIT;
                            cont_next = mode_reg;
                        end
                    end
                    DEBUG: begin
                        if(i_data == NEXT)begin
                            //TODO: como señalar a la pipeline que prosiga
                            mode_reg_next = SEND_STATE_REG;
                        end
                        else if(i_data == END_DEBUG)begin
                            mode_reg_next = START;
                        end
                    end
                    NO_DEBUG: begin
                        //TODO: Agregar un enable a la pipeline, ponerlo en uno en este estado y dejar que funcione.
                        //TODO: Esperar una señal del pipeline HALT y enviar estados de registros, mem y PC. 

                    end
                    WAIT: begin
                        rd_reg_next = 1'b1;
                                
                        mode_reg_next = cont;
                    end
                endcase
        end
        /* TX */
        if(!i_fifo_full)begin

            case(mode_reg)
                default: begin
                    rd_reg_next = 1'b0;
                end
                SEND_STATE_REG: begin
                    rd_reg_next = 1'b0;
                    if(reg_counter < 31)begin
                        if(counter < 4)begin
                            to_tx_fifo_next = i_reg_read[8*counter+:8];
                            counter_next = counter +1;
                        end
                        else if(counter == 4)begin
                            wr_reg_next = 1'b1;
                            counter_next = 0;
                            addr_ID_reg_next = reg_counter+1;
                            reg_counter_next = reg_counter+1;
                        end
                    end
                    else begin
                        reg_counter_next = 5'b00000;
                        mode_reg_next = SEND_STATE_MEM;
                    end
                end
                SEND_STATE_MEM: begin
                    rd_reg_next = 1'b0;
                    if(reg_counter < 31)begin
                        if(counter < 4)begin
                            to_tx_fifo_next = i_mem_read[8*counter+:8];
                            counter_next = counter +1;
                        end
                        else if(counter == 4)begin
                            wr_reg_next = 1'b1;
                            counter_next = 0;
                            addr_M_reg_next = reg_counter+1;
                            reg_counter_next = reg_counter+1;
                        end
                    end
                    else begin
                        reg_counter_next = 5'b00000;
                        mode_reg_next = SEND_PC;
                    end
                end
                SEND_PC: begin
                    if(counter < 4)begin
                            to_tx_fifo_next = i_pc[8*counter+:8];
                            counter_next = counter +1;
                        end
                    else if(counter == 4)begin
                            wr_reg_next = 1'b1;
                            counter_next = 0;
                            mode_reg_next = DEBUG;
                    end
                end
            endcase
        end
    end
    
    
    
endmodule
