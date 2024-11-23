`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 12:54:55 PM
// Design Name: 
// Module Name: reg_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_file #(parameter N=4,BITS = 4)(
    input [N-1:0]address_w, address_r,
    input [BITS-1:0] data_w,
    input WE,clk,
    output [BITS-1:0] data_r
    );
    wire [2**N-1:0]wport_dec;
    wire [2**N-1:0]rport_dec;
    wire [BITS-1:0] regloadout;
    wire [BITS-1:0] out[2**N-1:0];
    decoder_generic #(.N(N)) writeport (
        .w(address_w),
        .en(WE),
        .y(wport_dec)
    );
    
    decoder_generic #(.N(N)) readport (
        .w(address_r),
        .en(1'b1),
        .y(rport_dec)
    );
   
    genvar i;
    generate
    
    for(i = 0; i < 2**N; i = i +1) 
    begin: reg_gen
    simple_register_load #(.N(BITS)) regi
        (
            .clk(clk),
            .load(wport_dec[i]),
            .I(data_w),
            .Q(out[i])
        );  
        assign data_r = (rport_dec[i]) ? out[i] : 4'bz; //select should be rport_dec
    end
    endgenerate
    
        
endmodule
