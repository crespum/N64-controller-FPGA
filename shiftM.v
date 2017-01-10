// M-bit shift register
// (Based on 4-bit shift register from obijuan)
//
// Inputs:  clk.    Clock for shifting
//          enable. On active, enable module
//          serin.  Serial input
// Outputs: data.   Parallel output
module shiftM(input wire clk,
              input wire enable,
              input wire serin,
              output [M-1:0] data);

// Bit count
parameter M = 32;

// Initial value to load on register
parameter INI = 1;
reg [M-1:0] data = INI;

// Shift register
always @(posedge(clk)) begin
    if (enable == 1) begin
        data[0]     <= serin;
        data[M-1:1] <= data[M-2:0];
    end
end

endmodule
