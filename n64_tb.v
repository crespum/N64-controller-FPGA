//-------------------------------------------------------------------
//-- divM_tb.v
//-- Banco de pruebas para el divisor entre M
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module n64_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;
wire data;

//-- Instanciar el componente y establecer el valor del divisor
n64_read_loop n64 (
    .clk(clk),
    .dout(data)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;

//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("n64_tb.vcd");
  $dumpvars(0, n64_tb);

  #500000 $display("FIN de la simulacion");
  $finish;
end

endmodule
