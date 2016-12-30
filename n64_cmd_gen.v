module n64_cmd_gen(input wire clk, input wire trigger, output wire dout);

//-- Cable entre contador y registro de desplazamiento
wire ctr_empty;

//-- Instanciar el contador y establecer el valor del inicial
counterM #(.M(36))
  counter32(
    .clk(clk),
    .reset(trigger),
    .empty(ctr_empty)
  );

//-- Instanciar el registro de desplazamiento y establecer el valor del inicial
shiftM #(.M(36), .INI(36'b00010001000100010001000100010111011z))
    shift32(
      .clk(clk),
      .enable(~ctr_empty),
      .dout(dout)
    );

endmodule
