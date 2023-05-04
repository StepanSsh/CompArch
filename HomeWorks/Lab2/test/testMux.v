`include "../calculator.v"
module testMux();
    reg [3:0] a;
    reg [3:0] b;
    reg [3:0] c;
    reg [3:0] d;

    reg [1:0] ctrl;
    output [3:0] res;

    mux4to1_4bit my_mux(a, b, c, d, ctrl, res);

    initial begin
        $dumpfile("./dumps/dumpTestMux.vcd");
        $dumpvars;
    end

    initial begin
        a = 4'b0101;
        b = 4'b1010;
        c = 4'b0000;
        d = 4'b1111;

        #0 ctrl = 2'b00;
        #5 ctrl = 2'b01;
        #5 ctrl = 2'b10;
        #5 ctrl = 2'b11;
    end
endmodule