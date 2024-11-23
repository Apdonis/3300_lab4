`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 02:03:04 PM
// Design Name: 
// Module Name: tri_state_buffer
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


module tri_state_buffer #(parameter  N = 4)(
    input [N-1:0] sel,
    input en,
    input [1:0] in,
    output [1:0] out 
);

    wire [2**N-1:0] en_dec;
    decoder_generic #(.N(N))
    (
        .w(sel),
        .en(en),
        .y(en_dec)
    );
    
    assign out = (en) ? in:2'bz;
endmodule
