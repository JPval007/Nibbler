//Módulo de la UNIDAD ARITMÉTICA Y LÓGICA ALU 4000.0

//Versión 2 ALU
module ALU_2 (input [3:0] A,
  input [3:0] B,
  input [2:0] S,
  output [3:0] Y,
  output ZERO,
  output C_out);

  reg [3:0] Resultado = 0;
  reg [4:0] Working ;
  reg C_out;

  assign Y = Working[3:0];
  assign ZERO = (Working[3:0]==0);

  always @ ( A, B, S ) begin //COMPORTAMIENTO DE LA SALIDA Y
    case (S)
      0: Working = A;
      2: Working = B;
      3: Working = A + B;
      1: Working = A - B; //Comparar
      4: Working = ~(A & B);
      default: Working = 0;
    endcase
    case (S)
      3: C_out = Working[4];    //2: C_out = Working[4];  suma
      1: C_out = (A<B);         //3: C_out = (A>B);       resta
      default: C_out = 0 ;
    endcase
  end

endmodule // ALU_2

//El bit Z se enciende cuando Y = 0
//El bit C_out se enciende cuando hay un carry
