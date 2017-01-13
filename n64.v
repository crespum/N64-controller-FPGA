module n64_top(
    input wire clk,
    inout data,
    output led_middle,
    output led_up,
    output led_down,
    output led_left,
    output led_right);

wire [31:0] ctrl_state;
wire ctrl_clk;

assign led_middle = ctrl_state[31];
assign led_up     = ctrl_state[27];
assign led_down   = ctrl_state[26];
assign led_left   = ctrl_state[25];
assign led_right  = ctrl_state[24];

// Generate 4 MHz clock from 12 MHz main clock
wire clk_4M;
divM #(.M(3)) div3 (
    .clk_in(clk),
    .clk_out(clk_4M)
    );

// N64 controller reader
n64_readcmd n64 (
    .clk_4M(clk_4M),
    .data(data),
    .ctrl_state(ctrl_state),
    .ctrl_clk(ctrl_clk)
  );

endmodule
