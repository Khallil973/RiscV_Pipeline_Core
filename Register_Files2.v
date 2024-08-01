module register_file(
    input clk,
    input rst,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    input WE3,
    output reg [31:0] RD1, RD2
);

    // Creation of memory
    reg [31:0] Registers [31:0];

    // Read functionality
    always @(*) begin
        // Address[0] = ZERO
        Registers[0] = 32'h00000000;
        
        // Source Register 1
        if (Registers[A1] === 32'hxxxx_xxxx) begin
            RD1 = 32'h00000000;
        end else begin
            RD1 = Registers[A1];
        end
        
        // Source Register 2
        if (Registers[A2] === 32'hxxxx_xxxx) begin
            RD2 = 32'h00000000;
        end else begin
            RD2 = Registers[A2];
        end
    end
/*
    // Write Enable Functionality
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Registers[0] <= 32'h00000000;
            // Optionally, reset other registers here if needed
        end else if (WE3 & (A3 != 5'h00)) begin
            Registers[A3] <= WD3;
        end
    end */

    always @(posedge clk) begin
      if(WE3 & (A3 != 5'h00)) begin
            Registers[A3] <= WD3;
      end
    end

endmodule
