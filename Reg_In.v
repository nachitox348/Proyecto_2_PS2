`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña 
// 
// Create Date:    18:37:41 02/23/2015 
// Design Name: 
// Module Name:    Reg_In 
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
//Registro de datos de entrada
module Reg_In(input wire [4:0] T, //Dato de temperatura
		input wire C, //Dato de ignición (carro encendido u apagago)
		input wire P, //Dato del sensor de precencia
		input wire EN, //Habilitador del registro
		input wire rst, //Reset del registro
		input wire clk,
		output reg [4:0] Temp, //Dato de temperatura guardado en el registro
		output reg Ca, //Dato de ignición guardado en el registro
		output reg Pre //Dato de presencia guardado en el registro
    );


always @(posedge clk or posedge rst)
begin
	if (rst) begin //Inicialización de variables con el reset
		Ca <= 1'b0;
		Temp <= 5'b0;
		Pre <= 1'b0;
	end
	else if (EN) begin //Evalua si se le india al registro que debe comenzar a tomar datos
		Ca <= C;
		Temp <= T;
		Pre <= P;
	end
end

endmodule
