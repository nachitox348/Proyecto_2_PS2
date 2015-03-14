`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:15 03/10/2015 
// Design Name: 
// Module Name:    Validador_Caracter 
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
module Validador_Caracter(
    input wire rst,
    input wire [7:0] dato,
    input wire tick,
    output Verificador_C
    );

reg Reg_Sal;
always @ *
	if (rst)
		Reg_Sal = 1'b0;
	else if (tick)
		begin
		Reg_Sal = (dato==8'h16)? 1'b1 :
					(dato==8'h1E)? 1'b1 :
					(dato==8'h26)? 1'b1 :
					(dato==8'h25)? 1'b1 :
					(dato==8'h2E)? 1'b1 :
					(dato==8'h36)? 1'b1 :
					(dato==8'h3D)? 1'b1 :
					(dato==8'h3E)? 1'b1 :
					(dato==8'h46)? 1'b1 :
					(dato==8'h45)? 1'b1 :
					(dato==8'h43)? 1'b1 :
					(dato==8'h4D)? 1'b1 :
					(dato==8'h31)? 1'b1 :
					(dato==8'h5A)? 1'b1 : 1'b0;
		end
	else Reg_Sal = 1'b0;
	
assign Verificador_C = Reg_Sal;
endmodule
