`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Madeline and Guranaad
//////////////////////////////////////////////////////////////////////////////////


module combinational_mult_tb();
    reg [3:0] a;
    reg [3:0] b;
    wire [7:0] p;
    
    combinational_mult DUT(.a(a), .b(b), .p(p));
    
    initial 
        begin
            a = 4'b0110; b = 4'b0011; #100;
        end
    
    initial begin
        $dumpfile("dump.vcd"); //record waveform
        $dumpvars(1); //display signals in tb
    end
    
endmodule

