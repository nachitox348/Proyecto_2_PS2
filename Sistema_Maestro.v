`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fern�ndez Garita, Daniel Zamora Uma�a
// 
// Create Date:    15:42:41 02/24/2015 
// Design Name: 	
// Module Name:    Sistema_Maestro 
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
//Sistema principal para la prevenci�n de hipertermia
module Sistema_Maestro(input wire [4:0] Temp,
		input wire Pres,
		input wire Carro,
		input wire clk,
		input wire m_rst,
		input wire active,
		output [1:0] Alarm_Vent,
		output [7:0] Catodos,
		output [3:0] Anodos
		//output big_clk
    );

//Declaraci�n de se�ales internas del sistema
//wire clk_control; //se�al de reloj para el control del sistema principal
wire clk_mod; // se�al del reloj del controlador del display de 7 segmentos
wire in_flag; //Activador del registro de entrada
wire out_flag; //Activador del registro de salida
//wire [1:0] state; //Se�al que determina el estado actual del sistema
wire [4:0] T; //Se�al de salida del registro de temperatura
wire P; //Se�al de salida del registro de Presencia
wire C; //Se�al de salida del registro de Ignicion del carro
wire [1:0] log; //Se�al de salida del modulo de logica, entrada del registro de salida
wire [4:0] Uni; //Se�al de unidades de la temperatura decodificada
wire [1:0] Dec; //Se�al de decenas de la temperatura decodificada 

//assign big_clk=clk_control;

//Instanciaci�n de la maquina de estados del sistema (control)
FMS_Control Control (.act_0(active),
	.clk(clk), //originalmete clk_control
	.rst(m_rst),
	.EN_out(out_flag),
	.EN_in(in_flag)
	//.Est(state)
	);

//Instanciaci�n del registro de entradas 
Reg_In Entradas (.T(Temp),
	.C(Carro),
	.P(Pres),
	.EN(in_flag),
	.rst(m_rst),
	.clk(clk),
	.Temp(T),
	.Ca(C),
	.Pre(P)
	);

//Instanciaci�n del modulo de logica del sistema
Modulo_Logica Logica (.Tempe(T[4:2]),
	.Carro(C),
	.Presencia(P),
	.Salida(log)
	);
	
//Instanciaci�n del registro de salida
Reg_Out Salidas (.LOG(log),
	.EN(out_flag),
	.rst(m_rst),
	.clk(clk),
	.out(Alarm_Vent)
	);

//Instanciaci�n del modulo decodificador de decenas y unidades de la temperatura
Uni_Dec BCD (.temp(T),
	.Uni(Uni),
	.Dec(Dec)
	);

//Instanciaci�n del controlador del display de 7 segmentos
FMS_Display Display (
    .clk(clk_mod), 
    .rst(m_rst),
	 .est(Alarm_Vent),  //originalmente state
    .uni(Uni), 
    .dec(Dec), 
    .anodo(Anodos), 
    .catodo(Catodos)
    );

//Instanciaci�n del modulo del divisor del reloj interno del FPGA
Clock_Contador CLOCK_modif (
    .clk(clk), 
    .rst(m_rst), 
    .clk_mod(clk_mod)
	 //.clk_control(clk_control)
    );

endmodule
