`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña 
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
//Modulo que evalua la tecla de inicio
module Modulo_Activador(
    input wire [7:0] dato, //Dato del teclado
	 input wire tick, //Badndera de dato listo 
	 input wire rst,
    output wire Inicio_Tomadatos //Bandera de activacion de lectura de datos
    );

reg Salida; //Señal de registro

always @ *
	if (rst)
		Salida = 1'b0;
	else if (tick) 
		Salida =(dato==8'b00011101) ? 1'b1 : 1'b0; //Asignación condicional de si la tecla corresponde a la de inicio
	else 
		Salida = 1'b0;
		
assign Inicio_Tomadatos = Salida; //Asignación de la salida	

endmodule
