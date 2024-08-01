module tb();

    //Declare I/O
    reg clk,rst,PCSrcE;
    reg [31:0] PCTargetE;
    wire [31:0] InstrD, PCD, PCPlus4D;


    //Declare the desin under test
    fetch_cycle dut(
                        .clk(clk),
                        .rst(rst),
                        .PCSrcE(PCSrcE),
                        .PCTargetE(PCTargetE),
                        .InstrD(InstrD),
                        .PCD(PCD),
                        .PCPlus4D(PCPlus4D)
                        
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
        PCSrcE <= 1'b0;
        PCTargetE <= 32'h00000000;
        #500;
        $finish;
    end


    //Generation Of VCD file 
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

endmodule