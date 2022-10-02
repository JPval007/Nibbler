//Módulo para interconectar todos los módulos
module INTEL_i9 (input clock, reset, input [3:0] pushbuttons, output phase, c_flag, z_flag, output [3:0] instr, oprnd, data_bus, FF_out, accu, output [7:0] program_byte, output [11:0] pc, address_ram);//arreglar ins y outs
  //general y universal
  wire clock, reset;        //Clock y reset generales del procesador
  wire [3:0] pushbuttons;  //Puerto de entrada
  wire [3:0] FF_out; //Puerto de salida
  wire c_flag = Flags_out[1];
  wire z_flag = Flags_out[0];
  //debug
  wire Carry, Zero;
  wire inPC = Control[12];

  //CONTADOR PROGRAM COUNTER
  //wire ePC = Control[12]; //enable program counter
  wire loadPC = {Control[11]}; //load program counter
  wire [11:0] address_ram = {oprnd,program_byte}; //datos program counter
  wire [11:0] pc; //out del program counter
  contador_12 C0 (clock, Control[12], loadPC, address_ram, reset, pc);

  //Memoria READ ONLY (ROM)
  wire [7:0] program_byte;
  ROM7 R0 (pc, program_byte);

  //FETCH
  //reg enable_fetch = 1; //no sé si siempre está activado
  wire [7:0] out_fetch;
  wire [3:0] instr = out_fetch[7:4]; //opcode de la instrucción
  wire [3:0] oprnd = out_fetch[3:0];//literal de la instrucción

  wire n_phase;

  FETCHff FF0 (clock, program_byte, reset, n_phase, out_fetch);

  //phase
  wire phase;
  phase PH (reset, clock, phase, n_phase);

  //FLAGS
  wire loadFlags = Control[9];
  wire [1:0] Flags_out;
  FF_Flag F16 (clock, loadFlags, reset, {Carry, Zero}, Flags_out);

  //MÓDULO DECODE             Carry           Zero
  wire [12:0] Control;
  DECODE_FINAL DD0 (instr, Flags_out[1], Flags_out[0], phase, Control);

  //BUS DRIVER OPERAND
  wire data_bus;//salida del driver operand y entrada de la alu (B)
  wire oeOprnd = Control[1]; //Operand enable osea la literal de la instrucción
  B_Driver B0 (oprnd, data_bus, oeOprnd);

  //ACUMULADOR
  wire [3:0] ALU_out; //salida de la ALU
  wire [3:0] accu; //Entrada A de la ALU
  wire loadA = Control[10]; //load ACUMULADOR into ALU
  ACUMULADOR AC0 (clock, ALU_out, reset, loadA, accu);

  //ALU UNIDAD
  //está al inicio
  wire [2:0] S_ALU = Control[8:6];//Configuración de la ALU
  ALU_2 AA0 (accu, data_bus, S_ALU, ALU_out, Zero, Carry);

  //BUS DRIVER ALU OUT
  wire oeALU = Control[3];//OUTPUT ENABLE DE LA ALU
  B_Driver ALU_DRIVER (ALU_out, data_bus, oeALU);

  //MÓDULO RAM
  wire csRAM = Control[5]; //chip enable de la ram
  wire weRAM = Control[4]; //write enable de la ram
  RAM7 R3 (csRAM, weRAM, {oprnd,program_byte}, data_bus);

  //BUS DRIVER INPUTS I/O PORT
  wire oeIN = Control[2]; //Enable del puerto de entrada (deja pasar la entrada)
  B_Driver IN_PORT (pushbuttons, data_bus, oeIN);

  //Flip flop OUTPUTS I/O PORT
  wire oeOUT = Control[0]; //Enable del puerto de salida (deja pasasr la salida)
  ACUMULADOR FFOUT (clock, data_bus, reset, oeOUT, FF_out);

endmodule // INTEL_i9 por juan pablo valenzuela
