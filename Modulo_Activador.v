`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:17 03/10/2015 
// Design Name: 
// Module Name:    Modulo_Activador 
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
module Modulo_Activador(
    input wire [7:0] dato,
	 input wire tick,
	 input wire rst,
    output wire Inicio_Tomadatos
    );

reg Salida;
always @ *
	if (rst)
		Salida = 1'b0;
	else if (tick) 
		Salida =(dato==8'b00011101) ? 1'b1 : 1'b0;
	else 
		Salida = 1'b0;
assign Inicio_Tomadatos = Salida;	


endmodule
