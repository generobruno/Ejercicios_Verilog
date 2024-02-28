/**
    Arithmetic-Logic Unit
    ALU parametrizable
**/

module alu
    #(
        // Parameters
        parameter N = 32,                               // ALU Size
        parameter NSel = 6                              // ALU Op Size
    )
    (
        // Inputs
        input [N-1 : 0]        i_alu_A, i_alu_B,       // ALU Operands 
        input [4 : 0]          i_shamt,
        input [NSel-1 : 0]     i_alu_Op,               // ALU Operation
        // Outputs
        output wire [N-1 : 0]    o_alu_Result          // ALU Result
    );

    // Operation parameters
    localparam ADD  =       6'b100000;      // Add Word 
    localparam SUB  =       6'b100010;      // Subtract Word 
    localparam AND  =       6'b100100;      // Logical bitwise AND 
    localparam ADDU =       6'b100001;      // Add Word Unsigned
    localparam SUBU =       6'b100011;      // Subtract Word Unsigned
    localparam OR   =       6'b100101;      // Logical bitwise OR
    localparam XOR  =       6'b100110;      // Logical bitwise XOR
    localparam NOR  =       6'b100111;      // Logical bitwise NOR
    localparam SRA  =       6'b000011;      // Shift Word Right Arithmetic
    localparam SRL  =       6'b000010;      // Shift Word Right Logic
    localparam SLL  =       6'b000000;      // Shift Word Left Logic
    localparam SLLV =       6'b000100;      // Shift Word Left Logic Variable
    localparam SRLV =       6'b000110;      // Shift Word Right Logic Variable
    localparam SRAV =       6'b000111;      // Shift Word Right Arithmetic Variable
    localparam SLT  =       6'b101010;      // Set on Less Than


    // Register aux
    reg [N-1 : 0]    alu_Result;          // ALU Result
    assign o_alu_Result = alu_Result;

    wire [N-1 : 0] ext_shamt;
    assign ext_shamt = {{N-5{1'b0}}, i_shamt}; 

    // Body
    always @(*)
    begin
        //! Make Operation depending on ALU Op
        case(i_alu_Op)
            ADD     : alu_Result = $signed(i_alu_A) + $signed(i_alu_B);
            SUB     : alu_Result = $signed(i_alu_A) - $signed(i_alu_B);
            ADDU    : alu_Result = i_alu_A + i_alu_B;
            SUBU    : alu_Result = i_alu_A - i_alu_B;
            AND     : alu_Result = i_alu_A & i_alu_B;
            OR      : alu_Result = i_alu_A | i_alu_B;
            XOR     : alu_Result = i_alu_A ^ i_alu_B;
            SRA     : alu_Result = $signed(i_alu_B) >>> ext_shamt;
            SRL     : alu_Result = i_alu_B >> ext_shamt;
            NOR     : alu_Result = ~ (i_alu_A | i_alu_B);
            SLL     : alu_Result = i_alu_B << ext_shamt;
            SLLV    : alu_Result = i_alu_B << i_alu_A;
            SRLV    : alu_Result = i_alu_B >> i_alu_A;
            SRAV    : alu_Result = $signed(i_alu_B) >>> i_alu_A;
            SLT     : alu_Result = $signed(i_alu_A) < $signed(i_alu_B);
            default : alu_Result = {N {1'b0}};
        endcase
    end

endmodule