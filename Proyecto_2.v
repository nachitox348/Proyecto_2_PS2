`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fern�ndez Garita, Daniel Zamora Uma�a 
// 
// Create Date:    18:57:27 03/12/2015 
// Design Name: 
// Module Name:    Proyecto_2 
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
//Modulo de enlace entre el tratamiento de datos del teclado y el sistema de prevenci�n
module Proyecto_2(
    input wire [7:0] Dato , //Dato entrante y filtrado enviado por el teclado
    input wire Tick, //Se�al de bandera de dato listo
    input wire clk, 
    input wire rst,
    output [1:0] Alarma_Vent, //Salida del sistema 
    output [7:0] Catodos, //Salida de catodos
    output [3:0] Anodos //Salida de anodos
    );

wire C_Active; //Se�al que que habilita el sistema de prevenci�n
wire C_Presencia; //Dato que indica la presencia
wire C_Carro; //Dato que indica el estado de ignici�n del carro
wire [4:0] C_Temp; //Dato de temperatura
	
//Instanciaci�n del modulo de tratamiento y decodificaci�n de los datos del teclado	
Capturador_de_Datos Captador(
    .Dato(Dato),
    .Tick(Tick),
	 //.big_clk(big_clk),
	 .rst(rst),
	 .clk(clk),
    .active(C_Active),
    .Temp(C_Temp),
    .Presencia(C_Presencia),
    .Carro(C_Carro)
    );

//Instanciaci�n del sistema de prevenci�n contra hipertermia
Sistema_Maestro Proyecto_1(
		.Temp(C_Temp),
		.Pres(C_Presencia),
		.Carro(C_Carro),
		.clk(clk),
		.m_rst(rst),
		.active(C_Active),
		.Alarm_Vent(Alarma_Vent),
		.Catodos(Catodos),
		.Anodos(Anodos)
		//.big_clk(big_clk)
    );
endmodule
