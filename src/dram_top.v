module dram_top #(
    parameter INIT_MEM = 0
)(
    input wire         rst,
    input wire         load,
    input wire         request,
    input wire         clk,
    input wire         w_en,
    input wire  [7:0]  address,
    input wire  [31:0] write_data,
    input wire  [3:0]  masking,

    output reg         valid,
    output wire [31:0] read_data
);

    always @(posedge clk or negedge rst ) begin
        if(!rst)begin
            valid <= 0;
        end
        else begin
            valid <= load;
        end
    end

    ram #(
        .INIT_MEM(INIT_MEM)
    ) u_ram(
        .clk(clk),
        .address(address),
        .w_en(w_en),
        .request(request),
        .write_data(write_data),
        .masking(masking),

        .read_data(read_data)
    );
endmodule