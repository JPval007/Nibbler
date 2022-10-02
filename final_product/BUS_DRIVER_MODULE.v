//Módulo del bus driver

module B_Driver (input [3:0] IN, output [3:0] OUT, input enable);
  reg OUT;

  always @ ( * ) begin
    case (enable)
      1: OUT = IN;
      default: OUT = 4'bz;
    endcase
  end
endmodule // B_Driver



//Módulo de PHASE acá está
module phase (input logic reset, clk,
  output logic Q, output wire n_Q);

  always @ ( posedge clk or posedge reset )
    begin
      if (reset)
        Q <=0 ;
      else
        Q <= ~Q;
    end

    assign n_Q = ~Q;

endmodule // phase

//FlipFLop para load flags
module FF_Flag (input CLK, input enable, reset, input [1:0] Data_in, output [1:0] Data_out);
    reg Data_out = 0;

    always @ ( posedge CLK or posedge reset ) begin
      if (reset)
        Data_out = 0;
      else if (enable == 1)
        Data_out = Data_in;
      else
        Data_out = Data_out;
    end
endmodule // FF_Flag
