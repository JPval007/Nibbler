//Módulo de la memoria RAM
module RAM7 (
  input wire csRAM, weRAM,
  input wire [11:0] address,
  inout [3:0] data
  );
  reg [3:0] data_out;
  //la ram es de 4k de largo y 4 bits de ancho
  reg [3:0] memory [0:4095]; //4095 de tamaño

  initial begin
    memory[0] = 12'b0000_1111; //el dato en la dirección 0 es f
  end

  assign data = (csRAM && !weRAM) ? data_out : 4'bzzzz;

  //Para leer la RAM7 cs tiene que estar en 1 y weRam tiene que estar en 0
  always @ ( address or csRAM or weRAM ) begin
  if (csRAM && !weRAM)
    data_out = memory[address];
  end

//pARA escribir un valor en la RAM se tiene que
//cs == 1 y weRAM = 1
  always @ ( address or csRAM or weRAM or data ) begin
  if (csRAM && weRAM)
    memory[address] = data;
  end

endmodule // RAM7
