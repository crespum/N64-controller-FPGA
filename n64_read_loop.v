module n64_read_loop(input wire clk, inout dout);

//-- Entrada a usar en nuestro circuito, con el pull-up activado
wire dout_o;
wire dout_i;

//-- Cable entre contador y registro de desplazamiento
wire read_start;
wire clk_1M;
wire output_en;

//-- Instanciar el registro de desplazamiento y establecer el valor del inicial
//-- Instanciar el componente y establecer el valor del divisor
n64_cmd_gen n64 (
    .clk(clk_1M),
    .trigger(read_start),
    .enable_o(output_en),
    .dout(dout_o)
  );

divM div12 (
    .clk_in(clk),
    .clk_out(clk_1M)
    );

triggerM trigger512 (
    .clk(clk_1M),
    .trigger(read_start)
    );

SB_IO #(
    .PIN_TYPE(6'b 1010_01),
    .PULLUP(1'b 1)
) io_pin (
    .PACKAGE_PIN(dout),
    .OUTPUT_ENABLE(output_en),
    .D_OUT_0(dout_o),
    .D_IN_0(dout_i)
);

endmodule
