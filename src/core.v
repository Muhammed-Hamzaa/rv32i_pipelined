module core (
    input wire         clk,
    input wire         rst,
    input wire         valid,
    input wire         ivalid,
    input wire  [31:0] instr_out,
    input wire  [31:0] dataMem_out,

    output wire        load,
    output wire        store,
    output wire        request,
    output reg         irequest,
    output wire [31:0] alu_out,
    output wire [31:0] pc_address_out,
    output wire [3:0]  masking_byte,
    output wire [31:0] byte_accessS
);

    wire        branch_out;
    wire        r_type;
    wire        i_type;
    wire        branch;
    wire        jal;
    wire        jalr;
    wire        lui;
    wire        auipc;
    wire [31:0] s_imm;
    wire [31:0] sb_imm;
    wire [31:0] i_imm;
    wire [31:0] uj_imm;
    wire [31:0] u_imm;
    wire [31:0] op1;  
    wire [31:0] op2;
    wire [2:0]  func3;
    wire [3:0]  alu_ctrl;
    wire [2:0]  imm_sel;
    wire [31:0] byte_accessL;
    wire [31:0] rd_load_pc_imm;
    wire [31:0] op1_pc;
    wire [31:0] pc_prev_address;
    wire [31:0] prev_fpipe_address_out;
    wire [31:0] instr_fpipe;

    assign request = load | store;


    always @ (*) begin
        if (load && !valid) begin
            // mask = 4'b1111; 
            // we_re = 1'b0;
            irequest = 1'b0;
        end
        else begin
            // mask = 4'b1111; /
            // we_re = 1'b0;
            irequest = 1'b1;
        end
    end

    fetch u_fetch(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .load(load),
        .store(store),
        .branch_out(branch_out),
        .jal(jal),
        .jalr(jalr),
        .alu_out(alu_out),

        .pc_address_out(pc_address_out),
        .pc_prev_address(pc_prev_address)
    );

    fetch_pipe u_fetch_pipe(
        .clk(clk),
        .jal(jal),
        .jalr(jalr),
        .branch_out(branch_out),
        .load(load),
        .instr_out(instr_out),
        .pc_prev_address(pc_prev_address),

        .prev_fpipe_address_out(prev_fpipe_address_out),
        .instr_fpipe(instr_fpipe)
    );

    decode u_decode(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .instr_out(instr_fpipe),
        .rd_load_pc_imm(rd_load_pc_imm),

        .func3(func3),
        .func7(func7),
        .s_imm(s_imm),
        .sb_imm(sb_imm),
        .i_imm(i_imm),
        .uj_imm(uj_imm),
        .u_imm(u_imm),
        .op1(op1),
        .op2(op2),
        .r_type(r_type),
        .i_type(i_type),
        .store(store),
        .load(load),
        .branch(branch),
        .jal(jal),
        .jalr(jalr),
        .lui(lui),
        .auipc(auipc),
        .alu_ctrl(alu_ctrl),
        .reg_write(reg_write),
        .imm_sel(imm_sel),
        .branch_out(branch_out)
    );

    execute u_execute(
        .op1(op1),
        .pc_address_out(prev_fpipe_address_out),
        .branch_out(branch_out),
        .jal(jal),
        .auipc(auipc),
        .clk(clk),
        .imm_sel(imm_sel),
        .op2(op2),
        .alu_ctrl(alu_ctrl),
        .i_imm(i_imm),
        .s_imm(s_imm),
        .sb_imm(sb_imm),
        .uj_imm(uj_imm),
        .u_imm(u_imm),

        .op1_pc(op1_pc),
        .alu_out(alu_out)
    );

    memory u_memory(
        .clk(clk),
        .load(load),
        .store(store),
        .alu_out(alu_out),
        .func3(func3),
        .dataMem_out(dataMem_out),
        .op2(op2),

        .byte_accessL(byte_accessL),
        .byte_accessS(byte_accessS),
        .masking_byte(masking_byte)
    );

    write_back u_write_back(
        .clk(clk),
        .alu_out(alu_out),
        .byte_accessL(byte_accessL),
        .pc_address_out(prev_fpipe_address_out),
        .u_imm(u_imm),
        .jalr(jalr),
        .jal(jal),
        .lui(lui),
        .load(load),

        .rd_load_pc_imm(rd_load_pc_imm)
    );
endmodule