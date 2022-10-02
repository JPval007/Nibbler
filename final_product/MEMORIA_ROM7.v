//Módulo de la memoria ROM
module ROM7 (input wire [11:0] dir, output wire [7:0] datos);

        reg [7:0] MEMORY_SPACE [0:4095]; //la memoria debe ser de 64 bits de largo

        assign datos = MEMORY_SPACE[dir];

        initial begin
          $readmemb("prog_rom.list", MEMORY_SPACE);//LA MEMORIA LA LEE DE ESTE ARCHIVO
        end

endmodule // ROM7

/*
initial begin //ordenar esto para que cumpla con las cosas
  MEMORY_SPACE[0] = 8'b0010_0001; //CMPI
  MEMORY_SPACE[1] = 8'b0100_0101; //LIT
  MEMORY_SPACE[2] = 8'b1010_0001; //ADDI
  MEMORY_SPACE[3] = 8'b1110_0000; //NANDI
end

*/

/*
//REGISTROS DE PUEBA
reg [11:0]address = 0;
wire [7:0]data;

//módulo de la rom
ROM7 U0 (address, data);

initial begin
  $display("Direccion\t            Dato\t");
  $monitor("%h\t            %h\t", address, data);
  #1 address = 1;
  #1 address = 2;
  #1 address = 3;
  #1 address = 16;


  $finish;
end
*/
