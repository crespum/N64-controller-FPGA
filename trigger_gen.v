// Infinite counter that signals each time it's empty.
// Please note that parameter M should be power of 2, because the internal
// counter underflows after the first time it's emtpy.
//
// Inputs:  clk.    Clock for shifting
// Outputs: trigger.   Parallel output
module triggerM(input wire clk, output trigger);

// Counter's default value
parameter M = 512;
reg trigger = 0;

// Number of bits needed to store the counter value (M)
localparam N = $clog2(M);

// Register for storing the counter's value
reg [N-1:0] divcounter = M;

// Infinite counter (starts over when divcounter underflows)
always @(posedge clk)
    begin
        divcounter <= divcounter - 1;
        if (divcounter == 0)
            trigger <= 1;
        else
            trigger <= 0;
    end
endmodule
