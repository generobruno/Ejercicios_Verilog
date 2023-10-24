`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2023 22:36:32
// Design Name: 
// Module Name: UART_ALU_COMM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_ALU_COMM_conv#(
    N = 8,
    OPC_N = 6

)(
        input wire i_clock, 
        input wire i_reset,
        input wire [N-1:0] i_data,
        input wire i_available_data,
        input wire i_fifo_empty,
        input wire [N-1:0 ] i_result,
        output wire [32-1:0] o_inst,
        output wire [N-1:0] o_result,
        
        output wire [N-1:0] o_val1,
        output wire [N-1:0] o_val2,
        output wire [OPC_N-1:0] o_opc,
        
        output wire o_wr,
        output wire o_rd
        
    );
    
    reg [2:0]        counter;
    reg [2:0]        counter_next;
    reg [2:0]        cont;
    reg [2:0]        cont_next;
    //reg [2:0]        counter_next;
    reg [32-1:0]     inst_reg;
    reg [32-1:0]     inst_reg_next;
    reg [N-1: 0]     to_tx_fifo;
    reg [N-1: 0]     to_tx_fifo_next;
    reg              rd_reg;
    reg              rd_reg_next;
    reg              wr_reg;   
    reg              wr_reg_next;

    assign o_result = to_tx_fifo;
    assign o_inst = inst_reg;
    
    assign o_opc = inst_reg[0*N+:8];
    assign o_val1 = inst_reg[1*N+:8];
    assign o_val2 = inst_reg[2*N+:8];
    
    
    assign o_rd = rd_reg;
    assign o_wr = wr_reg; 
    
    
    always @(posedge i_clock, posedge i_reset)begin
        if(i_reset)begin
            inst_reg <= {32{1'b0}};
            to_tx_fifo <= {N{1'b0}};
            rd_reg <= 1'b0;
            wr_reg <= 1'b0;
            counter <= {3{1'b0}};

            cont <= {3{1'b0}};
        end
        else begin
            inst_reg <= inst_reg_next;
            counter <= counter_next;
            rd_reg <= rd_reg_next;
            wr_reg <= wr_reg_next;
            cont <= cont_next;
            to_tx_fifo <= to_tx_fifo_next;
        end
        
    end
    
    always@(*)begin
         
         inst_reg_next = inst_reg;
         counter_next = counter;
         cont_next = cont;
         rd_reg_next = rd_reg;
         wr_reg_next = wr_reg;
         to_tx_fifo_next = to_tx_fifo;
    
    
         if(!i_fifo_empty)begin
                
                wr_reg_next = 1'b0;
                if(counter<3)begin
                    rd_reg_next = 1'b1;
                    inst_reg_next[8*(counter)+:8] = i_data;
                    counter_next = counter +1;
                    cont_next = counter+1;
                 end
                 else if(counter == 4)begin
                    rd_reg_next = 1'b1;
                            
                    counter_next = cont;
                 end
            end
            else
            begin
                if(counter<3)begin
                    rd_reg_next = 1'b0;
                    counter_next = 3'b100;
                end
            end
            if(counter == 3)begin
                rd_reg_next = 1'b0;
                to_tx_fifo_next = i_result;
                wr_reg_next = 1'b1;
                counter_next = 3'b100;
                cont_next = 3'b000;
            end
    
    end
    
    
    
endmodule
