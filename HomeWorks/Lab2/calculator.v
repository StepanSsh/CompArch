module alu(a, b, control, res);
    input [3:0] a, b; // Операнды
    input [2:0] control; // Управляющие сигналы для выбора операции 
    output [3:0] res; // Результат
    // TODO: implementation
    wire [3:0] invertB;
    bitwiseNot invert_B(b, invertB);

    wire [3:0] muxB;
    mux2to1_4bit mux_B(b, invertB, control[2], muxB);


    wire [3:0] andRes, orRes;
    bitwiseAnd and_res(a, muxB, andRes);
    bitwiseOr or_res(a, muxB, orRes);


    wire [3:0] adderRes;
    sum_switch adder_res(a, muxB, control[2], adderRes);

    wire [3:0] zeroExRes;
    zeroExtend zeroEx_res(adderRes, zeroExRes);
    
    mux4to1_4bit res_mux(andRes, orRes, adderRes, zeroExRes, control[1:0], res);

    // initial begin
    //     $monitor("a : %b,\nb : %b,\ninvB : %b,\nmuxB : %b,\na and b OR a and !b: %b,\na + b OR a - b : %b,\nnot used : 011,\na | b OR a | !b : %b,\nslt : %b", a, b, invertB, muxB, andRes, adderRes, orRes, zeroExRes);
    // end

    

endmodule

module d_latch(clk, d, we, q);
    input clk; // Сигнал синхронизации
    input d; // Бит для записи в ячейку
    input we; // Необходимо ли перезаписать содержимое ячейки

    output reg q; // Сама ячейка
    // Изначально в ячейке хранится 0
    initial begin
        q <= 0;
    end
    // Значение изменяется на переданное на спаде сигнала синхронизации
    always @ (negedge clk) begin
        if (we) begin
            q <= d;
        end
    end
endmodule

module d_latch_4bit (clk, d, we, q);
    input clk;
    input [3:0] d;
    input we;

    output [3:0] q;

    d_latch d0(clk,d[0],we,q[0]);
    d_latch d1(clk,d[1],we,q[1]);
    d_latch d2(clk,d[2],we,q[2]);
    d_latch d3(clk,d[3],we,q[3]);
    
endmodule

module register_file(clk, rd_addr, we_addr, we_data, rd_data);
    input clk; // Сигнал синхронизации
    input [1:0] rd_addr, we_addr; // Номера регистров для чтения и записи
    input [3:0] we_data; // Данные для записи в регистровый файл
    
    output [3:0] rd_data; // Данные, полученные в результате чтения из регистрового файла

    // TODO: implementation
    wire [3:0] isWe;
    wire [3:0] q0, q1, q2, q3;
    supply1 vdd;
    supply0 gnd;


    decorder2to4 decode_write(we_addr, isWe);
    
    d_latch_4bit d0(clk, we_data, isWe[0], q0);
    d_latch_4bit d1(clk, we_data, isWe[1], q1);
    d_latch_4bit d2(clk, we_data, isWe[2], q2);
    d_latch_4bit d3(clk, we_data, isWe[3], q3);

    mux4to1_4bit mux_read(q0, q1, q2, q3, rd_addr, rd_data);
    
endmodule

module calculator(clk, rd_addr, immediate, we_addr, control, rd_data);
    input clk; // Сигнал синхронизации
    input [1:0] rd_addr; // Номер регистра, из которого берется значение первого операнда
    input [3:0] immediate; // Целочисленная константа, выступающая вторым операндом
    input [1:0] we_addr; // Номер регистра, куда производится запись результата операции
    input [2:0] control; // Управляющие сигналы для выбора операции

    output [3:0] rd_data; // Данные из регистра c номером 'rd_addr', подающиеся на выход
    // TODO: implementation

    wire [3:0] we_data;

    register_file regFile(clk, rd_addr, we_addr, we_data, rd_data);
    
    alu alu0(rd_data, immediate, control, we_data);

endmodule


module zeroExtend (a, res);
    input [3:0] a;
    output [3:0] res;

    assign res[3] = 0;
    assign res[2] = 0;
    assign res[1] = 0;
    assign res[0] = a[3];
    
endmodule

module mux2to1_4bit (op0, op1, control, res);
    input [3:0] op0, op1;
    input control;
    output [3:0] res;

    wire [1:0] a0 = {op1[0], op0[0]};
    wire [1:0] a1 = {op1[1], op0[1]};
    wire [1:0] a2 = {op1[2], op0[2]};
    wire [1:0] a3 = {op1[3], op0[3]};

    mux2to1 mux_0th(a0, control, res[0]);
    mux2to1 mux_1th(a1, control, res[1]);
    mux2to1 mux_2th(a2, control, res[2]);
    mux2to1 mux_3th(a3, control, res[3]);
    
endmodule


module mux4to1_4bit(op0, op1, op2, op3, control, res);

    input [3:0] op0, op1, op2, op3;
    input [1:0] control;
    output [3:0] res;

    wire [3:0] a0 = {op3[0], op2[0], op1[0], op0[0]};
    wire [3:0] a1 = {op3[1], op2[1], op1[1], op0[1]};
    wire [3:0] a2 = {op3[2], op2[2], op1[2], op0[2]};
    wire [3:0] a3 = {op3[3], op2[3], op1[3], op0[3]};

    mux4to1 mux_0th(a0, control, res[0]);
    mux4to1 mux_1th(a1, control, res[1]);
    mux4to1 mux_2th(a2, control, res[2]);
    mux4to1 mux_3th(a3, control, res[3]);

    
endmodule

module demux2to4_4bit (addr, d, q0, q1, q2, q3);
   input [1:0] addr;
   input [3:0] d;

   output [3:0] q0, q1, q2, q3;
   
   demux2to4 dm0(addr, d[0], {q0[0], q1[0], q2[0], q3[0]});
   demux2to4 dm1(addr, d[1], {q0[1], q1[1], q2[1], q3[1]});
   demux2to4 dm2(addr, d[2], {q0[2], q1[2], q2[2], q3[2]});
   demux2to4 dm3(addr, d[3], {q0[3], q1[3], q2[3], q3[3]});

endmodule


module mux2to1 (a, control, res);

    input [1:0] a;
    input control;
    output res;

    wire not_control;
    
    not_switch not_0(control, not_control);

    wire and0, and1;
    and_switch and_0(a[0], not_control, and0);
    and_switch and_1(a[1], control, and1);

    or_switch or_0(and0, and1, res);
endmodule

module decorder2to4(addr, res);
    input [1:0] addr;
    output [3:0] res;
    
    wire [1:0] not_addr;

    not_switch not0(addr[0], not_addr[0]);
    not_switch not1(addr[1], not_addr[1]);
    
    and_switch and0(not_addr[0], not_addr[1], res[0]);
    and_switch and1(addr[0], not_addr[1], res[1]);
    and_switch and2(not_addr[0], addr[1], res[2]);
    and_switch and3(addr[0], addr[1], res[3]);

endmodule

module demux2to4(addr, d, res);
    input [1:0] addr;
    input d;

    output [3:0] res;

    wire [2:0] not_addr;
    
    not_switch not_0(addr[0], not_addr[0]);
    not_switch not_1(addr[1], not_addr[1]);

    wire [3:0] andWire;
    
    and_switch and_0_0(not_addr[0], not_addr[1], andWire[0]);
    and_switch and_0_1(d, andWire[0], andWire[0]);

    and_switch and_1_0(addr[0], not_addr[1], andWire[1]);
    and_switch and_1_1(d, andWire[1], andWire[1]);

    and_switch and_2_0(not_addr[0], addr[1], andWire[2]);
    and_switch and_2_1(d, andWire[2], andWire[2]);

    and_switch and_3_0(addr[0], addr[1], andWire[3]);
    and_switch and_3_1(d, andWire[3], andWire[3]);

    assign res = andWire;


endmodule

module mux4to1(a, control, res);

    input [3:0] a;
    input [1:0] control;
    output res;

    wire not_c0, not_c1;

    not_switch not_0(control[0], not_c0);
    not_switch not_1(control[1], not_c1);

    wire and0, and1, and2, and3, d0, d1, d2, d3;

    and_switch and_0_0(not_c0, not_c1, d0);
    and_switch and_0_1(d0, a[0], and0);

    and_switch and_1_0(control[0], not_c1, d1);
    and_switch and_1_1(d1, a[1], and1);

    and_switch and_2_0(not_c0, control[1], d2);
    and_switch and_2_1(d2, a[2], and2);

    and_switch and_3_0(control[0], control[1], d3);
    and_switch and_3_1(d3, a[3], and3);

    wire tOr1, tOr2;
    or_switch or_0(and0, and1, tOr1);
    or_switch or_1(and2, and3, tOr2);
    or_switch or_2(tOr1, tOr2, res);

endmodule

module sum_switch(a, b, cin, res);
    input [3:0] a, b;
    input cin;
    output [3:0] res;

    wire [3:0] cout;

    fullAdder adder0(a[0], b[0], cin, res[0], cout[0]);
    fullAdder adder1(a[1], b[1], cout[0], res[1], cout[1]);
    fullAdder adder2(a[2], b[2], cout[1], res[2], cout[2]);
    fullAdder adder3(a[3], b[3], cout[2], res[3], cout[3]);

endmodule

module fullAdder(a, b, cin, s, cout);
    // s = a ^ b ^ cin
    // cout = ab || (cin & (a ^ b)) 

    input a, b, cin;
    output s, cout;

    wire aXorb;

    xor_switch xor_1(a, b, aXorb);
    xor_switch xor_2(aXorb, cin, s);

    wire aAndb;
    wire cinAndaxb;

    and_switch and_1(a, b, aAndb);
    and_switch and_2(aXorb, cin, cinAndaxb);
    or_switch or_1(aAndb, cinAndaxb, cout);


endmodule


module bitwiseNot(a, res);
    input [3:0] a;
    output [3:0] res;

    not_switch not_0(a[0], res[0]);
    not_switch not_1(a[1], res[1]);
    not_switch not_2(a[2], res[2]);
    not_switch not_3(a[3], res[3]);
    
endmodule



module bitwiseOr(a, b, res);
    input [3:0] a, b;
    output [3:0] res;

    or_switch or_0(a[0], b[0], res[0]);
    or_switch or_1(a[1], b[1], res[1]);
    or_switch or_2(a[2], b[2], res[2]);
    or_switch or_3(a[3], b[3], res[3]);
    
endmodule


module bitwiseAnd(a, b, res);
    input [3:0] a, b;
    output [3:0] res;

    and_switch and_0(a[0], b[0], res[0]);
    and_switch and_1(a[1], b[1], res[1]);
    and_switch and_2(a[2], b[2], res[2]);
    and_switch and_3(a[3], b[3], res[3]);

endmodule


module xor_switch(a, b, out);
    // a ^ b = (not a and b) OR (not b and a)
    input wire a, b;

    output wire out;

    wire notA, notB, nAB, AnB;

    not_switch not_1(a, notA);
    not_switch not_2(b, notB);

    and_switch and_1(notA, b, nAB);
    and_switch and_2(a, notB, AnB);

    or_switch my_or(nAB, AnB, out);

endmodule

module or_switch(a, b, out);
    input wire a, b;
    output wire out;

    wire w;

    nor_switch my_nor(a, b, w);
    not_switch my_not(w, out);
endmodule

module nor_switch(a, b, out);
    input wire a, b;
    output wire out;

    supply0 gnd;
    supply1 vdd;

    wire w1;

    pmos p1(w1, vdd, a);
    pmos p2(out, w1, b);

    nmos n1(out, gnd, a);
    nmos n2(out, gnd, b);
    
endmodule


module and_switch(a, b, out);
    input wire a, b;
    output wire out;

    wire w;

    nand_switch my_nand(a, b, w);
    not_switch my_not(w, out);


endmodule


module nand_switch(a, b, out);
    input wire a, b;
    output wire out;

    supply0 gnd;
    supply1 vdd;

    wire w1;

    pmos p1(out, vdd, a);
    pmos p2(out, vdd, b);

    nmos n1(w1, gnd, a);
    nmos n2(out, w1, b);

endmodule

module not_switch(a, out);
    input wire a;
    output wire out;

    supply0 gnd;
    supply1 vdd;

    pmos p1(out, vdd, a);
    nmos n1(out, gnd, a);

endmodule