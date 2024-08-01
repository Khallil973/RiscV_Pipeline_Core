module program_counter(PC_NEXT,clk,PC,rst);
    input clk,rst;
    input [31:0] PC_NEXT;

    output reg [31:0] PC;

    always @(posedge clk) begin
    //We using Active Low Reset for Single cycle
        if (rst == 1'b0) begin
            PC <= 32'h00000000;
        end
        else begin
            PC <= PC_NEXT;
        end
    end

endmodule