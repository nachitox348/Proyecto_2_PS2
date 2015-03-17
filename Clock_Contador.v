`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ignacio Fernández Garita, Daniel Zamora Umaña 
// 
// Create Date:    15:25:25 02/26/2015 
// Design Name: 
// Module Name:    Clock_Contador 
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
//Modifica el clock interno para obtener un clock mas lento para el display
module Clock_Contador(
    input wire clk,
	 input wire rst,
    output wire clk_mod //Clock que se usara en el display de 7 segmentos
	 //output wire clk_control
    );

reg [16:0] cont; //Registro del la partición del clock

//Parte el clock interno por medio de un contador de 16-bits
always @ (posedge clk, posedge rst)
begin
	if (rst) begin cont<=0; end
	else begin cont<=cont+1'b1; end
end

assign clk_mod=cont[16];
//assign clk_control = cont[26];

endmodule
