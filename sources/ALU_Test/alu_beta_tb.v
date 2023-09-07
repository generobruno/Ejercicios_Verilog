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
    localparam N = 16;
    localparam NSel = 6;

    // Clock generation 
    reg clk = 0;
    always #5 clk = ~clk; // TODO VER DIAP. 25

    // Inputs and Outputs
    reg [N-1:0] i_alu_A;            // Input switches for i_alu_A
    reg [N-1:0] i_alu_B;            // Input switches for i_alu_B
    reg [NSel-1:0] i_alu_Op;        // Input switches for i_alu_Op
    wire [N-1:0] o_alu_Result;      // Output LEDs

    // Instantiate the ALU module
    alu #(.N(N), .NSel(NSel)) uut (
        .i_alu_A(i_alu_A),
        .i_alu_B(i_alu_B),
        .i_alu_Op(i_alu_Op),
        .o_alu_Result(o_alu_Result)
    );

    // Button for saving inputs
    reg next = 0;

    always @ (posedge clk) // TODO ???
    begin
        // Simulate button press
        if (next) begin // TODO next es un solo boton??
            i_alu_A <= {SWITCHES};
            i_alu_B <= {SWITCHES};
            i_alu_Op <= {SWITCHES};
            next <= 0;
        end
    end

    // TODO CAMBIAR {SWITCHES} POR INPUTS DEL SWITCH

    // Initial setup
    initial 
    begin
        // Initialize inputs
        i_alu_A = 16'b0;
        i_alu_B = 16'b0;
        i_alu_Op = 6'b0;

        // Simulate a common button press to trigger ALU operation
        next = 1;
        #10 next = 0;
        #100 $finish;
    end

endmodule


/*


DEPRECATED


module alu_alfa_tb;
    // Inputs and Outputs
    reg [7:0] i_A, i_B;
    reg [5:0] i_ALU_Op;
    wire [7:0] o_ALU_Result;

    // Instantiation of ALU
    alu #(.N(8)) alu_1
        (.i_alu_A(i_A), .i_alu_B(i_B), .i_alu_Op(i_ALU_Op),
        .o_alu_Result(o_ALU_Result));

    // Test
    //TODO Modificar test para que sea mpx en tiempo
    //TODO Incluir generación aleatoria de entradas y chequeo auto
    initial 
    begin
        i_ALU_Op = 6'b100000; // ADD

        // Test 1
        i_A = 8'b1111_1111; i_B = 8'b0000_0000;
        #50 
        i_A = 8'b1111_0000; i_B = 8'b0000_1111;
        #50 
        i_A = 8'b1111_1111; i_B = 8'b1111_1111;
        #50 
        $finish;
    end

    // Monitor variables
    initial $monitor($time, "A=%d, B=%d, Op=%d, Result=%d",
                    i_A, i_B, i_ALU_Op, o_ALU_Result);

    // Write file
    initial 
    begin
        $dumpfile("dump_alu_tb.vcd"); $dumpvars;
    end

endmodule

/*