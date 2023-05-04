`include "../calculator.v"
module testMuxSingle();
    reg [3:0] a;
    reg [1:0] ctrl;
    output res;

    mux4to1 my_mux(a, ctrl, res);

    initial begin
        $dumpfile("./dumps/dumpTestMuxSingle.vcd");
        $dumpvars;
    end

    initial begin
        a = 4'b1111; ctrl = 2'b00;
        #5 ctrl = 2'b01;
        #5 ctrl = 2'b10;
        #5 ctrl = 2'b11;
    end
endmodule