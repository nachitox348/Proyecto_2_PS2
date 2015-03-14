`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:01:14 03/10/2015 
// Design Name: 
// Module Name:    Capturador_de_Datos 
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
module Capturador_de_Datos(
    input [7:0] Dato,
    input Tick,
	 input rst,
	 input clk,
    output active,
    output [4:0] Temp,
    output Presencia,
    output Carro
    );

wire Yes;
wire Veri_Si;
wire [3:0] REG;
wire [7:0]C_Decenas;
wire [7:0]C_Unidades;
wire [7:0]C_Presencia;
wire [7:0]C_Ignicion;

 Modulo_Activador Activacion (
    .dato(Dato),
	 .tick(Tick),
	 .rst(rst),
    .Inicio_Tomadatos(Yes)
    );

 Validador_Caracter Validacion (
	 .rst(rst),
    .dato(Dato),
    .tick(Tick),
    .Verificador_C(Veri_Si)
	);
	
 Control_Recibir Control (
    .rst(rst),
    .clk(clk),
    .cod_verificado(Veri_Si),
    .inicio_datos(Yes),
    .active(active),
    .registros (REG)
	 );
 
 Reg_DatosListos Registro_Dec (
    .dato(Dato),
	 .EN(REG[0]),
    .clk(clk),
	 .rst(rst),
	 .dato_out(C_Decenas)
   );
	
 Reg_DatosListos Registro_Uni (
    .dato(Dato),
	 .EN(REG[1]),
    .clk(clk),
	 .rst(rst),
	 .dato_out(C_Unidades)
   );

 Reg_DatosListos Registro_Pre (
    .dato(Dato),
	 .EN(REG[2]),
    .clk(clk),
	 .rst(rst),
	 .dato_out(C_Presencia)
   );
	
 Reg_DatosListos Registro_Ign (
    .dato(Dato),
	 .EN(REG[3]),
    .clk(clk),
	 .rst(rst),
	 .dato_out(C_Ignicion)
   );
	
 Decodificador_Datos Salidas(
	 .rst(rst),
    .decenas(C_Decenas),
    .unidades(C_Unidades),
    .presencia(C_Presencia),
    .ignicion(C_Ignicion),
    .Temp(Temp),
    .Pres(Presencia),
    .Carro(Carro)
	 );
	 
endmodule
