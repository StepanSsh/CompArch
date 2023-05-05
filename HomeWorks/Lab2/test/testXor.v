`include "../calculator.v"
module testXor();
    reg a, b;
    wire and_out;

    xor_gate my_xor(a, b, and_out);

    initial begin
        $dumpfile("./dumpTestXor.vcd");
        $dumpvars;
    end
    
    initial begin
        a = 0; b = 0;
        #5 a = 0; b = 1;
        #5 a = 1; b = 0;
        #5 a = 1; b = 1;
    end

endmodule