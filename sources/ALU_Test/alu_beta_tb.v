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
    localparam N = 5;
    localparam NSel = 6;
    localparam N_SW = (N*2) + NSel;

    // Operation parameters
    localparam ADD = 6'b100000;
    localparam SUB = 6'b100010;
    localparam AND = 6'b100100;
    localparam OR  = 6'b100101;
    localparam XOR = 6'b100110;
    localparam SRA = 6'b000011;
    localparam SRL = 6'b000010;
    localparam NOR = 6'b100111;

    // Clock generation 
    reg clk = 0;
    always #25 clk = ~clk;

    // Inputs and Outputs
    reg [N_SW-1 : 0] i_sw;
    reg i_button_A, i_button_B, i_button_Op;
    wire [NSel-1:0] o_alu_Op;
    wire signed [N-1 : 0] o_alu_A, o_alu_B, o_alu_Result;
    wire o_ovf_flag;

    // Instantiate the ALU Input Control
    alu_input_ctrl #(.N_SW(N_SW), .N_OP(NSel), .N_OPERANDS(N)) u_ctrl (
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
        .o_alu_Result(o_alu_Result),
        .o_overflow_Flag(o_ovf_flag)
    );

    // Initial setup
    initial 
    begin
        i_sw = {N_SW {1'b0}};
        i_button_A = 0;
        i_button_B = 0;
        i_button_Op = 0;
    end

    // Operands Parameters
    reg signed [N-1 : 0] A_VALUE;
    reg signed [N-1 : 0] B_VALUE;
    reg signed [N-1 : 0] expected_res;

    initial
    begin 
        // Generate Random input values
        A_VALUE = $random;
        B_VALUE = $random;

        i_sw = {2'b00, ADD, B_VALUE, A_VALUE};
        #25 i_button_A = 1; 
        #25 i_button_A = 0;
        #25 i_button_B = 1;
        #25 i_button_B = 0;
        #25 i_button_Op = 1;
        #25 i_button_Op = 0;
        #50; // Wait 

        // Check results
        expected_res = A_VALUE + B_VALUE;
        if (o_alu_Result == expected_res) 
            $display("SUB passed OK!");
        else 
            $error("SUB test failed.");
    end

    // Monitor variables
    initial $monitor("A=%d, B=%d, Op=%b, Result=%d, OVF=%b",
                    o_alu_A, o_alu_B, o_alu_Op, o_alu_Result, o_ovf_flag);

endmodule