// module ternary_min(a0, a1, b0, b1, out0, out1);
//   input a0, a1, b0, b1;
//   output out0, out1;

// endmodule

module ternary_max(a0, a1, b0, b1, out0, out1);
  input wire a0, a1, b0, b1;
  output wire out0, out1;

  wire w1, w2;
  or_switch my_or1(a0, b0, out0);
  or_switch my_or2(a1, b1, w1);
  xor_switch my_xor(out0, w1, w2);
  and_switch my_and(w1, w2, out1);

endmodule

// module ternary_any(a0, a1, b0, b1, out0, out1);
//   input a0, a1, b0, b1;
//   output out0, out1;

// endmodule

module ternary_consensus(a0, a1, b0, b1, out0, out1);
  input wire a0, a1, b0, b1;
  output out0, out1;

  wire w1, w2;
  and_switch my_and(a0, b0, out0);
  or_switch my_or(a1, b1, w1);
  xor_switch my_xor(a0, b0, w2);
  or_switch res_or(w1, w2, out1);
  

endmodule


// Primitives

module not_switch (in, out);
    input wire in;
    output wire out;

    supply0 ground;
    supply1 power;

    pmos p1(out, power, in);
    nmos n1(out, ground, in);
    
endmodule


module nor_switch (a, b, out);
    input wire a, b;
    output wire out;
    wire w;

    supply0 ground;
    supply1 power;

    pmos p1(w, power, b);
    pmos p2(out, w, a);

    nmos n1(out, ground, a);
    nmos n2(out, ground, b);

endmodule


module nand_switch (a, b, out);
    input wire a, b;
    output wire out;
    wire w;

    supply0 ground;
    supply1 power;

    nmos n1(w, ground, b);
    nmos n2(out, w, a);

    pmos p1(out, power, a);
    pmos p2(out, power, b);

endmodule


module and_switch (a, b, out);
    input wire a, b;
    output wire out;

    wire w;
    nand_switch my_nand (a, b, w);
    not_switch my_not (w, out);

endmodule

module or_switch (a, b, out);
    input wire a, b;
    output wire out;

    wire w;
    nor_switch my_nor (a, b, w);
    not_switch my_not (w, out);

endmodule


module xor_switch (a, b, out);
    input wire a, b, a2, b2;
    output wire out;

    wire w1, w2;

    not_switch not_a(a, a2);
    not_switch not_b(b, b2);

    and_switch a_not_b(a, b2, w1);
    and_switch b_not_a(a2, b, w2);

    or_switch my_xor(w1, w2, out);

endmodule