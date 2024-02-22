module byte_access (
    input wire        clk,
    input wire        load,   
    input wire        store,   
    input wire [1:0]  byte_address,
    input wire [2:0]  func3,
    input wire [31:0] data_inL,
    input wire [31:0] data_inS,

    output reg [31:0] byte_accessL,
    output reg [31:0] byte_accessS,
    output reg [3:0]  masking
);

    always @(*) begin
        if(load)begin
            if  (func3 == 3'b000)begin                                           //byte
                case (byte_address)
                    2'b00 :  byte_accessL = {{24{data_inL[7]}},data_inL[7:0]};
                    2'b01 :  byte_accessL = {{24{data_inL[15]}},data_inL[15:8]};
                    2'b10 :  byte_accessL = {{24{data_inL[23]}},data_inL[23:16]};
                    default: byte_accessL = {{24{data_inL[31]}},data_inL[31:24]};
                endcase
            end
            else if (func3 == 3'b001)begin                                     //halfword
                case (byte_address)
                    2'b00 :   byte_accessL = {{16{data_inL[15]}},data_inL[15:0]};
                    2'b01 :   byte_accessL = {{16{data_inL[23]}},data_inL[23:8]};
                    default:  byte_accessL = {{16{data_inL[31]}},data_inL[31:16]};                                                                                                                                                                                                                                                                                                                                                         
                endcase
            end
            else if (func3==3'b010)begin                                       //word
                byte_accessL = data_inL;
            end
            else if(func3==3'b100)begin                                       //byte unsigned
                case (byte_address)
                    2'b00 :  byte_accessL = {24'b0,data_inL[7:0]};
                    2'b01 :  byte_accessL = {24'b0,data_inL[15:8]};
                    2'b10 :  byte_accessL = {24'b0,data_inL[23:16]};
                    default: byte_accessL = {24'b0,data_inL[31:24]};
                endcase
            end
            else if(func3==3'b101)begin                                       //half word unsigned
                case (byte_address)
                    2'b00 :  byte_accessL = {16'b0,data_inL[15:0]};
                    2'b01 :  byte_accessL = {16'b0,data_inL[23:8]};
                    default: byte_accessL = {16'b0,data_inL[31:16]};                                                                                                                                                                                                                                                                                                                                                          
                endcase
            end
        end
        if(store)begin
            if(func3==3'b000)begin                                      //byte
               case (byte_address)
                    2'b00: begin
                        masking = 4'b0001;
                        byte_accessS = data_inS;
                    end
                    2'b01: begin
                        masking = 4'b0010;
                        byte_accessS = {data_inS[31:16],data_inS[7:0],data_inS[7:0]};
                    end
                    2'b10: begin
                        masking = 4'b0100;
                        byte_accessS = {data_inS[31:24],data_inS[7:0],data_inS[15:0]};
                    end
                    default : begin // 2'b11
                        masking = 4'b1000;
                        byte_accessS = {data_inS[7:0],data_inS[23:0]};
                    end
                endcase 
            end
            else if(func3==3'b001)begin                                        //halfword
                    case (byte_address)
                        2'b00: begin
                            masking = 4'b0011;
                            byte_accessS = data_inS;
                        end
                        2'b01: begin
                            masking = 4'b0110;
                            byte_accessS = {data_inS[31:24],data_inS[15:0],data_inS[7:0]};
                        end
                        default:begin //2'b10
                            masking = 4'b1100;
                            byte_accessS = {data_inS[15:0],data_inS[15:0]};
                        end
                    endcase   
            end
            else if(func3==3'b010) begin                                        //word
                masking = 4'b1111;
                byte_accessS = data_inS;
            end
        end
    end
endmodule