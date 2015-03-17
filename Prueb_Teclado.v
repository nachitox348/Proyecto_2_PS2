`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña
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
//Envia el codigo real de la tecla filtrando el codigo de ruptura 
module Recuperador_Ps2(
		input clk,
		input rst,
		input ps2d, //Datos en serial del codigo de la tecla enviada por el teclado
		input ps2c, //Dato del clock de envio del teclado
		input EN, //Habilitador del sistema
		output [7:0] dato, //Dato de salida del codigo de teclado necesario (sin codigo de ruptura)
		output correct,
		output tick //Dato de salida que indica que el dato correcto esta listo
    );

wire tick_done; //tick o señal enviada por el modulo receptor del ps2 para indicar que el dato esta listo
wire tick_data; //señal enviada por el modulo de filtro de codigo de ruptura que indica que el dato correcto esta listo
//wire [7:0] dato; 

assign tick=tick_data; //Asignacion de la bandera de dato listo

//Instaciación el modulo de filtro de codigo de ruptura
Get_Code_Mod Toma_Dato (
    .clk(clk), 
    .rst(rst), 
    .code(dato), 
    .tick_done(tick_done), 
    .tick_data(tick_data)
    );

//Instanciación del modulo de recepción de datos del teclado por protoolo ps2
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

//Reg_Data instance_name (
  //  .dato(dato), 
    //.EN(tick_data), 
    //.clk(clk), 
    //.rst(rst), 
    //.dato_out(code)
    //);
endmodule
