`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:12:04 03/08/2015 
// Design Name: 
// Module Name:    Reg_Data 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Reg_Data(
		input wire [7:0] dato,
		input wire EN,
		input wire clk,
		input wire rst,
		output reg [7:0] dato_out
    );

always @ (posedge clk, posedge rst)
	if (rst)
		dato_out <= 8'b0;
	else if (EN)
		dato_out <= dato;

endmodule
