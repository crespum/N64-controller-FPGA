// Descending counter
//
// Inputs:  clk    Counter clock
//          reset  When active, set count to M
// Outputs: empty  Active when counter is 0
module counterM(input wire clk,
                input wire reset,
                output empty);

// Value of counter to set on 'reset'
parameter M = 35;

// Number of bits needed to store value of counter
localparam N = $clog2(M) + 1;

// Register to store counter value
reg [N-1:0] divcounter = 0;

// Counter: will only count down to 0
always @(posedge clk)
    if (reset == 1)
        divcounter <= M;
    else
        if (divcounter > 0)
            divcounter <= divcounter - 1;

// output 'empty' will be active when all bits are 0
assign empty = ~| divcounter;

endmodule
