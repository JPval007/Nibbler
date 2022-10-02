module DECODE_FINAL (input wire [3:0] Opcode, input wire C, input wire zero, input wire phase, output reg [12:0] Control);
    wire [6:0] data = {Opcode, C, zero, phase};

    always @ ( data ) begin
    casex (data)
        7'b??????0: Control = 13'b1000000001000; //any
        7'b00001?1: Control = 13'b0100000001000; //JC
        7'b00000?1: Control = 13'b1000000001000; //JC
        7'b00011?1: Control = 13'b1000000001000; //JCN
        7'b00010?1: Control = 13'b0100000001000; //JCNC
        7'b0010??1: Control = 13'b0001001000010; //CMPI
        7'b0011??1: Control = 13'b1001001100000; //CMPM
        7'b0100??1: Control = 13'b0011010000010;//LIT
        7'b0101??1: Control = 13'b0011010000100;//IN
        7'b0110??1: Control = 13'b1011010100000;//LD
        7'b0111??1: Control = 13'b1000000111000;//ST
        7'b1000?11: Control = 13'b0100000001000;//JZ
        7'b1000?01: Control = 13'b1000000001000;//JZ
        7'b1001?11: Control = 13'b1000000001000;//JNZ
        7'b1001?01: Control = 13'b0100000001000;//JNZ
        7'b1010??1: Control = 13'b0011011000010;//ADDI
        7'b1011??1: Control = 13'b1011011100000;//ADDM
        7'b1100??1: Control = 13'b0100000001000;//JMP
        7'b1101??1: Control = 13'b0000000001001;//OUT
        7'b1110??1: Control = 13'b0011100000010;//NANDI
        7'b1111??1: Control = 13'b1011100100000;//NANDM
        default: Control = 13'b1000000001000; //si no coincide con nada
        //no hace nada
    endcase

    end
endmodule // DECODE
