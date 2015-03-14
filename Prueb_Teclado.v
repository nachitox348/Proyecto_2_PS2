`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:42:48 03/09/2015 
// Design Name: 
// Module Name:    Prueb_Teclado 
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
module Recuperador_Ps2(
		input wire clk,
		input wire rst,
		input wire ps2d,
		input wire ps2c,
		input wire EN,
		output wire [7:0] code,
		output wire correct,
		output wire tick
    );

wire tick_done;
wire tick_data;
wire [7:0] dato; 

assign tick=tick_data;

Get_Code_Mod Toma_Dato (
    .clk(clk), 
    .rst(rst), 
    .code(dato), 
    .tick_done(tick_done), 
    .tick_data(tick_data)
    );

Protocolo_PS2 Protocolo (
    .clk(clk), 
    .rst(rst), 
    .data_in(ps2d), 
    .ps2_c(ps2c), 
    .EN(EN), 
    .done_tick(tick_done), 
    .data_out(dato), 
    .correct(correct)
    );

Reg_Data Registro_Datos (
    .dato(dato), 
    .EN(tick_data), 
    .clk(clk), 
    .rst(rst), 
    .dato_out(code)
    );
endmodule
