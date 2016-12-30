module n64_read_loop(input wire clk, output wire dout);

//-- Cable entre contador y registro de desplazamiento
wire read_start;
wire clk_1M;

//-- Instanciar el registro de desplazamiento y establecer el valor del inicial
//-- Instanciar el componente y establecer el valor del divisor
n64_cmd_gen n64 (
    .clk(clk_1M),
    .trigger(read_start),
    .dout(dout)
  );

divM div12 (
    .clk_in(clk),
    .clk_out(clk_1M)
    );

triggerM trigger512 (
    .clk(clk_1M),
    .trigger(read_start)
    );
endmodule
