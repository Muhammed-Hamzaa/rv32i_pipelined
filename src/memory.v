// `include "byteAccess.v"

module memory(
    input wire         clk,
    input wire         load,
    input wire         store,
    input wire  [31:0] alu_out,
    input wire  [2:0]  func3,
    input wire  [31:0] dataMem_out,
    input wire  [31:0] op2,

    output wire [31:0] byte_accessL,
    output wire [31:0] byte_accessS,
    output wire [3:0]  masking_byte
);

    byte_access u_byte_access(
        .clk(clk),
        .load(load),
        .store(store),
        .byte_address(alu_out[1:0]),
        .func3(func3),
        .data_inL(dataMem_out),
        .data_inS(op2),

        .byte_accessL(byte_accessL),
        .byte_accessS(byte_accessS),
        .masking(masking_byte)
    );
endmodule