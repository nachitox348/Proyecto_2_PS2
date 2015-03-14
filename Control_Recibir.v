`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:41 03/10/2015 
// Design Name: 
// Module Name:    Control_Recibir 
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
module Control_Recibir(
	 input wire rst,
    input wire clk,
    input wire cod_verificado,
    input wire inicio_datos,
    output reg active,
    output reg [3:0] registros
	 );

//Declaracin de estados de la maquina
localparam 
			  State_1 = 3'b000, 
			  State_2 = 3'b001, 
			  State_3 = 3'b010,
			  State_4 = 3'b011,
			  State_5 = 3'b100,
			  State_6 = 3'b110;
//Seales para el registro de estados
reg [2:0]act_state,next_state; 

//FMS
//Actualizacin de registro de estados
always @ (posedge clk, posedge rst)
	if (rst) //Resetea los valores de los registros para inicializar el sistema
		act_state <= State_1;
	else //Actualiza el estado actual con el declarado en el ciclo anterior
		act_state <= next_state;

//Logica de estado siguiente
always @ *
begin 
//Asigna los valores por defecto del estado siguiente
	next_state = act_state;
	case (act_state) 
		State_1: 
			if (inicio_datos==1'b1) 
				begin next_state = State_2; end
		State_2:  
			if (cod_verificado==1'b1) 
				begin next_state = State_3; end
		State_3:  
			if (cod_verificado==1'b1) 
				begin next_state = State_4; end
		State_4:  
			if (cod_verificado==1'b1)
				begin	next_state = State_5; end
		State_5:  
			if (cod_verificado==1'b1) 
				begin next_state = State_6; end	
		State_6:   
				begin next_state = State_1; end
	endcase
end

always @ *
	begin
		registros = 4'b0000;
		active = 1'b0;	
		case (act_state)
			State_1: begin 
				registros = 4'b0000;
				active = 1'b0;	
				end
			State_2: begin 
				registros = 4'b0001;
				active = 1'b0;	
				end
			State_3: begin 
				registros = 4'b0010;
				active = 1'b0;	
				end
			State_4: begin 
				registros = 4'b0100;
				active = 1'b0;	
				end
			State_5: begin 
				registros = 4'b1000;
				active = 1'b0;	
				end
			State_6: begin 
				registros = 4'b0000;
				active = 1'b1;	
				end
		endcase
	end



endmodule
