// N64 controller read command generator/transmitter
//
// Inputs:  clk_1M    1 MHz clock
//          trigger   On input pulse, transmit read command
// Outputs: enable_o  Active when data is being transmitted
//          dout      Output data line
module n64_readcmd_tx(input wire clk_1M,
                      input wire trigger,
                      output wire enable_o,
                      output wire dout);

// Shift register parallel output
wire [33:0] data;

// dout is just the leftmost bit of data
assign dout = data[33];

// Only enable output when bit counter is not 0.
wire ctr_empty;
assign enable_o = ~ctr_empty;

// On 'trigger', counts from 34 to 0 (for counting output
// bits) and sets 'ctr_empty' active on finish.
counterM #(.M(34))
    counter_signal_cycles (
        .clk(clk_1M),
        .reset(trigger),
        .empty(ctr_empty)
    );

// Shift register containing the raw waveform of the
// read command. Only enabled when counter is not 0.
shiftM #(.M(34), .INI(34'b0001000100010001000100010001011101))
    shift_signal (
        .clk(clk_1M),
        .enable(~ctr_empty),
        .serin(dout),
        .data(data)
    );

endmodule
