module ram #(
    parameter INIT_MEM = 0
)(
    input wire        clk,
    input wire        w_en,
    input wire        request,
    input wire [7:0]  address,
    input wire [3:0]  masking,
    input wire [31:0] write_data,

    output reg [31:0] read_data
);

    reg [31:0] mem [0:255];

    // always @ (posedge clk) begin
    //     read_data= mem[address];
    // end

    // iMEM
    initial begin
        if (INIT_MEM)
            $readmemh("tb/instr.mem",mem);
    end

    always @ (posedge clk) begin 
        if(request & w_en)begin
            if(masking[0]) begin
                mem[address][7:0] <= write_data[7:0];
            end
            if(masking[1]) begin
                mem[address][15:8] <= write_data[15:8];
            end
            if(masking[2]) begin
                mem[address][23:16] <= write_data[23:16];
            end
            if(masking[3]) begin           
                mem[address][31:24] <= write_data[31:24];
            end
        end
        else if(request & !w_en)begin
            read_data <= mem[address];
        end
    end              
endmodule
