/**

**/

module EX_MEM_reg
    #(
        // Parameters
        parameter INST_SZ = 32
    )
    (
        // Inputs
        input wire                      i_clk,                      // Clock
        input wire                      i_reset,                    // Reset
        input wire                      i_enable,                   // Write Control Line
        input wire                      i_jump,                     // Jump Control Line
        input wire                      i_jump_sel,                 // JumpSel Control Line
        input wire                      i_mem_read,                 // MemRead Control Line
        input wire                      i_mem_write,                // MemWrite Control Line
        input wire                      i_reg_write,                // RegWrite Control Line
        input wire                      i_mem_to_reg,               // MemToReg Control Line
        input wire                      i_bds_sel,                  // BDSSel Control Line
        input wire                      i_alu_result,               // ALU Result
        input wire                      i_write_data,               // Write Data
        input wire                      i_write_register,           // Write Register
        input wire                      i_bds,                      // BDS
        // Outputs
        output wire                     o_jump,                     // Jump Control Line
        output wire                     o_jump_sel,                 // JumpSel Control Line
        output wire                     o_mem_read,                 // MemRead Control Line
        output wire                     o_mem_write,                // MemWrite Control Line
        output wire                     o_reg_write,                // RegWrite Control Line
        output wire                     o_mem_to_reg,               // MemToReg Control Line
        output wire                     o_bds_sel,                  // BDSSel Control Line
        output wire                     o_alu_result,               // ALU Result
        output wire                     o_write_data,               // Write Data
        output wire                     o_write_register,           // Write Register
        output wire                     o_bds,                      // BDS
    );

    //! Signal Definition
    reg jump;                     
    reg jump_sel;                 
    reg mem_read;                 
    reg mem_write;                
    reg reg_write;                
    reg mem_to_reg;               
    reg bds_sel;                  
    reg alu_result;               
    reg write_data;               
    reg write_register;
    reg bds;

    // Body
    always @(posedge i_clk) 
    begin
        if(i_reset)
        begin
            jump            <=      0;                                          
            jump_sel        <=      0;                                  
            mem_read        <=      0;                                  
            mem_write       <=      0;                                
            reg_write       <=      0;                                
            mem_to_reg      <=      0;                              
            bds_sel         <=      0;                                    
            alu_result      <=      0;                              
            write_data      <=      0;                              
            write_register  <=      0;
            bds             <=      0;

        end
        else if(i_enable)
        begin
            jump            <=      i_jump;                                          
            jump_sel        <=      i_jump_sel;                                  
            mem_read        <=      i_mem_read;                                  
            mem_write       <=      i_mem_write;                                
            reg_write       <=      i_reg_write;                                
            mem_to_reg      <=      i_mem_to_reg;                              
            bds_sel         <=      i_bds_sel;                                    
            alu_result      <=      i_alu_result;                              
            write_data      <=      i_write_data;                              
            write_register  <=      i_write_register;
            bds             <=      i_bds;
        end
        // Else, stall the register
    end

    //! Assignments
    assign o_jump               =       jump;
    assign o_jump_sel           =       jump_sel;
    assign o_mem_read           =       mem_read;
    assign o_mem_write          =       mem_write;
    assign o_reg_write          =       reg_write;
    assign o_mem_to_reg         =       mem_to_reg;
    assign o_bds_sel            =       bds_sel;
    assign o_alu_result         =       alu_result;
    assign o_write_data         =       write_data;
    assign o_write_register     =       write_register;
    assign o_bds                =       bds;

endmodule