`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña 
// 
// Create Date:    20:56:03 03/10/2015 
// Design Name: 
// Module Name:    Reg_DatosListos 
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
//Registro de codigos del teclado
module Reg_DatosListos(
		input wire [7:0] dato, //Dato del teclado
		input wire EN,
		input wire clk,
		input wire rst,
		output reg [7:0] dato_out //Dato guardado
    );

always @ (posedge clk, posedge rst)
	if (rst)
		dato_out <= 8'b0;
	else if (EN)
		dato_out <= dato;

endmodule
