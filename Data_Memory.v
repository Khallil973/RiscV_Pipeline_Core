module data_memory(A,clk,rst,WE,WD,RD);

    input clk,WE,rst;
    input [31:0] A,WD;


    output [31:0] RD;

    //Creating the memory
    reg [31:0] Data_Mem [1023:0];

    //Read
    assign RD = (WE == 1'b0) ? Data_Mem[A] : 32'h00000000;
 //   assign RD = (~rst) ? 32'd0 : Data_Mem[A];

    //Write
    always @(posedge clk) begin

            if (WE) begin
                Data_Mem[A] <= WD;
            end
    end

    initial begin
        //final result RD in data memory is 0000001c = 28 
        Data_Mem[0] = 32'h00000000;
     //   Data_Mem[72] = 32'h00000002;
    end
    
endmodule