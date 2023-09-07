// Ejercicio 1

module modulo_1
(
    input wire iAND_1,
    input wire iAND_2,
    input wire iAND_3,
    input wire iAND_4,
    
    output wire oOR_1,
    output wire oAND_1
);

    // Definitions
    wire iAND_1_2, iAND_3_4, aux1, aux2;

    // Aux wires
    assign iAND_1_2 = (iAND_1 & iAND_2);
    assign aux1 = (iAND_1_2 | iAND_3);
    assign aux2 = (~aux1);
    assign iAND_3_4 = (iAND_3 & iAND_4);

    // Outputs
    assign oOR_1 = (aux2 | iAND_3_4);
    assign oAND_1 = (iAND_3_4 & iAND_3 & iAND_4);

endmodule