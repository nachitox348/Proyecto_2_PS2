`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña 
// 
// Create Date:    18:39:14 02/23/2015 
// Design Name: 
// Module Name:    Reg_Out 
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
//Registro de salidas del sistema
module Reg_Out(input wire [1:0] LOG, //Variables obtenidas en el bloque combinacional
	input wire EN, //Habilitador del registro
	input wire rst, //Reset del registro
	input wire clk, 
	output reg [1:0] out //Salida desl sistema
    );

always @ (posedge clk or posedge rst)
begin
	if (rst) begin //Inicialización de la salida con el reset
		out <= 2'b0;
	end
	else if (EN) begin //Evalua si el habilitador da paso a la actualización de la salida
		out <= LOG;
	end
end

endmodule
