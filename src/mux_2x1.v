module mux_2x1 (
    input wire         sel,
    input wire  [31:0] a,
    input wire  [31:0] b,

    output wire [31:0] out
);

    assign out = (sel)? b : a;
endmodule