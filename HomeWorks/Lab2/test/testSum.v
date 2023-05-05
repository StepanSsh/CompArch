`include "../calculator.v"
module testSum();
    reg signed [3:0] a, b;
    output [3:0] res;

    sum_gate my_sum(a, b, res);

    initial begin
        $dumpfile("./dumps/dumpTestSum.vcd");
        $dumpvars;
    end
    
    initial begin
        a = 4'b0000; b = 4'b0000;
        #5 a = 4'b0001; b = 4'b0001;
    end

endmodule