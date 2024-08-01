//`include "Mux.v"

module write_cycle(clk,rst,ResultSrcW,PCPlus4W,ALU_ResultW,ReadDataW,ResultW);

//Declaration Of Modules I/O
input clk,rst,ResultSrcW;
input [31:0] PCPlus4W,ALU_ResultW,ReadDataW;

output [31:0] ResultW;

//Declaring Modules
mux dut_mux  (
                .a(ALU_ResultW),
                .b(ReadDataW),
                .s(ResultSrcW),
                .c(ResultW)
                
);


endmodule