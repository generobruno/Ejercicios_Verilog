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
    localparam N = 4;
    localparam NSel = 6;

    // Clock generation 
    reg clk = 0;
    always #25 clk = ~clk;

    // Inputs and Outputs
    reg [15:0] i_sw;
    reg i_button_A, i_button_B, i_button_Op;
    wire [5:0] o_alu_Op;
    wire [N-1 : 0] o_alu_A, o_alu_B, o_alu_Result;

    // Instantiate the ALU Input Control
    alu_input_ctrl u_ctrl (
        .i_clock(clk),
        .i_sw(i_sw),
        .i_button_A(i_button_A),
        .i_button_B(i_button_B),
        .i_button_Op(i_button_Op),
        .o_alu_A(o_alu_A),
        .o_alu_B(o_alu_B),
        .o_alu_Op(o_alu_Op)
    );

    // Instantiate the ALU module
    alu #(.N(N), .NSel(NSel)) uut (
        .i_clock(clk),
        .i_alu_A(o_alu_A),
        .i_alu_B(o_alu_B),
        .i_alu_Op(o_alu_Op),
        .o_alu_Result(o_alu_Result)
    );

    // Initial setup
    initial 
    begin
        i_sw = 16'b0;
        i_button_A = 0;
        i_button_B = 0;
        i_button_Op = 0;
    end

    // TODO HACER PRUEBAS
    initial
    begin

    end

    // Monitor variables
    initial $monitor($time, "A=%d, B=%d, Op=%d, Result=%d",
                    o_alu_A, o_alu_B, o_alu_Op, o_alu_Result);

endmodule