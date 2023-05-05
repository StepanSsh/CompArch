`include "../calculator.v"
module testAnd();
    reg a, b;
    wire and_out;

    and_gate my_and(a, b, and_out);

    initial begin
        $dumpfile("./dumps/dumpTestAnd.vcd");
        $dumpvars;
    end
    
    initial begin
        a = 0; b = 0;
        #5 a = 0; b = 1;
        #5 a = 1; b = 0;
        #5 a = 1; b = 1;
    end

endmodule