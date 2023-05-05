`include "../calculator.v"
module testCalculator();
    reg [1:0] rd_addr, we_addr;
    reg [2:0] control;
    reg [3:0] immediate;
    wire [3:0] rd_data;
    reg clk;

    integer i;

    calculator calc(clk, rd_addr, immediate, we_addr, control, rd_data);
 
    initial begin
       for (i = 0; i < 2; i = i + 1) begin
        #5;
        clk = 1;
        rd_addr = 2'b00;

        #5;
        clk = 0;
        #5;
        $display("rd_data = %b\n", rd_data);

        #5;
        clk = 1;
        immediate = 4'b0010;
        we_addr = 2'b00;
        control = 3'b010;
        #5;
        clk = 0;
        #5;
        $display("rd_data = %b\n", rd_data);
       end 
    end
endmodule