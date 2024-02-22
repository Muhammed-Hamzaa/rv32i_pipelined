`timescale 1ns/1ps
module top_tb();
    reg clk;
    reg rst;   
   
    top u_top(
        .clk(clk),
        .rst(rst)    
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("temp/top.vcd"); // Specify the VCD file name
        $dumpvars(0, top_tb); // Dump all variables
    end

    // Test input initialization and simulation
    initial begin
        clk = 1;
        rst=0;
        #5;
        rst=1;
        #250;
        // Finish simulation
        $finish;
    end
endmodule