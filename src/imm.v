// Immediate generation
module imm(
    input wire        clk,
    input wire        load,
    input wire        i_type,
    input wire        store,
    input wire        branch,
    input wire        jalr,
    input wire        jal,
    input wire        lui,
    input wire        auipc,
    input wire [31:0] instr,
    
    output reg [31:0] s_imm,
    output reg [31:0] i_imm,
    output reg [31:0] sb_imm,
    output reg [31:0] uj_imm,
    output reg [31:0] u_imm
);

    always @(*) begin
        if(store)begin
            s_imm = {{20{instr[7]}},instr[31:25], instr[11:7]};
        end
        if(i_type | load | jalr)begin
            i_imm = {{20{instr[31]}},instr[31:20]};
        end
        if(branch)begin
            sb_imm = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
        end
        if(jal)begin
            uj_imm = {{11{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21],1'b0};
        end
         if(lui | auipc)begin
            u_imm = {instr[31:12],12'b0};
        end
    end
endmodule