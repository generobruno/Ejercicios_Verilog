/**

**/

module IF
    #(
        // Parameters
        parameter INST_SZ = 32
    )
    (
        // Inputs
        input [INST_SZ-1 : 0]           i_instruction_F,            // Saved Instruction
        input [INST_SZ-1 : 0]           i_branch_addr_D,            // Branch Address
        input [INST_SZ-1 : 0]           i_jump_addr_D,              // Jump Address
        input [INST_SZ-1 : 0]           i_rs_addr_D,                // GPR[rs] Address
        input                           i_pc_src_D,                 // PCSrc Control Line
        input                           i_jump_D,                   // Jump Control Line
        input                           i_jump_sel_D,               // JumpSel Control Line
        input                           i_stall_pc_HD,              // StallPC Control Line
        input      
        // Outputs
        output [INST_SZ-1 : 0]          o_npc_F,                    // NPC
        output [INST_SZ-1 : 0]          o_branch_delay_slot_F,      // Branch Delay Slot
        output [INST_SZ-1 : 0]          o_instruction_F             // Instruction Fetched
    );

    //TODO Instanciar Modulos: NPC_Adder, BDS_Adder, Instruction_Memory, PC, MPX (x3)

endmodule