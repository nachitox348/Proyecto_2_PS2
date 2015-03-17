`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña
// 
// Create Date:    20:16:16 02/23/2015 
// Design Name: 	
// Module Name:    FMS_Control 
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
//Control principal, sincroniza las señales de esntrada y las señales de salida
module FMS_Control(input wire act_0,
		input wire clk,
		input wire rst, 
		output wire EN_out, //Habilitador de salidas
		output wire EN_in //Hablilitador de datos de entrada
		//output reg [1:0] Est //Bandera que indica el estado actual de la maquina de estados
		//Eliminada debido a que por la velocidad a la que corre la maquina es imposible vizualizar en el 7 segmentos
    );

//Declaración simbolica de estados
localparam State_0 = 2'd0, 
			  State_1 = 2'd1, 
			  State_2 = 2'd2,
			  State_3 = 2'd3;

//Variables de registro de estados actual y siguiente
reg [1:0] Est_act;
reg [1:0] Est_sig;

//Salidas
assign EN_out = (Est_act == State_3);
assign EN_in = (Est_act == State_1);

//Bloque donde se declaraba la salida de estado actual de la maquina
//always @ *
//begin
	//Est = 2'b00;
	//case (Est_act)
		//State_1: begin Est = 2'b01; end
		//State_2: begin Est = 2'b10; end
		//State_3: begin Est = 2'b11; end
	//endcase
//end

//Fin de declaracion de salidas

//Porceso de la maquina

//Actualización de estado
always @ (posedge clk or posedge rst)
begin
	if (rst) Est_act <= State_0;
	else Est_act <= Est_sig;
end

//Declaraciones de Estado siguiente

always @ *
begin
	Est_sig = Est_act;
	case (Est_act)
	
		State_0: begin 
			if (act_0) Est_sig = State_1; //Si el enable del sistema (act_0) esta activo comienza a correr la maquina
		end
		
		State_1: begin
			 Est_sig = State_2;
		end
		
		State_2: begin
			Est_sig = State_3;
		end
		
		State_3: begin Est_sig = State_0; end //Una vez terminado el ciclo de control de entradas y salidas se devuelve al estado de habilitación

	endcase
end

endmodule
