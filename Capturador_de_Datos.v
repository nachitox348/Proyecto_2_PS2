`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña 
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
//Modulo que maneja los datos de teclado y los decodifica para enviar la información al sistema del Proyeto 1
module Capturador_de_Datos(
    input [7:0] Dato, //Dato del teclado 
    input Tick, //Señal de dato listo y filtrado
	 //input big_clk,
	 input rst,
	 input clk,
    output active, //Salida de habilitación del sistema
    output [4:0] Temp, //Salida de la temperatura ingresada
    output Presencia, //Salida de presencia ingresada
    output Carro //Salida de estado de ignición del carro ingresada
    );

wire Yes; //Señal que indica que el sistema esta listo para tomar datos y guardarlos en registro
wire Veri_Si; //Señal que indica que el dato que se ingreso es correcto
wire [3:0] REG; //Señal de control de activación de los registros de datos 
wire [7:0]C_Decenas; //Registro de las decenas ingresadas 
wire [7:0]C_Unidades; //Registro de las unidades ingredas
wire [7:0]C_Presencia; //Registro de estado de la presencia ingresado
wire [7:0]C_Ignicion; //Registro de estado de ignición ingresado

//Instanciación del modulo de evaluación de tecla de inicio
 Modulo_Activador Activacion (
    .dato(Dato),
	 .tick(Tick),
	 .rst(rst),
    .Inicio_Tomadatos(Yes)
    );

//Instanciación del modulo de validación del caracter ingresado
 Validador_Caracter Validacion (
	 .rst(rst),
    .dato(Dato),
    .tick(Tick),
    .Verificador_C(Veri_Si)
	);

//Instanciación del control de datos recibidos y de registros de datos
 Control_Recibir Control (
    .rst(rst),
    .clk(clk),
	// .big_clk(big_clk),
    .cod_verificado(Veri_Si),
    .inicio_datos(Yes),
    .active(active),
    .registros (REG)
	 );
 
 //Registro de decenas
 Reg_DatosListos Registro_Dec (
    .dato(Dato),
	 .EN(REG[0]),
    .clk(clk),
	 .rst(rst),
	 .dato_out(C_Decenas)
   );

//Registro de unidades 
 Reg_DatosListos Registro_Uni (
    .dato(Dato),
	 .EN(REG[1]),
    .clk(clk),
	 .rst(rst),
	 .dato_out(C_Unidades)
   );

//Registro de presencia
 Reg_DatosListos Registro_Pre (
    .dato(Dato),
	 .EN(REG[2]),
    .clk(clk),
	 .rst(rst),
	 .dato_out(C_Presencia)
   );
	
//Registro de ignición 
 Reg_DatosListos Registro_Ign (
    .dato(Dato),
	 .EN(REG[3]),
    .clk(clk),
	 .rst(rst),
	 .dato_out(C_Ignicion)
   );
	
//Decodificador de datos para ser enviados al sistema
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
