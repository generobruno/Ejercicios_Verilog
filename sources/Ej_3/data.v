/**
REPETIDOR DE DATOS
Escribir el código de un bloque que repita "N_REP" veces los bits de entrada "i_bits".
Esta entrada de i_bits es de tamaño "N_BITS_IN". La salida "o_extended_bits" tiene "N_BITS_OUT"
donde N_BITS_OUT > N_BITS_IN. Si N_BITS_OUT > (N_BITS_IN * N_REP), los bits mas significativos de 
la salida tienen que completarse con 0. Si N_BITS_OUT < (N_BITS_IN * N_REP), se replican los bits menos 
significativos hasta completar el ancho de salida.
Ejemplo:
Si i_bits={a,b,c}; N_BITS_IN=3; N_REP=2, N_BITS_OUT=8 entonces: o_extended_bits={1'b0,1'b0,a,a,b,b,c,c}.
Si <i_bits={a,b,c}; N_BITS_IN=3; N_REP=5, N_BITS_OUT=8> entonces: o_extended_bits={b,b,b,c,c,c,c,c}.
Nota a, b y c representan los bits de i_bits.
Nombre del módulo:
data_repeater
Parámetros:
N_REPT
N_BITS_OUT
N_BITS_IN
Entradas:
i_clock
i_bits
Salidas:
o_extended_bits
Objetivos:
Aprender el uso de setencias always y assigns

**/

module data_repeater
    #(
        // Parameters
        parameter   N_REPT      = 2,
        parameter   N_BITS_IN   = 8,
        parameter   N_BITS_OUT  = 4
    )
    (
        // Inputs
        input                       i_clock,
        input [N_BITS_IN-1 : 0]     i_bits,
        // Outputs
        output [N_BITS_OUT-1 : 0]   o_extended_bits
    );

    // Parameters
    localparam NB_EXTENDED = N_BITS_IN * N_REPT;

    // Signals
    reg [NB_EXTENDED : 0] extended_bits;
    integer               i;

    always @() 
    begin
        for(i = 0; i < N_BITS_IN; i = i + 1)
        begin
            extended_bits[iN_REPT +: N_REPT] <= {N_REPT};
        end
        
    end

endmodule