/**
    A FIFO buffer is an "elastic" storage between 2 subsystems. It has 2 control signals, "wr" and "rd",
    for write and read operations. When wr is asserted, the input data is written into the buffer. The 
    read operation, when asserted, the first item of the FIFO (the head) is removed and the next item 
    becomes available.
    One way to implement a FIFO buffer is to add a control circuit to a register file. The registers in the
    register file are arranged as a circular queue with 2 pointers. The "write pointer" points to the head 
    of the queue, and the "read pointer" points to the tail of the queue. The pointer advances one position
    for each write or read operation.
    A FIFO buffer usually contains 2 status signals, "full" and "empty", to indicate that the FIFO is full
    (cannot be written) and empty (cannot be read), respectively. One of the 2 conditions occurs when the
    read pointer is equal to the write pointer.
    The most difficult design task of the controller is to derive a mechanism to distinguish the 2 conditions.
    One scheme is to use 2 FFs to keep track of the empty and full statuses. The FFs are set to 1 and 0 during
    system init and then modified in each clock cycle, according to the values of the "wr" and "rd" signals.
**/

module fifo
    #(
        parameter B = 8,            // Number of bits in a word
        parameter W = 4             // Number of address bits
    )
    (
        input wire clk, reset,
        input wire rd, wr,
        input wire [B-1 : 0] w_data,
        output wire empty, full,
        output wire [B-1 : 0] r_data
    );

    // Signal Declaration
    reg [B-1 : 0] array_reg [2**W-1 : 0];               // Register Array
    reg [W-1 : 0] w_ptr_reg, w_ptr_next, w_ptr_succ;
    reg [W-1 : 0] r_ptr_reg, r_ptr_next, r_ptr_succ;
    reg full_reg, empty_reg, full_next, empty_next;
    wire wr_en;

    // Register File Write Operation
    always @(posedge clock) 
    begin
        if(wr_en)
            array_reg[w_ptr_reg] <= w_data;    
    end

    // Register File read Operation
    assign r_data = array_reg[r_ptr_reg];
    // Write enable only when FIFO is not full
    assign wr_en = wr & ~full_reg;

    // FIFO CONTROL LOGIC
    // Register for read and write pointers
    always @(posedge clk, posedge reset) 
    begin
        if(reset)
            begin
                w_ptr_reg <= 0;
                r_ptr_reg <= 0;
                full_reg <= 1'b0;
                empty_reg <= 1'b1;
            end
        else
            begin
                w_ptr_reg <= w_ptr_next;
                r_ptr_reg <= r_ptr_next;
                full_reg <= full_next;
                empty_reg <= empty_next;
            end
    end

    // Next-State Logic for read and write ops
    always @(*) 
    begin
        // Successive pointer values
        w_ptr_succ = w_ptr_reg + 1;
        r_ptr_succ = r_ptr_reg + 1;
        // DEFAULT: Keep old values
        w_ptr_next = w_ptr_reg;
        r_ptr_next = r_ptr_reg;
        full_next = full_reg;
        empty_next = empty_reg;

        case ({wr, rd})
            // 2'b00: no op
            2'b01:  // READ
            begin
                if(~empty_reg) // NOT EMPTY
                begin
                    r_ptr_next = r_ptr_succ;
                    full_next = 1'b0;
                    if(r_ptr_succ == w_ptr_reg)
                        empty_next = 1'b1;
                end
            end
            2'b10:  // WRITE
            begin
                if(~full_reg) // NOT FULL
                begin
                    w_ptr_next = w_ptr_succ;
                    empty_next = 1'b0;
                    if(w_ptr_succ==r_ptr_reg)
                        full_next = 1'b1;
                end
            end
            2'b11:  // WRITE AND READ
            begin
                w_ptr_next = w_ptr_succ;
                r_ptr_next = r_ptr_succ;
            end
        endcase    

        // Output Logic
        assign full = full_reg;
        assign empty = empty_reg;

    end

endmodule