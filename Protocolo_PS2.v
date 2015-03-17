`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña
// 
// Create Date:    11:39:37 03/07/2015 
// Design Name: 
// Module Name:    Protocolo_PS2 
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
module Protocolo_PS2(
		input wire clk, rst,
		input wire data_in, ps2_c, EN,
		output reg done_tick,
		output wire [7:0] data_out,
		output wire correct
    );
//Dlaración de estados para tomar los datos
localparam [1:0]
	idle = 2'b00,
	cuenta = 2'b01,
	load = 2'b10;

//Declaración de señales
reg [1:0] act_state, next_state; //Variables de estados del controlador
reg [7:0] filtro_act; //Regitro que analiza la variación del clock del teclado para detectar los flancos negativos
wire [7:0] filtro_next; //Variable que actualiza el estado del filtro actual analizando el valor del clock del teclado en un instante
reg ps2_act; //Registro que analiza y compara el filtro para detectar la variación entre valores altos y bajos del clock
wire ps2_next; //Variable que actualiza el registro de comparación ps2_act 
reg [3:0] cont_act, cont_next; //Registra la cantidad de datos que envia el teclado e india cuantos faltan por tomar
reg [10:0] bus_act, bus_next; //Registra los datos que que envia de faorma serial el teclado para almacenarlos y posteriormente enviarlos en paralelo, desempaqueta los datos
wire fall_edge; //Bandera que indica que hubo un cambio de flanco negativo del clock del teclado

//Cuerpo del modulo
//Fitro de detección de flancos negativos del clock del teclado 
always @ (posedge clk, posedge rst)
	if (rst) //Permite reiniciar el filtro poniendo los valores en 0
		begin
			filtro_act <= 8'b0;
			ps2_act <= 1'b0;
		end
	else //Actualiza los valores del filtro con los valores obtenido en el ciclo anterior
		begin
			filtro_act <= filtro_next;
			ps2_act <= ps2_next;
		end
		
assign filtro_next = {ps2_c, filtro_act[7:1]}; //Declara o actualiza el valor del filtro concatenando como bit mas significativo el valor leido atualmente en el clock teclado con los valores anteriormente leidos (los mas significativos)
//Acualiza la variable de bandera que permite detectar cambios de flanco negativo
assign ps2_next = (filtro_act == 8'hff) ? 1'b1 : //Si el clock se mantiene en alto la bandera me indica que esta en valores altos
						(filtro_act==8'h00) ? 1'b0 : //Si el clock se mantiene en bajo la bandera me indica que el clock esta en bajo con un 0
						ps2_act; //Si hay una transición se acualiza con el valor anterior de la bandera
assign fall_edge = ps2_act & ~(ps2_next); //Solo cuando el valor anterior del clock (indicado por la bandera ps2_act) y el valor actual sean 1 y 0 me indica que hubo un cambio de flanco negativo y me manda una bandera de que se detecto un cambio de flanco

//FMS
//Logica de estados y registro de datos 
always @ (posedge clk, posedge rst) 
	if(rst) //Reinicia los valores del sistema de la mquina de estados
		begin
			act_state <= idle;
			cont_act <= 4'b0;
			bus_act <= 11'b0;
		end
	else //Actualiza los valores de la maquina de estados con los actuales declarados en el ciclo anterior
		begin
			act_state <= next_state;
			cont_act <= cont_next;
			bus_act <= bus_next;
		end

//Logica de estado siguiente 
always @ * 
begin
	//Asigna los valores por defecto para las variables de estado del sistema
	next_state = act_state; 
	done_tick = 1'b0;
	cont_next = cont_act;
	bus_next = bus_act;
	case (act_state) //Analiza el estado actual
		idle: //Estado cero
			if (fall_edge && EN) //Si detectó un flanco negativo y el sistema esta actico (EN) procede de la siguiente manera
				begin
					bus_next = {data_in, bus_act[10:1]}; //Comienza a captar el primer dato del paquete del teclado (bit de inicio) y lo guarda en el bus de datos de registro desplazandolo a la derecha
					cont_next = 4'b1001; //Indica que la cantidad de valores que quedan por captar es de 10 (de 9 a 0), se le asigna 9
					next_state = cuenta; //Indica que el siguiente estado para esta condición sera el estado 01 (cuenta)
				end
		cuenta: //Estado de captación de los de mas datos (dato de la tecla, 8 bist, bit de paridad y bit de parada)
			if (fall_edge) //Si detecta un flaco negativo entonces
				begin
					bus_next = {data_in, bus_act[10:1]}; //Capta un nuevo dato despazando a la derecha los datos captados anteriormente
					if (cont_act==0) //Si la cantidad de datos a tomar es cero cambia de estado
						next_state = load;
					else //Si quedan datos por captar se mantiene en el estado de cuenta y reduce la cantidad de datos por captar en uno
						cont_next = cont_act - 1'b1; 
				end
		load: //Estado que indica que el dato esta listo
			begin
				next_state = idle; //Pasa al estado cero
				done_tick = 1'b1; //Se activa la bandera de que el dato esta listo
			end
		endcase
end

//Salida
assign data_out = bus_act [8:1]; //Asigna a la salida solo los datos que corresponden a el codigo de la tecla, suprime los bits de inicio, paridad y parada
assign correct = bus_act [0];

endmodule
