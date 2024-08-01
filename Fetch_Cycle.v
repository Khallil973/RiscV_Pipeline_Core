//`include "Program_Counter.v"
//`include "PC_Adder.v"
//`include "Mux.v"
//`include "Instruction_Memory.v"

module fetch_cycle(clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D);

    //Declare input and outputs
    input clk,rst;
    input PCSrcE;
    input [31:0] PCTargetE;
    output [31:0] InstrD;
    output [31:0] PCD,PCPlus4D;

    //Declare Interim wires 
    wire [31:0] PC_F,PCF,PCPlus4F;
    wire [31:0] InstrF;

    //Declaration of Registers
    reg [31:0] InstrF_reg;
    reg [31:0] PCF_reg, PCPlus4F_reg;

    //Initiation of Modules
    //Declare PC MUX
    mux PC_mux (
                        .a(PCPlus4F),
                        .b(PCTargetE),
                        .s(PCSrcE),
                        .c(PC_F)
                        
    );

    //Declare Program Counter
    program_counter program(
                        .PC_NEXT(PC_F),
                        .clk(clk),
                        .PC(PCF),
                        .rst(rst)
                        
     );

    //Declare Instruction Memory
    instruction_memory instruction(
                        .A(PCF),
                        .rst(rst),
                        .RD(InstrF)
                        
    );

    //Declare PC Adder
    pc_adder pc(      
                    .a(PCF),
                    .b(32'h00000004),
                    .c(PCPlus4F)
                    
    );

    //Fetch Cycle Register Logic
    always @ (posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
                InstrF_reg <= 32'h00000000;
                PCF_reg <= 32'h00000000;
                PCPlus4F_reg <= 32'h00000000;
        end
        else begin
                InstrF_reg <= InstrF;
                PCF_reg <= PCF;
                PCPlus4F_reg <= PCPlus4F;
        end

    end    

        //Assigning Registers Value to the Output Port
        assign InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
        assign PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
        assign PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;

endmodule