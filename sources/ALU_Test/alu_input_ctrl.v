/**

**/

module alu_input_ctrl
    #(
        // Parameters
        parameter N_SW = 16,
        parameter N_OP = 6,
        parameter N_OPERANDS = 4
    )(
        // Inputs
        input                           i_clock,
        input [N_SW-1 : 0]              i_sw,
        input                           i_button_A,
        input                           i_button_B,
        input                           i_button_Op,
        // Outputs
        output [N_OPERANDS-1 : 0]       o_alu_A,
        output [N_OPERANDS-1 : 0]       o_alu_B,
        output [N_OP-1 : 0]             o_alu_Op
    );

    // Registers to store values
    reg [N_OPERANDS-1 : 0] stored_A;
    reg [N_OPERANDS-1 : 0] stored_B;
    reg [N_OP-1 : 0] stored_Op;

    // Connect input sw to alu inputs
    assign o_alu_A = stored_A;
    assign o_alu_B = stored_B;
    assign o_alu_Op = stored_Op;

    // TODO Initial con valores en 0??

    // Update values on button presses
    always @(posedge i_clock) 
    begin // TODO Ver manera de asignacion mas generica
        if (i_button_A) stored_A <= i_sw[3:0];
        if (i_button_A) stored_A <= i_sw[7:4];  
        if (i_button_A) stored_A <= i_sw[13:8];     
    end

endmodule