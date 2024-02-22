module fetch ( 
    input wire         clk,
    input wire         rst,
    input wire         load,
    input wire         store,
    input wire         valid,
    input wire         branch_out,
    input wire         jal,
    input wire         jalr,
    input wire  [31:0] alu_out,

    output wire [31:0] pc_address_out,
    output wire [31:0] pc_prev_address
);

    pc u_pc(
        .clk(clk),
        .rst(rst),
        .load(load),
        .store(store),
        .valid(valid),
        .jalr(jalr),
        .branch_jal(branch_out|jal),
        .branch_jump_address(alu_out),
        .jalr_address(alu_out),

        .address_out(pc_address_out),
        .prev_address(pc_prev_address)
    );
endmodule