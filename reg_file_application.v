`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 03:10:42 PM
// Design Name: 
// Module Name: reg_file_application
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


module reg_file_application
#(parameter N=7,BITS=4)
    (
    input[BITS-1:0] data_w,
    input read_write,
    input [N-1:0]SW ,
    input WE, clk,
    output [6:0]sseg,
    output [7:0] AN
    );
    
    wire[BITS-1:0] data_r;
    wire [N-1:0] address;
    wire button;
    
    assign address = read_write ? SW[6:0]:7'bz;
    
    button but (
        .clk(clk),
        .in(WE),
        .out(button)
        );
        
    reg_file #(.N(N), .BITS(BITS)) regapp (
        .address_w(read_write ? 7'bz : SW[6:0]),
        .address_r(read_write ? SW[6:0]:7'bz),
        .data_w(data_w),
        .WE(button),
        .clk(clk),
        .data_r(data_r)
        );
    
    hex2sseg h2ss_inst (
        .hex(data_r),     // Connect data_r to the hex input
        .sseg(sseg)        // Connect seven-segment display output
    );    
    
     assign AN = 8'b11111110;
endmodule
