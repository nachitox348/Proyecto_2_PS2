`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:15:23 03/14/2015 
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
module Digitales2_TopMod(
		input clk, rst, EN,
		input ps2d, ps2c,
		output [1:0] Alarma_Vent,
		output [7:0] Catodos,
		output [3:0] Anodos,
		output correct
    );

wire tick;
wire [7:0] Dato;

Proyecto_2 Enlace_P1_P2 (
    .Dato(Dato), 
    .Tick(tick), 
    .clk(clk), 
    .rst(rst), 
    .Alarma_Vent(Alarma_Vent), 
    .Catodos(Catodos), 
    .Anodos(Anodos)
    );
	 
Recuperador_Ps2 Ps2_Module (
    .clk(clk), 
    .rst(rst), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .EN(EN), 
    .code(Dato), 
    .correct(correct), 
    .tick(tick)
    );

endmodule
