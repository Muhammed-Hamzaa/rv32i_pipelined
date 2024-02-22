module decode(
    input wire         clk,
    input wire         rst,
    input wire  [31:0] instr_out,
    input wire  [31:0] rd_load_pc_imm,

    output wire        func7,
    output wire        r_type,
    output wire        i_type,
    output wire        store,
    output wire        load,
    output wire        branch,
    output wire        jal,
    output wire        jalr,
    output wire        lui,
    output wire        auipc,
    output wire        reg_write,
    output wire        branch_out,
    output wire        valid,
    output wire [3:0]  alu_ctrl,
    output wire [2:0]  imm_sel,
    output wire [2:0]  func3,
    output wire [31:0] s_imm,
    output wire [31:0] sb_imm,
    output wire [31:0] i_imm,
    output wire [31:0] uj_imm,
    output wire [31:0] u_imm,
    output wire [31:0] op1,  
    output wire [31:0] op2
);

    imm u_imm1(
        .clk(clk),
        .instr(instr_out),
        .i_type(i_type),
        .store(store),
        .load(load),
        .branch(branch),
        .jal(jal),
        .jalr(jalr),
        .lui(lui),
        .auipc(auipc),

        .s_imm(s_imm),
        .sb_imm(sb_imm),
        .i_imm(i_imm),
        .uj_imm(uj_imm),
        .u_imm(u_imm)
    );



    reg_file u_reg_file(
        .clk(clk),
        .rst(rst),
        .enable(reg_write),
        .rs1(instr_out[19:15]),
        .rs2(instr_out[24:20]),
        .rd(instr_out[11:7]),
        .data(rd_load_pc_imm),

        .op1(op1),
        .op2(op2)
    );

    type_decoder u_type_Decoder(
        .clk(clk),
        .valid(valid),
        .opcode(instr_out[6:0]),

        .r_type(r_type),
        .i_type(i_type), 
        .store(store),
        .load(load),
        .branch(branch),
        .jal(jal),
        .jalr(jalr),
        .lui(lui),
        .auipc(auipc)
    );

    cu u_cu(
        .clk(clk),
        .instr(instr_out),
        .r_type(r_type),
        .i_type(i_type), 
        .store(store),  
        .load(load),
        .branch(branch),
        .jalr(jalr),
        .jal(jal),
        .lui(lui),
        .auipc(auipc),

        .alu_ctrl(alu_ctrl),
        .reg_write(reg_write),
        .imm_sel(imm_sel),
        .func3(func3),
        .func7(func7)
    );

    branch u_branch (
        .clk(clk),
        .op1(op1),
        .op2(op2),
        .fun3(func3),
        .branch(branch),

        .branch_out(branch_out)
    );
endmodule