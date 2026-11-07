`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Madeline and Guranaad
//////////////////////////////////////////////////////////////////////////////////


module sequential_mult(a, b, rst, clk, product);
    input rst;
    input clk;
    input [3:0] a;
    input [3:0] b;
    output reg [7:0] product;
    
    parameter S0_idle = 0, S1_multiply = 1, S2_update_result = 2, S3_done= 3;
    reg [3:0] shift_count;
    reg [7:0] partial_product;
    reg [3:0] operand_bb;
    reg [7:0] multiplicand;
    
    reg [2:0] PS, NS;
    
    always @(posedge clk)
        begin
        if(rst)
            PS <= S0_idle;// when reset=1, reset the PS of the FSM to "S0" PS
        else
            PS <= NS; // otherwise, next PS
    end
    
    //combinational ns
    always @(*)
        begin
        case(PS)
            S0_idle: NS= S1_multiply;
            S1_multiply: NS= S2_update_result;
            S2_update_result: NS = (shift_count < 4) ? S1_multiply : S3_done;
            S3_done: NS= S0_idle;
            default: NS= S0_idle;
         endcase
            
    end
    
    
    
    
    always@ (posedge clk) 
        begin
            case (PS)
                S0_idle:begin
                    partial_product <= 0;
                    shift_count <= 0;
                    multiplicand <= {4'b0000, a};
                    operand_bb <= b;    
                    product <= 0;        
                end
                
                S1_multiply: begin
                        if (operand_bb[0]==0) begin
                            partial_product <= partial_product;
                            shift_count <= shift_count +1;
                            multiplicand <= multiplicand << 1;
                            operand_bb <= operand_bb >> 1;
                        end 
                        else if (operand_bb[0]==1) begin 
                            partial_product <= partial_product + multiplicand;
                            shift_count <= shift_count +1;
                            multiplicand <= multiplicand << 1;
                            operand_bb <= operand_bb >> 1;
                        end

                    end

                    S2_update_result:begin
                        product <= partial_product;
                    end
                    
                    S3_done:begin 
                        end
                    endcase
                end
endmodule
