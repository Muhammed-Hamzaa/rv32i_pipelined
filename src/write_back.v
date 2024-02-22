module write_back(
    input wire         clk,
    input wire         jalr,
    input wire         jal,
    input wire         lui,
    input wire         load,
    input wire  [31:0] alu_out,
    input wire  [31:0] byte_accessL,
    input wire  [31:0] pc_address_out,
    input wire  [31:0] u_imm,

    output wire [31:0] rd_load_pc_imm
);

    mux_4x1 u_mux_4x1(
        .clk(clk),
        .a(alu_out),
        .b(byte_accessL),
        .c(pc_address_out+4),
        .d(u_imm),
        .sel({jalr|jal|lui , load|lui}),

        .out(rd_load_pc_imm)
    );
endmodule