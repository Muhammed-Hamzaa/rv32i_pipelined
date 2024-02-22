module cu (
    input wire         clk,
    input wire         r_type,
    input wire         i_type, 
    input wire         store,  
    input wire         load, 
    input wire         branch,  
    input wire         jal,  
    input wire         jalr,  
    input wire         lui,  
    input wire         auipc,  
    input wire  [31:0] instr,
    
    output wire        func7,
    output reg         reg_write,
    output reg  [3:0]  alu_ctrl,
    output reg  [2:0]  imm_sel,
    output wire [2:0]  func3
);

    assign func3 = instr[14:12];
    assign func7 = instr[30];

    always@(*)begin
        reg_write = 0;
        imm_sel = 3'b000;
        alu_ctrl = 4'b0000;
        if (r_type )begin                                                  //R type
            reg_write = 1;
            if(func3==3'b000 & func7==0)begin
                alu_ctrl = 4'b0000;
            end
            else if(func3==3'b001 & func7==0)begin
                alu_ctrl = 4'b0001;
            end
            else if(func3==3'b010 & func7==0)begin
                alu_ctrl = 4'b0010;
            end
            else if(func3==3'b011 & func7==0)begin
                alu_ctrl = 4'b0011;
            end
            else if(func3==3'b100 & func7==0)begin
                alu_ctrl = 4'b0100;
            end
            else if(func3==3'b101 & func7==0)begin
                alu_ctrl = 4'b0101;
            end
            else if(func3==3'b101 & func7==1)begin
                alu_ctrl = 4'b0110;
            end
            else if(func3==3'b110 & func7==0)begin
                alu_ctrl = 4'b0111;
            end
            else if(func3==3'b111 & func7==0)begin
                alu_ctrl = 4'b1000;
            end
            else if(func3==3'b000 & func7==1)begin
                alu_ctrl = 4'b1001;
            end
        end
        else if (i_type)begin                                                //I type
            reg_write = 1;
            imm_sel = 3'b001;
            if(func3==3'b000 & func7==0)begin
                alu_ctrl = 4'b0000;
            end
            else if(func3==3'b001 & func7==0)begin
                alu_ctrl = 4'b0001;
            end
            else if(func3==3'b010 & func7==0)begin
                alu_ctrl = 4'b0010;
            end
            else if(func3==3'b011 & func7==0)begin
                alu_ctrl = 4'b0011;
            end
            else if(func3==3'b100 & func7==0)begin
                alu_ctrl = 4'b0100;
            end
            else if(func3==3'b101 & func7==0)begin
                alu_ctrl = 4'b0101;
            end
            else if(func3==3'b101 & func7==1)begin
                alu_ctrl = 4'b0110;
            end
            else if(func3==3'b110 & func7==0)begin
                alu_ctrl = 4'b0111;
            end
            else if(func3==3'b111 & func7==0)begin
                alu_ctrl = 4'b1000;
            end
        end
        else if (store) begin                                                 //store
            imm_sel = 3'b010;
            if (func3==3'b000) begin       //byte
                alu_ctrl = 4'b0000;
            end
            else if (func3==3'b001) begin  //halfword
                alu_ctrl = 4'b0000;
            end
            else if (func3==3'b010) begin  //word
                    alu_ctrl = 4'b0000;
            end
        end
        else if (load) begin                                                  //load
            reg_write = 1;
            imm_sel = 3'b001;
            if (func3==3'b000) begin       //byte
                alu_ctrl = 4'b0000;
            end
            else if (func3==3'b001) begin  //halfword
                alu_ctrl = 4'b0000;
            end
            else if (func3==3'b010) begin  //word
                alu_ctrl = 4'b0000;
            end
            else if (func3==3'b100) begin  //byte unsigned
                alu_ctrl = 4'b0000;
            end
            else if (func3==3'b101) begin  //half word unsigned
                alu_ctrl = 4'b0000;
            end
        end
        else if (branch)begin                                                  //branch selection
            imm_sel = 3'b011;
            alu_ctrl = 4'b0000;
        end
        else if (jalr)begin                                                    //jump and link register
            reg_write = 1;
            imm_sel = 3'b001;
            alu_ctrl = 4'b0000;
        end
        else if (jal)begin                                                     //jump and link
            reg_write = 1;
            imm_sel = 3'b100;
            alu_ctrl = 4'b0000;    
        end
        else if (lui)begin                                                     //load upper immediate
            reg_write = 1;
            imm_sel = 3'b101;
            alu_ctrl = 4'b0000;    
        end
        else if (auipc)begin                                                   //add upper immediate to pc
            reg_write = 1;
            imm_sel = 3'b101;
            alu_ctrl = 4'b0000;    
        end
    end
endmodule