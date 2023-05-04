`include "ternary_logic.v"

module test_max;
    reg a0, a1, b0, b1;
    wire out0, out1;
    
    ternary_max my_max(a0, a1, b0, b1, out0, out1);

    initial begin
        $monitor("Input a: %b%b, Input b: %b%b Output: %b%b", a0, a1, b0, b1, out0, out1);
        #0 a0 = 0; a1 = 0; b0 = 0; b1 = 0;
        #5 a0 = 0; a1 = 0; b0 = 0; b1 = 1;
        #10 a0 = 0; a1 = 0; b0 = 1; b1 = 0;
        #20 a0 = 0; a1 = 1; b0 = 0; b1 = 0;
        #25 a0 = 0; a1 = 1; b0 = 0; b1 = 1;
        #30 a0 = 0; a1 = 1; b0 = 1; b1 = 0;
        #40 a0 = 1; a1 = 0; b0 = 0; b1 = 0;
        #45 a0 = 1; a1 = 0; b0 = 0; b1 = 1;
        #50 a0 = 1; a1 = 0; b0 = 1; b1 = 0;
    end

endmodule