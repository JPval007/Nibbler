//Módulo en donde está la ALU

module contador_12 (input CLK, input enable, input load, input [11:0] DATA_IN, input reset, output [11:0] Count);
    reg Count=0;

    always @ ( posedge CLK or posedge reset) begin
        if (reset) begin
          Count <= 0;
        end
        else if (load) begin
          Count <= DATA_IN;
        end
        else if (enable == 1) begin
          Count <= Count +1;
        end
        else if (enable == 0) begin //enable chip
          Count <= Count;
        end

    end
/*
    always @ ( posedge reset ) begin
      Count = 0;
    end
*/
    always @ ( * ) begin //mecánica de reset asíncrono
        if (Count == 4096) begin //mecánica de overflow
          Count <= 0;
        end

    end



endmodule // contador_12
