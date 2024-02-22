module reg_file (
    input wire         clk,
    input wire         rst,
    input wire         enable,
    input wire  [4:0]  rs1,
    input wire  [4:0]  rs2,
    input wire  [4:0]  rd,
    input wire  [31:0] data,

    output wire [31:0] op1,
    output wire [31:0] op2
);

    integer i;

    reg [31:0] registers [31:1];

    always @(posedge clk or negedge rst ) begin
        if(!rst)begin
            for (i=1; i<=31; i++)begin
                registers[i] <= 0;
            end 
        end
        else if(enable && |rd) begin    
            registers[rd] <= data;
        end    
    end

    assign op1 = (rs1 != 0) ? registers[rs1] : 32'b0;
    assign op2 = (rs2 != 0) ? registers[rs2] : 32'b0;
endmodule