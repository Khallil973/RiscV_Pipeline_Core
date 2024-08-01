`include "main_decoder.v"
`include "Alu_decoder.v"


module control_unit_top(op,RegWrite,MemWrite,ResultSrc,ALUSrc,Branch,ImmSrc,func3,func7,ALUOp,ALUControl);

    input [6:0]op,func7;
    input [2:0]func3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc,ALUOp;
    output [2:0]ALUControl;

    wire [1:0] ALUOp;

    main_decoder main (
                    .op(op),
            //        .zero(),
                    .RegWrite(RegWrite),
                    .MemWrite(MemWrite),
                    .ResultSrc(ResultSrc),
                    .ALUSrc(ALUSrc), 
                    .ImmSrc(ImmSrc),
                    .ALUOp(ALUOp), 
                    .Branch(Branch)
           //         .PCSrc()
    );

    Alu_decoder Alu(
                    .func3(func3),
                    .func7(func7),
                    .ALUOp(ALUOp),
                    .ALUControl(ALUControl),
                    .op(op)
             
    );

endmodule
