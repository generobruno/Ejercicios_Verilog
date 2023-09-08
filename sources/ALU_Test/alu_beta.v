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
        alu #(.N(5), .NSel(6)) uut (
            .i_clock(clk),
            .i_alu_A(o_alu_A),
            .i_alu_B(o_alu_B),
            .i_alu_Op(o_alu_Op),
            .o_alu_Result(o_alu_Result)
        );
**/

module alu
    #(
        // Parameters
        parameter N = 4,                                // ALU Size
        parameter NSel = 6                              // ALU Op Size
    )
    (
        // Inputs
        input                   i_clock,
        input   [N-1 : 0]       i_alu_A, i_alu_B,       // ALU Operands 
        input   [NSel-1 : 0]    i_alu_Op,               // ALU Operation
        // Outputs
        output reg [N-1 : 0]    o_alu_Result            // ALU Result 
    );

    // Operation parameters
    localparam ADD = 6'b100000;     // Add Word - If overflow, then trap // TODO Detect of?
    localparam SUB = 6'b100010;     // Subtract Word - If overflow, then trap // TODO Detect of?
    localparam AND = 6'b100100;     // Logical bitwise AND 
    localparam OR  = 6'b100101;     // Logical bitwise OR
    localparam XOR = 6'b100110;     // Logical bitwise XOR
    localparam SRA = 6'b000011;     // Shift Word Right Arithmetic
    localparam SRL = 6'b000010;     // Shift Word Right Logic
    localparam NOR = 6'b100111;     // Logical bitwise NOR 

    // Body
    always @(posedge i_clock)
    begin
        // Make Operation depending on ALU Op
        case(i_alu_Op)
            ADD     : o_alu_Result <= i_alu_A + i_alu_B;   
            SUB     : o_alu_Result <= i_alu_A - i_alu_B;
            AND     : o_alu_Result <= i_alu_A & i_alu_B;
            OR      : o_alu_Result <= i_alu_A | i_alu_B;
            XOR     : o_alu_Result <= i_alu_A ^ i_alu_B;
            SRA     : o_alu_Result <= i_alu_A >>> i_alu_B;
            SRL     : o_alu_Result <= i_alu_A >> i_alu_B;
            NOR     : o_alu_Result <= ~ (i_alu_A | i_alu_B);
            default : o_alu_Result <= {N {1'b0}}; // TODO Esto esta bien?
        endcase
    end

endmodule