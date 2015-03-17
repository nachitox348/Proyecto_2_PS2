`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fern·ndez Garita, Daniel Zamora UmaÒa 
// 
// Create Date:    10:36:05 02/21/2015 
// Design Name: 
// Module Name:    Modulo_Logica 
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
//Bloque de la lÛgica entrada-salida de desarrollo del sistema de alerta y prevenciÛn
module Modulo_Logica(
    input wire[4:2] Tempe,
    input wire Carro,
    input wire Presencia,
    output wire [1:0] Salida
    );
	 reg [1:0] C_S;
	 
	//body 
	always @ *      //se revisan todas las entradas
		if (Carro)     // revisa la variable carro, apaga el sistema si este esta encendido
			C_S = 2'B00;
		else if (!Presencia)  // revisa presencia, si es 0, apaga el sistema
			C_S=2'B00;
		else if(Tempe[4] | Tempe[3])  //revisa los bits mas significativos=>temperaturas peligrosas
			C_S = 2'B11;
		else if(Tempe[2])          //valida si encender alarma, con temperatura intermedia
			C_S = 2'B01;
		else 
			C_S = 2'B00;
		
	assign Salida = C_S; //conecta a la salida la se√±al
endmodule

