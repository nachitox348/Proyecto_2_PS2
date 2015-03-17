`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fern�ndez Garita, Daniel Zamora Uma�a 
// 
// Create Date:    09:38:54 03/14/2015 
// Design Name: 
// Module Name:    Digitales2_TopMod 
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
//Modulo final donde se enlaza el sistema de prevenci�n (Proyecto 1) y el m�dulo de recepci�n y tratamiento de datos del teclado
module Digitales2_TopMod(
		input clk, rst, EN, //Entradas de control
		input ps2d, ps2c, //Entradas de teclado datos y clock
		output correct,
		output [1:0] Alarma_Vent, //Salida del sistema
		output [7:0] Catodos, //Salidad del codigo de los cadotos del display de 7 segmentos
		output [3:0] Anodos // Salida de los anodeo del display
    );

wire tick; //sen�al de bandera de dato del teclado listo
wire [7:0] Dato; //se�al del codigo correcto de la tecla

//Instanciaci�n del modulo de enalce entre la decodificaci�n de datos entrantes del teclado y el Proyecto 1
Proyecto_2 Enlace_P1_P2 (
    .Dato(Dato), 
    .Tick(tick), 
    .clk(clk), 
    .rst(rst), 
    .Alarma_Vent(Alarma_Vent), 
    .Catodos(Catodos), 
    .Anodos(Anodos)
    );

//Modulo de recepci�n de datos del teclado con filtro de c�digo de ruptura	 
Recuperador_Ps2 Datos_Teclado (
    .clk(clk), 
    .rst(rst), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .EN(EN), 
    .dato(Dato), 
    .correct(correct),
	 .tick(tick)
    );

endmodule
