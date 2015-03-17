`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña
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
//Sistema principal para la prevención de hipertermia
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

//Declaración de señales internas del sistema
//wire clk_control; //señal de reloj para el control del sistema principal
wire clk_mod; // señal del reloj del controlador del display de 7 segmentos
wire in_flag; //Activador del registro de entrada
wire out_flag; //Activador del registro de salida
//wire [1:0] state; //Señal que determina el estado actual del sistema
wire [4:0] T; //Señal de salida del registro de temperatura
wire P; //Señal de salida del registro de Presencia
wire C; //Señal de salida del registro de Ignicion del carro
wire [1:0] log; //Señal de salida del modulo de logica, entrada del registro de salida
wire [4:0] Uni; //Señal de unidades de la temperatura decodificada
wire [1:0] Dec; //Señal de decenas de la temperatura decodificada 

//assign big_clk=clk_control;

//Instanciación de la maquina de estados del sistema (control)
FMS_Control Control (.act_0(active),
	.clk(clk), //originalmete clk_control
	.rst(m_rst),
	.EN_out(out_flag),
	.EN_in(in_flag)
	//.Est(state)
	);

//Instanciación del registro de entradas 
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

//Instanciación del modulo de logica del sistema
Modulo_Logica Logica (.Tempe(T[4:2]),
	.Carro(C),
	.Presencia(P),
	.Salida(log)
	);
	
//Instanciación del registro de salida
Reg_Out Salidas (.LOG(log),
	.EN(out_flag),
	.rst(m_rst),
	.clk(clk),
	.out(Alarm_Vent)
	);

//Instanciación del modulo decodificador de decenas y unidades de la temperatura
Uni_Dec BCD (.temp(T),
	.Uni(Uni),
	.Dec(Dec)
	);

//Instanciación del controlador del display de 7 segmentos
FMS_Display Display (
    .clk(clk_mod), 
    .rst(m_rst),
	 .est(Alarm_Vent),  //originalmente state
    .uni(Uni), 
    .dec(Dec), 
    .anodo(Anodos), 
    .catodo(Catodos)
    );

//Instanciación del modulo del divisor del reloj interno del FPGA
Clock_Contador CLOCK_modif (
    .clk(clk), 
    .rst(m_rst), 
    .clk_mod(clk_mod)
	 //.clk_control(clk_control)
    );

endmodule
