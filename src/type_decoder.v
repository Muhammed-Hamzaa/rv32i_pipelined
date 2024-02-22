module type_decoder (
    input wire       clk,
    input wire       valid,
    input wire [6:0] opcode,
     
    output reg       r_type,
    output reg       i_type, 
    output reg       store,
    output reg       load,  
    output reg       branch,
    output reg       jalr,
    output reg       jal,
    output reg       auipc, 
    output reg       lui
    
);

    always @(*) begin
        case(opcode)
            7'b0110011:begin   // R type
                r_type <= 1'b1;
                i_type <= 1'b0;
                store<=1'b0;
                load <= 1'b0;
                branch<= 1'b0;
                jalr<= 1'b0;
                jal<= 1'b0;
                auipc<= 1'b0;
                lui<= 1'b0;
            end
            7'b0010011:begin  // I Type
                i_type = 1'b1;
                r_type <= 1'b0;
                store<=1'b0;
                load <= 1'b0;
                branch<= 1'b0;
                jalr<= 1'b0;
                jal<= 1'b0;
                auipc<= 1'b0;
                lui<= 1'b0;
            end
            7'b0100011:begin  // Store
                store<= 1'b1;
                r_type <= 1'b0;
                i_type <= 1'b0;
                load <= 1'b0;
                branch<= 1'b0;
                jalr<= 1'b0;
                jal<= 1'b0;
                auipc<= 1'b0;
                lui<= 1'b0;
            end
            7'b0000011:begin  // Load
                 if (valid) begin 
                    load = 1'b0;
                    r_type <= 1'b0;
                    i_type <= 1'b0;
                    store<=1'b0;
                    branch<= 1'b0;
                    jalr<= 1'b0;
                    jal<= 1'b0;
                    auipc<= 1'b0;
                    lui<= 1'b0;
                end
                else begin
                    load = 1'b1;
                    r_type <= 1'b0;
                    i_type <= 1'b0;
                    store<=1'b0;
                    branch<= 1'b0;
                    jalr<= 1'b0;
                    jal<= 1'b0;
                    auipc<= 1'b0;
                    lui<= 1'b0;
                end
            end
            7'b1100011:begin  // Branch
                branch<= 1'b1;
                r_type <= 1'b0;
                i_type <= 1'b0;
                load <= 1'b0;
                store<=1'b0;
                jalr<= 1'b0;
                jal<= 1'b0;
                auipc<= 1'b0;
                lui<= 1'b0;
              end
            7'b1100111:begin  // Jalr
                jalr<= 1'b1;
                r_type <= 1'b0;
                i_type <= 1'b0;
                load <= 1'b0;
                branch<= 1'b0;
                jal<= 1'b0;
                lui<= 1'b0;
                auipc<= 1'b0;
            end
            7'b1101111:begin  // JAL
                jal<= 1'b1;
                r_type <= 1'b0;
                i_type <= 1'b0;
                load <= 1'b0;
                jalr<= 1'b0;
                store<=1'b0;
                branch<= 1'b0;
                auipc<= 1'b0;
                lui<= 1'b0;
            end
            7'b0010111:begin  // AUIPC
                auipc<= 1'b1;
                r_type <= 1'b0;
                i_type <= 1'b0;
                load <= 1'b0;
                jalr<= 1'b0;
                store<=1'b0;
                branch<= 1'b0;
                lui<= 1'b0;
                jal<= 1'b0;
            end
            7'b0110111:begin  // LUI
                lui<= 1'b1;
                r_type <= 1'b0;
                i_type <= 1'b0;
                load <= 1'b0;
                jalr<= 1'b0;
                store<=1'b0;
                branch<= 1'b0;
                auipc<= 1'b0;
                jal<= 1'b0;
            end
            default: begin 
                r_type <= 1'b0;
                i_type <= 1'b0;
                load <= 1'b0;
                jalr<= 1'b0;
                store<=1'b0;
                branch<= 1'b0;
                auipc<= 1'b0;
                lui<= 1'b0;
                jal<= 1'b0;
            end
        endcase
    end 
endmodule