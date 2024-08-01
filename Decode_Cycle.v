//`include "Control_Unit_Top.v"
//`include "Register_Files.v"
//`include "Sign_Extend.v"

module decode_cycle (clk,rst,InstrD,PCD,PCPlus4D,RegWriteW,RD_W,ResultW,RegWriteE,MemWriteE,ResultSrcE,ALUSrcE,BranchE,ALUControlE,RD1_E,RD2_E,Imm_Ext_E,RD_E,PCE,PCPlus4E,RS1_E,RS2_E);

    //Delcaring I/O
    input clk,rst,RegWriteW;
    input [4:0] RD_W;
    input [31:0] InstrD,PCD,PCPlus4D,ResultW;

    //Output
    output RegWriteE,MemWriteE,ALUSrcE,BranchE,ResultSrcE;
    output [2:0] ALUControlE;
  //  output [1:0] ResultSrcE;
    output [4:0] RD_E,RS1_E,RS2_E;
    output [31:0] RD1_E,RD2_E,Imm_Ext_E;
    output [31:0] PCE,PCPlus4E;


    //Declare Interim Wires
    wire RegWriteD,MemWriteD,ALUSrcD,BranchD,ResultSrcD;
    wire [1:0] ImmSrcD;
    wire [2:0] ALUControlD;
    wire [31:0] RD1_D, RD2_D,Imm_Ext_D;

    //Declare Of Interim Register 
    reg RegWriteD_r,MemWriteD_r,ALUSrcD_r,BranchD_r,ResultSrcD_r;
    reg [2:0] ALUControlD_r;
   // reg [1:0] ResultSrcD_r;
    reg [4:0] RD_r,RS1_D_r,RS2_D_r;
    reg [31:0] RD1_D_r,RD2_D_r,Imm_Ext_D_r;
    reg [31:0] PCD_r,PCPlus4D_r,Result_r; 

    //Initiate the Modules
    //Control Unit
    control_unit_top control (
                        .op(InstrD[6:0]),
                        .RegWrite(RegWriteD),
                        .MemWrite(MemWriteD),
                        .ResultSrc(ResultSrcD),
                        .ALUSrc(ALUSrcD),
                        .Branch(BranchD),
                        .ImmSrc(ImmSrcD),
                        .func3(InstrD[14:12]),
                        .func7(InstrD[31:25]),
                        .ALUControl(ALUControlD)                        
    );

    //Register Files
    register_file register (
                        .clk(clk),
                        .rst(rst),
                        .A1(InstrD[19:15]),
                        .A2(InstrD[24:20]),
                        .A3(RD_W),
                        .WD3(ResultW),
                        .WE3(RegWriteW),
                        .RD1(RD1_D),
                        .RD2(RD2_D)
                        
    );

    //Sign Extension
    sign_extend sign(
                        .In(InstrD[31:0]),
                        .ImmSrc(ImmSrcD),
                        .Imm_Ext(Imm_Ext_D)
                        
    );

    //Declaring Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
                RegWriteD_r <= 1'b0;
                MemWriteD_r <= 1'b0;
                ResultSrcD_r <= 1'b0;
                ALUSrcD_r <= 1'b0;
                BranchD_r <= 1'b0;
                ALUControlD_r <= 3'b000;
                RD1_D_r <= 32'h00000000;
                RD2_D_r <= 32'h00000000;
                Imm_Ext_D_r <= 32'h00000000;     
                RD_r <= 5'h00;               
                PCD_r <= 32'h00000000;
                PCPlus4D_r <= 32'h00000000;
                RS1_D_r <= 32'h00000000;
                RS2_D_r <= 32'h00000000;
        end
        else begin
                RegWriteD_r <= RegWriteD;
                MemWriteD_r <= MemWriteD;
                ResultSrcD_r <= ResultSrcD;
                ALUSrcD_r <= ALUSrcD;
                BranchD_r <= BranchD;
                ALUControlD_r <= ALUControlD;
                RD1_D_r <= RD1_D;
                RD2_D_r <= RD2_D;
                Imm_Ext_D_r <= Imm_Ext_D;     
                RD_r <= InstrD[11:7];               
                PCD_r <= PCD;
                PCPlus4D_r <= PCPlus4D; 
                RS1_D_r <= InstrD[19:15];
                RS2_D_r <= InstrD[24:20];
        end
    end 

    //Output Assign Statements
    assign RegWriteE = RegWriteD_r;
    assign MemWriteE = MemWriteD_r;
    assign ResultSrcE = ResultSrcD_r;
    assign ALUSrcE = ALUSrcD_r;
    assign BranchE = BranchD_r;
    assign ALUControlE = ALUControlD_r;
    assign RD1_E = RD1_D_r;
    assign RD2_E = RD2_D_r;
    assign Imm_Ext_E = Imm_Ext_D_r;     
    assign RD_E = RD_r;               
    assign PCE = PCD_r;
    assign PCPlus4E = PCPlus4D_r;
    assign RS1_E = RS1_D_r;
    assign RS2_E = RS2_D_r;


endmodule