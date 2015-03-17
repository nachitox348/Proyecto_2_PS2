`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña
// 
// Create Date:    21:02:31 03/07/2015 
// Design Name: 
// Module Name:    Get_Code_Mod 
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
//	Maquina de estados que me indica cuando tengo que leer el dato que me envia el teclado despues de pasar por el codigo de ruptura F0
module Get_Code_Mod(
    input wire clk, rst,
	 input wire [7:0] code, //Código de la tecla que se accionó o código de ruptura
	 input wire tick_done, //Bandera del modulo PS2 que indica que el dato esta listo
	 output reg tick_data //Bandera de salida que me indica que se debe tomar el dato siguiente
	 );
	 
localparam brk = 8'hf0; //Codigo de ruptura
//Declaración de estados de la maquina
localparam wait_brk = 1'b0, //Estado de espera de captación de codigo de ruptura  
			  get_code = 1'b1; //Estado de captación del codigo de la tecla correspondiente

//Señales para el registro de estados
reg act_state, next_state; 

//FMS
//Actualización de registro de estados
always @ (posedge clk, posedge rst)
	if (rst) //Resetea los valores de los registros para inicializar el sistema
		act_state <= wait_brk;
	else //Actualiza el estado actual con el declarado en el ciclo anterior
		act_state <= next_state;

//Logica de estado siguiente
always @ *
begin 
//Asigna los valores por defecto de la salida y el estado siguiente
	tick_data = 1'b0; 
	next_state = act_state;
	case (act_state) //Analiza el estado actual
		wait_brk: //Estado en que se analiza el codigo de ruptura
			if (tick_done == 1'b1 && code == brk) //Si se carga un codigo y este es el de ruptura entonces pase al estado get_code para tomar el dato correcto 
				next_state = get_code;
		get_code: //Analiza el estado get_code (tomar codigo de tecla) 
			if (tick_done) // Si el dato se cargo correctamente envie una bandera para tomar el dato y pase al estado de espera
				begin
					tick_data = 1'b1; //Bandera de que el dato que ocupo esta listo
					next_state = wait_brk;
				end
	endcase
end

endmodule
