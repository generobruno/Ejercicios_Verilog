/**
    Adder con carry parametrizado (4-bit default).
    
    Para instanciarlo y sobreescribir el parametro por defecto:
        adder_carry #(.N(8)) adder_1
            (.i_adder_a(a8), .i_adder_b(b8),
            .o_adder_sum(sum8), .o_cout(c8));
**/

module adder_carry
    #(
        // Parameters
        parameter N = 4;
    )
    (
        // Inputs
        input wire [N-1 : 0] i_adder_a, i_adder_b;
        // Outputs
        output wire [N-1 : 0] o_adder_sum,
        output wire o_cout
    );

    // Constants
    localparam N1 = N - 1;

    // Signal Declaration
    wire [N : 0] sum_ext;

    // Body
    assign sum_ext = {1'b0, i_adder_a} + {1'b0, i_adder_b};
    assign o_adder_sum = sum_ext[N1 : 0];
    assign o_cout = sum_ext[N];

endmodule