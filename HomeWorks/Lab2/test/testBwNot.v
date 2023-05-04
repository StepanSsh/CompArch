`include "../calculator.v"
module testBwNot();
    reg [3:0] a;
    output [3:0] bwNot_a;

    bitwiseNot bw_not(a, bwNot_a);

    initial begin
        $dumpfile("./dumps/dumpBwNot.vcd");
        $dumpvars;
    end
    
    initial begin
        a = 4'b0000;
        #5 a = 4'b0110;
    end

endmodule