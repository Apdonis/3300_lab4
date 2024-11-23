`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2024 02:22:26 PM
// Design Name: 
// Module Name: accumulator
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


module accumulator #(parameter n = 4)(
    input [n-1:0] x,
    input sel,rst,
    input clk,
    input load,
    output [6:0] sseg,
    output reg [7:0] AN
    );
    
    wire [3:0] qin;
    wire [3:0] D;
    wire [3:0] q;
    button but (
        .clk(clk),
        .in(load),
        .out(load_o)
        );
        
    adder_subtractor #(.n(n)) addsub (
        .x(qin),
        .y(x),
        .add_n(sel),
        .s(D),
        .c_out()
        );
    
    simple_register_load #(.N(n)) regi (
        .clk(clk),
        .reset(rst),
        .load(load_o),
        .I(D),
        .Q(q)
        );
    
    assign qin = q; 
    
    hex2sseg h2ss_inst (
        .hex(q),     // Connect data_r to the hex input
        .sseg(sseg)        // Connect seven-segment display output
    );   
    
    always @(posedge clk) begin
            if (!rst) begin 
                AN <= 8'b11111111;
            end else begin
                AN <= 8'b11111110;
            end
        end
endmodule
