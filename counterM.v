module counterM(input wire clk, input wire reset, output empty);

//-- Valor por defecto de la salida
reg empty = 1;

//-- Valor por defecto del contador
parameter M = 35;

//-- Numero de bits para almacenar el divisor
//-- Se calculan con la funcion de verilog $clog2, que nos devuelve el
//-- numero de bits necesarios para representar el numero M
//-- Es un parametro local, que no se puede modificar al instanciar
localparam N = $clog2(M) + 1;

//-- Registro para implementar el contador modulo M
reg [N-1:0] divcounter = 0;

//-- Contador módulo M
always @(posedge clk)
    if (reset == 1) begin
        divcounter <= M;
        empty <= 0;
    end
    else begin
        if (divcounter > 0)
            divcounter <= divcounter - 1;
        if (divcounter == 1)
            empty <= 1;
    end
endmodule
