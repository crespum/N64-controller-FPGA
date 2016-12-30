//-------------------------------------------------------------------
//-- Ejemplo de uso de un registro de desplazamiento de 4 bits
//-- para generar una secuencia de rotacion de bits
//-------------------------------------------------------------------
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-- GPL license
//-------------------------------------------------------------------
module shiftM(input wire clk, input wire enable, output dout);

//-- Numero de bits
parameter M = 32;

//-- Valor inicial a cargar en el registro
parameter INI = 1;

reg [M-1:0] data = INI;

//-- Registro de desplazamiento
always @(posedge(clk)) begin
    if (enable == 1) begin//-- Load mode
        data[0] <= data[M-1];
        data[M-1:1] <= data[M-2:0];
    end
end

//-- Salida de mayor peso se re-introduce por la entrada serie
assign dout = data[0];

endmodule
