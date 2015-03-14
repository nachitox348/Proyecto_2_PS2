`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
module Proyecto_2(
    input wire [7:0] Dato ,
    input wire Tick,
    input wire clk,
    input wire rst,
    output [1:0] Alarma_Vent,
    output [7:0] Catodos,
    output [3:0] Anodos,
	 output tick_ver
    );

wire C_Active;
wire C_Presencia;
wire C_Carro;
wire [4:0] C_Temp;
	 
Capturador_de_Datos Captador(
    .Dato(Dato),
    .Tick(Tick),
	 .rst(rst),
	 .clk(clk),
    .active(C_Active),
    .Temp(C_Temp),
    .Presencia(C_Presencia),
    .Carro(C_Carro),
	 .tick_ver(tick_ver)
    );

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
    );
endmodule
