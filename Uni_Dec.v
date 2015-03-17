`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña 
// 
// Create Date:    17:27:24 02/23/2015 
// Design Name: 
// Module Name:    Unidades 
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
//Modulo que decodifica la temperatura para ser desplejada como decenas y unidades en el 7 segmentos
module Uni_Dec(input wire [4:0] temp,
		output reg [4:0] Uni,
		output reg [1:0] Dec
    );
always @ *
begin
	Uni = (temp<5'b01010) ? temp : (temp<5'b10100) ? (temp-5'b01010) :
		(temp<5'b11110) ? (temp-5'b10100) : (temp-5'b11110) ; //Asignación condicional de las unidades
	Dec = (temp<5'b01010) ? 2'b00 : (temp<5'b10100) ? 2'b01 :
		(temp<5'b11110) ? 2'b10 : 2'b11 ; //Asignación condicional de las decenas
end
endmodule