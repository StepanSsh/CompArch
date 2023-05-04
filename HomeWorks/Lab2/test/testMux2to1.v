`include "../calculator.v"
module testMux2to1();
    reg [3:0] a;
    reg [3:0] b;

    reg ctrl;
    output [3:0] res;

    mux2to1_4bit my_mux(a, b, ctrl, res);

    initial begin
        $dumpfile("./dumps/dumpTestMux2to1.vcd");
        $dumpvars;
    end

    initial begin
        a = 4'b0101;
        b = 4'b1010;

        #0 ctrl = 1'b0;
        #5 ctrl = 1'b1;
    end
endmodule