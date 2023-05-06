`include "../calculator.v"
module testAlu ();
    reg signed [3:0] a, b;
    reg [2:0] control;
    integer i;

    output signed [3:0] res;

    alu my_alu(a, b, control, res);

    initial begin
        $dumpfile("./dumps/dumpTestAlu.vcd");
        $dumpvars;
    end


    initial begin
        $monitor("a : %d, b : %d,\nop: %b,\nres : %d, res (bin) : %b\n******************", a, b, control, res, res);
        #0 a = -8; b = 7; control = 3'b000;
        for (i = 0; i < 7; i = i + 1) begin
            #1 control = control + 1;
        end
    end

endmodule