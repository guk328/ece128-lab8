`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Madeline and Guranaad
//////////////////////////////////////////////////////////////////////////////////


module sequential_mult_tb();
    reg rst;
    reg clk;
    reg [3:0] a;
    reg [3:0] b;
    wire [7:0] product;
    
    sequential_mult DUT(.rst(rst), .clk(clk), .a(a), .b(b), .product(product));
    
    always #10 clk = ~clk;
    initial 
        begin
            clk = 1'b0; rst = 1'b1; a = 4'b0110; b = 4'b0011; #20;
            
            rst = 1'b0; #80;
        end
    
    initial begin
        $dumpfile("dump.vcd"); //record waveform
        $dumpvars(1); //display signals in tb
    end
    
endmodule

