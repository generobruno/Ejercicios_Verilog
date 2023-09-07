module sign_mag_add
    #(
        // Parameters
        parameter N = 4;
    )
    (
        // Inputs
        input wire  [N-1 : 0] i_adder_a, i_adder_b;
        // Outputs
        output reg   [N-1 : 0] o_sum;
    );

    // Signal Declaration
    reg [N-2 : 0] mag_a, mag_b, mag_sum, max, min;
    reg sign_a, sign_b, sign_sum;

    // Body
    always @(*)
    begin
        // Separate magnitude and sign
        mag_a = i_adder_a[N-2:0];
        mag_b = i_adder_b[N-2:0];
        sign_a = i_adder_a[N-1];
        sign_b = i_adder_b[N-1];

        // Sort according to magnitude
        if (mag_a > mag_b)
            begin
                max = mag_a;
                min = mag_b;
                sign_sum = sign_a;
            end
        else
            begin
                max = mag_b;
                min = mag_a;
                sign_sum = sign_b;
            end

        // Add/Sub magnitude
        if(sign_a == sign_b)
            mag_sum = max + min;
        else
            mag_sum = max - min;

        // Form output
        sum = {sign_sum, mag_sum};

    end
endmodule