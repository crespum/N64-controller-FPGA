// N64 controller read command parser/receiver
//
// Inputs:  clk_4M      4 MHz clock
//          din         Input data line
//          enable      Only samples when this is active
// Outputs: ctrl_state  32-bit register with controller state
//          ctrl_clk    Output clock, sample at negative edge
module n64_readcmd_rx(input wire clk_4M,
                      input wire din,
                      input wire enable,
                      output reg [31:0] ctrl_state,
                      output wire ctrl_clk);

// In sample window, we can read the value of the
// last 8 samples of the input signal.
// Sampling frequency is 4 MHz
wire [6:0] sampling_window;

shiftM #(.M(7), .INI(7'b1111111))
    shift_sampling_reg (
        .clk(clk_4M),
        .enable(enable),
        .serin(din),
        .data(sampling_window)
    );

// When we detect a falling edge at the oldest bit of
// the sampling window, we already have our desired
// bit at the newest position
wire [32:0] ctrl_state_dirty;

shiftM #(.M(33), .INI(33'b0))
    shift_controller_state_reg (
        .clk(~sampling_window[6]),
        .enable(enable),
        .serin(sampling_window[0]),
        .data(ctrl_state_dirty)
    );

// We need to update our 'ctrl_state' from 'ctrl_state_dirty'
// at the right time, that is, when we finish reading
// all of the 32 bits.
wire output_en;

counterM #(.M(32))
  counter_signal_complete (
    .clk(~sampling_window[6]),
    .reset(ctrl_clk),
    .empty(ctrl_clk)
  );


initial ctrl_state = 32'b0;
always @(posedge ctrl_clk)
    ctrl_state <= ctrl_state_dirty[32:1];

endmodule
