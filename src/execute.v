module execute(
    input wire         branch_out,
    input wire         jal,
    input wire         auipc,
    input wire         clk,
    input wire  [31:0] op1,
    input wire  [31:0] pc_address_out,
    input wire  [2:0]  imm_sel,
    input wire  [31:0] op2,
    input wire  [3:0]  alu_ctrl,
    input wire  [31:0] i_imm,
    input wire  [31:0] s_imm,
    input wire  [31:0] sb_imm,
    input wire  [31:0] uj_imm,
    input wire  [31:0] u_imm,

    output wire [31:0] op1_pc,
    output wire [31:0] alu_out
);

    wire [31:0] op2_imm;

    mux_8x1 U_mux_8x1(
        .clk(clk),
        .a(op2),
        .b(i_imm),
        .c(s_imm),
        .d(sb_imm),
        .e(uj_imm),
        .f(u_imm),
        .sel(imm_sel),

        .out(op2_imm)
    );

    mux_2x1 u_mux_2x1(
        .a(op1),
        .b(pc_address_out),
        .sel(branch_out|jal|auipc),

        .out(op1_pc)
    );

    alu u_alu(
        .clk(clk),
        .op1(op1_pc),
        .op2(op2_imm),
        .alu_ctrl(alu_ctrl),
    
        .out(alu_out)
    );
endmodule