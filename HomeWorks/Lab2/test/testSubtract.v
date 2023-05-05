`include "../calculator.v"
module testSubtract();
    reg signed [3:0] a, b;
    output [3:0] res;

    alu alu0(a, b, 3'b110, res);

    initial begin
        $dumpfile("./dumps/dumpTestSubtract.vcd");
        $dumpvars;
    end
    
    initial begin
        a = 4'b0000; b = 4'b0000;
        #5 a = 4'b0100; b = 4'b0001;
    end

endmodule