`include "Program_Counter.v"
`include "Instruction_Memory.v"
`include "Register_Files.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "PC_Adder.v"
`include "Data_Memory.v"
`include "Mux.v"

module Single_Cycle_Top(clk,rst);
    input clk,rst;

    wire [31:0] PC_Top,RD_Instrc,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
    wire RegWrite_Top,MemWrite,ALUSrc_Top,ResultSrc_Top;
    wire [2:0] Alu_Control_Top;
    wire [1:0] ImmSrc;

    program_counter program(
            .PC_NEXT(PCPlus4),
            .clk(clk),
            .PC(PC_Top),
            .rst(rst)
    );
    
    pc_adder pc (
            .a(PC_Top),
            .b(32'd4),
            .c(PCPlus4)
            
        );

    instruction_memory instruction(
            .A(PC_Top),
            .rst(rst),
            .RD(RD_Instrc)
    );

    register_file register(
            .clk(clk),
            .rst(rst),
            .A1(RD_Instrc[19:15]),
            .A2(RD_Instrc[24:20]),
            .A3(RD_Instrc[11:7]),
            .WD3(Result),
            .WE3(RegWrite_Top),
            .RD1(RD1_Top),
            .RD2(RD2_Top)
    );

    sign_extend sign(
            .In(RD_Instrc),
            .ImmSrc(ImmSrc[0]),
            .Imm_Ext(Imm_Ext_Top)
    );

    mux mux_reg_to_ALU(
            .a(RD2_Top),
            .b(Imm_Ext_Top),
            .s(ALUSrc_Top),
            .c(SrcB)
    );

    ALU ALU(
            .A(RD1_Top),
            .B(SrcB),
            .ALUcontrol(Alu_Control_Top),
            .Result(ALUResult),
            .Z(),   
            .N(),
            .V(),
            .C()
    );

    control_unit_top control(
            .op(RD_Instrc[6:0]),
            .RegWrite(RegWrite_Top),
            .MemWrite(MemWrite),
            .ResultSrc(ResultSrc_Top),
            .ALUSrc(ALUSrc_Top),
            .Branch(),
            .ImmSrc(ImmSrc),
            .func3(RD_Instrc[14:12]),
            .func7(),
            .ALUControl(Alu_Control_Top)
    );

    data_memory data (
            .A(ALUResult),
            .clk(clk),
            .rst(rst),
            .WE(MemWrite),
            .WD(RD2_Top),
            .RD(ReadData)
            
    );


    mux mux_DataMem_to_Reg(
            .a(ALUResult),
            .b(ReadData),
            .s(ResultSrc_Top),
            .c(Result)
    );
    




endmodule