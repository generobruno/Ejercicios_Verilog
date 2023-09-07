/**
    Test Bench para ALU
    Se deben usar los switches de la placa basys 3 (16) para ingresar los
    valores de i_A, i_B e i_ALU_Op, multiplexados en el tiempo. Esto quiere
    decir que primero se ingresa el valor A con el switch, luego se presiona
    otro botón ("next") para que se guarde ese valor, y se hace lo mismo con 
    B y ALU_Op. 
    Luego de ingresar ALU_Op y el next, se mostrará el resultado de la operación
    encendiendo los leds de la placa para un 1 y apagandolos para un 0 en la palabra.
**/

module alu_alfa_tb;

    // Parameters
    localparam N = 6;
    localparam NSel = 6;

    // Clock generation 
    reg clk = 0;
    always #5 clk = ~clk;

    // Inputs and Outputs
    reg [N-1:0] i_alu_A;            // Input switches for i_alu_A
    reg [N-1:0] i_alu_B;            // Input switches for i_alu_B
    reg [NSel-1:0] i_alu_Op;        // Input switches for i_alu_Op
    wire [N-1:0] o_alu_Result;      // Output LEDs

    // Instantiate the ALU module
    alu #(.N(N), .NSel(NSel)) uut (
        .i_clock(clk),
        .i_alu_A(i_alu_A),
        .i_alu_B(i_alu_B),
        .i_alu_Op(i_alu_Op),
        .o_alu_Result(o_alu_Result)
    );

    // Initial setup
    initial 
    begin
        // Initialize inputs
        i_alu_A = {N {1'b0}};
        i_alu_B = {N {1'b0}};
        i_alu_Op = {NSel {1'b0}};
        #10
    end

    // Monitor variables
    initial $monitor($time, "A=%d, B=%d, Op=%d, Result=%d",
                    i_alu_A, i_alu_B, i_alu_Op, o_alu_Result);

endmodule