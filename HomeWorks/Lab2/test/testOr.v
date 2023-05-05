`include "../calculator.v"
module testOr();
    reg a, b;
    wire and_out;

    or_gate my_or(a, b, and_out);

    initial begin
        $dumpfile("./dumps/dumpTestOr.vcd");
        $dumpvars;
    end
    
    initial begin
        a = 0; b = 0;
        #5 a = 0; b = 1;
        #5 a = 1; b = 0;
        #5 a = 1; b = 1;
    end

endmodule