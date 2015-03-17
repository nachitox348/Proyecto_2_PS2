`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña 
// 
// Create Date:    21:50:43 02/23/2015 
// Design Name: 
// Module Name:    FMS_Display 
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
//Maquina de estados de control del display de 7 segmentos
module FMS_Display(input wire clk,
		input wire rst,
		input wire [1:0] est, //Salida del sistema que indica el estado del sistema
		input wire [4:0] uni, //Dato de unidades de temperatura
		input wire [1:0] dec, //Dato de decenas de la temperatura
		output reg [3:0] anodo, //Salida a los anodos del display
		output reg [7:0] catodo //Salida a los cátodos del display
		//output reg [1:0] sel 
    );

//Declaración simbolid¿ca de estados	 
localparam State_0 = 2'd0, 
			  State_1 = 2'd1, 
			  State_2 = 2'd2,
			  State_3 = 2'd3;

reg [1:0] Est_act;
reg [1:0] Est_sig;

//Salidas del sistema
always @ *
begin
	case (Est_act)
		State_0: begin
			anodo <= 4'b1110;
			case(est)      // en el primer display se despliega el estado en que se encuentra el sistema
			2'b00 : catodo = 8'b11000000; //Si el estado en de no peligro o alerta despliega un cero
			2'b01 : catodo = 8'b10001000; //Si el estado es de alerta despliega una A
			2'b10 : catodo = 8'b11110011; 
			2'b11 : catodo = 8'b10001100; //Si el estado es de peligro despliega una P
			default : catodo = 8'b11000000;
			endcase
		end
		State_1: begin //Segundo display se imprime un guión
			anodo <= 4'b1101;
			 catodo=8'b10111111;
		end
		
		State_2: begin //Evalua las unidades de temperatura y despliega el numero 
			anodo <= 4'b1011;
			case(uni)
			5'b0000 : catodo = 8'b11000000;
			5'b0001 : catodo = 8'b11111001;
			5'b0010 : catodo = 8'b10100100;
			5'b0011 : catodo = 8'b10110000;
			5'b0100 : catodo = 8'b10011001;
			5'b0101 : catodo = 8'b10010010;
			5'b0110 : catodo = 8'b10000010;
			5'b0111 : catodo = 8'b11111000;
			5'b1000 : catodo = 8'b10000000;
			5'b1001 : catodo = 8'b10010000;
			default : catodo = 8'b10000000;
			endcase
		end
		
		State_3: begin //Evalua las decenas de temperatura y despliega el numero 
			anodo <= 4'b0111;
			case(dec)
			2'b00 : catodo = 8'b10100100;
			2'b01 : catodo = 8'b10110000;
			2'b10 : catodo = 8'b10011001;
			2'b11 : catodo = 8'b10010010;
			endcase
		end
		
	endcase
end

//Actualización de estado
always @ (posedge clk or posedge rst)
begin
	if (rst) Est_act <= State_0;
	else Est_act <= Est_sig;
end

//Declaración de estado siguiente
always @ *
begin
	Est_sig = Est_act;
	case (Est_act)
	
		State_0: begin 
			Est_sig = State_1;
		end
		
		State_1: begin
			Est_sig = State_2;
		end
		
		State_2: begin
			Est_sig = State_3;
		end
		
		State_3: begin 
			Est_sig = State_0; 
		end

	endcase
end

endmodule


