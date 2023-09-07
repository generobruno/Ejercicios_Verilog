module hex_to_sseg
    (
        input wire [3:0] hex,   // Hex number
        input wire dp,          // Decimal point
        
        output reg [7:0] sseg   // Segments - Output active Low
    );

    always @(*) 
    begin
        case(hex)
            4'h0: sseg[6:0] = 7'b0000001;
            4'h1: sseg[6:0] = 7'b1001111;
            4'h2: sseg[6:0] = 7'b0010010;
            4'h3: sseg[6:0] = 7'b0000110;
            4'h4: sseg[6:0] = 7'b1001100;
            4'h5: sseg[6:0] = 7'b0100100;
            4'h6: sseg[6:0] = 7'b0100000;
            4'h7: sseg[6:0] = 7'b0001111;
            4'h8: sseg[6:0] = 7'b0000000;
            4'h9: sseg[6:0] = 7'b0000100;
            4'ha: sseg[6:0] = 7'b0001000;
            4'hb: sseg[6:0] = 7'b1100000;
            4'hc: sseg[6:0] = 7'b0110001;
            4'hd: sseg[6:0] = 7'b1000010;
            4'he: sseg[6:0] = 7'b0111000;
            default: sseg[6:0] = 7'b0111000; // 4'hf
        endcase
        sseg[7] = dp;   // MSB of output connected to dp
    end

endmodule