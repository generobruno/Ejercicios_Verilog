/**
    ALU Input Control
    Este modulo gestiona las entradas de la ALU, usando
    los switches de la pieza. Se utilizan 4 (o hasta 5) bits
    para los operandos de la ALU y 6 bits para definir la 
    operación que se realizará.
    Además, tenemos 3 botones para actualizar los valores
    mencionados, luego de que se haga un cambio en los switches.
**/

module alu_input_ctrl
    #(
        // Parameters
        parameter N_SW = 14,
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

    // TODO Initial con valores en 0 y/o agregar i_reset para limpiar regs???

    // Update values on button presses
    always @(posedge i_clock) 
    begin // TODO Ver manera de asignacion mas generica
        if (i_button_A) 
            stored_A <= i_sw[3:0];
        if (i_button_B) 
            stored_B <= i_sw[7:4];  
        if (i_button_Op) 
            stored_Op <= i_sw[13:8];     
    end

    // Connect input sw to alu inputs
    assign o_alu_A = stored_A;
    assign o_alu_B = stored_B;
    assign o_alu_Op = stored_Op;

endmodule