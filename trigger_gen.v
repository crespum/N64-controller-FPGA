module triggerM(input wire clk, output trigger);

//-- Valor por defecto del contador
parameter M = 512;
reg trigger = 0;

//-- Numero de bits para almacenar el divisor
//-- Se calculan con la funcion de verilog $clog2, que nos devuelve el
//-- numero de bits necesarios para representar el numero M
//-- Es un parametro local, que no se puede modificar al instanciar
localparam N = $clog2(M);

//-- Registro para implementar el contador modulo M
reg [N-1:0] divcounter = M;

//-- Contador módulo M
always @(posedge clk)
    begin
        divcounter <= divcounter - 1;
        if (divcounter == 0)
            trigger <= 1;
        else
            trigger <= 0;
    end
endmodule
