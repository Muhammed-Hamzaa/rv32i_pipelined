module branch (
   input wire        clk,
   input wire        branch,
   input wire [31:0] op1,
   input wire [31:0] op2,
   input wire [2:0]  fun3,
   
   output reg        branch_out
);

   always @(*) begin
      if(branch)begin
         case (fun3)
            3'b000 : branch_out = ($signed(op1) == $signed(op2)) ? 1 : 0 ;                //beq
            3'b001 : branch_out = ($signed(op1) != $signed(op2)) ? 1 : 0 ;                //bne
            3'b100 : branch_out = ($signed(op1) < $signed(op2)) ? 1 : 0 ;                 //blt
            3'b101 : branch_out = ($signed(op1) >= $signed(op2)) ? 1 : 0 ;                //bge
            3'b110 : branch_out = (op1 < op2) ? 1 : 0 ;                                   //bltu  
            3'b111 : branch_out = (op1 >= op2) ? 1 : 0 ;                                  //bgeu
            default : branch_out = 0;
         endcase
      end
      else if(!branch) begin
         branch_out=0;
      end
   end   
endmodule