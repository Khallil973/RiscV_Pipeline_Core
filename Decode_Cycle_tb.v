module tb();

    //Delcaring I/O
    reg clk,rst,RegWriteW;
    reg [4:0] RDW;
    reg [31:0] InstrD,PCD,PCPlus4D,ResultW;

    //Output
    wire RegWriteE,MemWriteE,ALUSrcE,BranchE,ResultSrcE;
    wire [2:0] ALUControlE;
   // wire [1:0] ResultSrcE;
    wire [4:0] RD_E;
    wire [31:0] RD1_E,RD2_E,Imm_Ext_E;
    wire [31:0] PCE,PCPlus4E;

    //Declare the desin under test
    decode_cycle dut (
                        .clk(clk),
                        .rst(rst),
                        .InstrD(InstrD),
                        .PCD(PCD),
                        .PCPlus4D(PCPlus4D),
                        .RegWriteW(RegWriteW),
                        .RDW(RDW),
                        .ResultW(ResultW),
                        .RegWriteE(RegWriteE),
                        .MemWriteE(MemWriteE),
                        .ResultSrcE(ResultSrcE),
                        .ALUSrcE(ALUSrcE),
                        .BranchE(BranchE),
                        .ALUControlE(ALUControlE),
                        .RD1_E(RD1_E),
                        .RD2_E(RD2_E),
                        .Imm_Ext_E(Imm_Ext_E),
                        .RD_E(RD_E),
                        .PCE(PCE),
                        .PCPlus4E(PCPlus4E)
    );

    //Generation of Clock
    always begin
        clk <= 1'b0;
        #50;
        clk <= 1'b1;
        #50;
    end

    //Provide the Stimulas
    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        RegWriteW <= 1'b0;
        RDW <= 5'b00000;
        InstrD <= 32'h00000000;
        PCD <= 32'h00000000;
        PCPlus4D <= 32'h00000000;
        ResultW <= 32'h00000000;
        #500;
        $finish;
    end

    //Generation Of VCD file 
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

endmodule   