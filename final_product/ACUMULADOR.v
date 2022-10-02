//Módulo de FETCH (FLIP FLOP TIPO D CON RESET)
module ACUMULADOR (input CLK, input [3:0] Data, input RESET, input enable, output [3:0] Q);
    reg Q = 0;

    always @ ( * ) begin
      if (RESET == 1) begin
          Q = 0;
      end
    end

    always @ ( posedge CLK ) begin
        if (RESET == 1) begin
            Q = 0;
        end

        else if (enable == 1) begin
          Q <= Data;
        end

        else if (enable == 0) begin
          Q <= Q;
        end
    end


endmodule //flip flop  D de 8 bits con ENABLE Y RESET ASÍNCRONO
