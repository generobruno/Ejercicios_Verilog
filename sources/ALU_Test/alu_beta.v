/**
    Arithmetic-Logic Unit
    ALU parametrizable que realiza las siguientes operaciones
        1. ADD  : 100000
        2. SUB  : 100010
        3. AND  : 100100
        4. OR   : 100101
        5. XOR  : 100110
        6. SRA  : 000011
        7. SRL  : 000010
        8. NOR  : 100111

    Para instanciarla y sobreescribir el parametro por defecto:
        alu #(.N(8)) alu_1
            (.i_alu_A(a8), .i_alu_B(b8), .i_alu_op(op),
            .o_alu_Result(res8));
**/

module alu
    #(
        // Parameters
        parameter N = 4,                                // ALU Size
        parameter NSel = 6                              // ALU Op Size
    )
    (
        // Inputs
        input   [N-1 : 0]       i_alu_A, i_alu_B,       // ALU Operands // TODO Reg?
        input   [NSel-1 : 0]    i_alu_Op,               // ALU Operation// TODO Reg? 
        // Outputs
        output reg [N-1 : 0]    o_alu_Result            // ALU Result //TODO y los LEDS?
    );

    // TODO Definir operaciones como localparam

    // Body
    always @(*) // TODO clock?
    begin

        // Make Operation depending on ALU Op
        case(i_alu_Op)
            6'b100000: o_alu_Result = i_alu_A + i_alu_B;   
            6'b100010: o_alu_Result = i_alu_A - i_alu_B;
            6'b100100: o_alu_Result = i_alu_A & i_alu_B;
            6'b100101: o_alu_Result = i_alu_A | i_alu_B;
            6'b100110: o_alu_Result = i_alu_A ^ i_alu_B;
            6'b000011: o_alu_Result = i_alu_A >> i_alu_B; // TODO REVISAR SI ES ESTO
            6'b000010: o_alu_Result = i_alu_A << i_alu_B; // TODO REVISAR SI ES ESTO
            6'b100111: o_alu_Result = ~ (i_alu_A | i_alu_B);
            default: o_alu_Result = {N,{1'b0}}; // TODO Esto esta bien?
        endcase


    end

endmodule