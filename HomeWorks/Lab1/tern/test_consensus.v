`include "ternary_logic.v"

module test_consensus();
    reg a0, a1, b0, b1;
    wire out0, out1;
    

    ternary_consensus my_consensus(a0, a1, b0, b1, out0, out1);
    
    // initial begin
    //    $dumpfile("./dumpCons.vcd");
    //    $dumpvars; 
    // end

    initial begin
        $monitor("Input a: %b%b, Input b: %b%b Output: %b%b", a0, a1, b0, b1, out0, out1);
        a0 = 0; a1 = 0; b0 = 0; b1 = 0;
        #5 a0 = 0; a1 = 0; b0 = 0; b1 = 1;
        #5 a0 = 0; a1 = 0; b0 = 1; b1 = 0;
        #5 a0 = 0; a1 = 1; b0 = 0; b1 = 0;
        #5 a0 = 0; a1 = 1; b0 = 0; b1 = 1;
        #5 a0 = 0; a1 = 1; b0 = 1; b1 = 0;
        #5 a0 = 1; a1 = 0; b0 = 0; b1 = 0;
        #5 a0 = 1; a1 = 0; b0 = 0; b1 = 1;
        #5 a0 = 1; a1 = 0; b0 = 1; b1 = 0;
    end

endmodule