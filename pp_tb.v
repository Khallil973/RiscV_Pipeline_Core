module tb();

    reg clk = 0;
    reg rst;

    // Internal signals to connect to the register file
    wire [31:0] RD1;
    wire [31:0] RD2;

    // Instantiate the pipeline top module
    pipeline_top dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    always #50 clk = ~clk;

    // Reset and simulation control
    initial begin
        // Initialize reset
        rst = 1;
        #100; // Hold reset for 100 time units
        rst = 0;
        #500; // Run the simulation for 500 time units
        $finish;
    end

    // Dump signals for waveform viewing
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    // Monitor the register file outputs
    initial begin
        $monitor("Time: %0d | RD1: %h | RD2: %h", $time, dut.register_file.RD1, dut.register_file.RD2);
    end

endmodule
