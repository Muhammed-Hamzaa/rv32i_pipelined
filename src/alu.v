module alu(
    input wire        clk,
    input wire [31:0] op1,
    input wire [31:0] op2,
    input wire [3:0]  alu_ctrl,
    
    output reg [31:0] out
);

    always @(*) begin
        case (alu_ctrl)
            4'b0000: out = $signed(op1) + $signed(op2);                         //add
            4'b0001: out = $signed(op1) << $signed(op2[4:0]);                   //shift left logical
            4'b0010: out = ($signed(op1) < $signed(op2)) ? 32'b1 : 32'b0;       //set less than
            4'b0011: out = (op1 < op2) ? 32'b1 : 32'b0;                         //set less then unsigned
            4'b0100: out = $signed(op1) ^ $signed(op2);                         //xor
            4'b0101: out = $signed(op1) >> $signed(op2[4:0]);                   //shift right logical
            4'b0110: out = $signed(op1) >>> $signed(op2[4:0]);                  //shift right arithematic
            4'b0111: out = $signed(op1) | $signed(op2);                         //or
            4'b1000: out = $signed(op1) & $signed(op2);                         //and
            4'b1001: out = $signed(op1) - $signed(op2);                         //sub
            default: out = 32'b0;
        endcase
    end
endmodule
