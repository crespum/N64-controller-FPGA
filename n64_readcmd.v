// N64 controller module
//
// Inputs:          clk_4M      4 MHz clock
// Input/Output:    data        Data line to send the request and receive the response
// Outputs:         ctrl_state  32-bit register with controller state
//                  ctrl_clk    Output clock, sample at negative edge
module n64_readcmd(input wire clk_4M,
                   inout data,
                   output wire [31:0] ctrl_state,
                   output wire ctrl_clk);

// Internal wires
wire read_start;    // Trigger signal
wire output_en;     // Active when transmitting data

// Our data line will be buffered through this SB_IO block.
// This manual I/O instance allows us to control
// output enable, and thus switch between input and
// output
wire data_o;
wire data_i;

SB_IO #(
    .PIN_TYPE(6'b 1010_01),
    .PULLUP(1'b 1)
) io_pin (
    .PACKAGE_PIN(data),
    .OUTPUT_ENABLE(output_en),
    .D_OUT_0(data_o),
    .D_IN_0(data_i)
);

// Generate 1 MHz clock (needed for tx block)
// from the 4 MHz clock
wire clk_1M;
divM #(.M(4))
    div3 (
        .clk_in(clk_4M),
        .clk_out(clk_1M)
    );

// Generator/transmission block, sends the
// read command over the data line when
// triggered
n64_readcmd_tx
    n64_readcmd_tx_i (
        .clk_1M(clk_1M),
        .trigger(read_start),
        .enable_o(output_en),
        .dout(data_o)
    );

// rx block enable signal (TODO: improve)
reg triggered = 0;
always @(posedge(read_start)) triggered = 1;
wire receive = ~output_en & triggered;

// Parser/reception block, must be enabled
// after transmission end. Reads the data
// line containing the controller reply.
n64_readcmd_rx
    n64_readcmd_rx_i (
        .clk_4M(clk_4M),
        .din(data_i),
        .enable(receive),
        .ctrl_state(ctrl_state),
        .ctrl_clk(ctrl_clk)
    );

// Trigger generator, for periodically
// sending a read command
triggerM
    trigger_read (
        .clk(clk_1M),
        .trigger(read_start)
    );

endmodule
