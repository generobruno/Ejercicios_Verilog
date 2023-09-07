module module_1_tb;
    // Inputs and Outputs
    reg [3:0] inputs;
    wire out1, out2;

    // Instantiate the module to be tested
    modulo_1 uut (
        .iAND_1(inputs[0]),
        .iAND_2(inputs[1]),
        .iAND_3(inputs[2]),
        .iAND_4(inputs[3]),
        .oOR_1(out1),
        .oAND_1(out2)
    );

    // Clock generation
    reg clk = 0;
    always #10 clk = ~clk;

    // Apply inputs
    initial 
    begin
    inputs = 4'h0;
    #10;

    // Start toggling inputs on rising clock edge
    repeat (16) begin
        #10 // Wait for the rising edge
        inputs = inputs + 1;
    end

    #10;  // Allow some time for last values to propagate
    $finish;
    end
    
    initial $monitor(out1, out2);

endmodule
