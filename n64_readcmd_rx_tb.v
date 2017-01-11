module n64_readcmd_rx_tb();

// Main 12 MHz clock
reg clk_12M = 0;
reg data = 1;
always #1 clk_12M = ~clk_12M;

// Generate 4 MHz clock
wire clk_4M;
divM #(.M(3)) div3 (
    .clk_in(clk_12M),
    .clk_out(clk_4M)
    );

wire [31:0] ctrl_state;
wire ctrl_clk;
n64_readcmd_rx n64_readcmd_rx_i (
    .clk_4M (clk_4M),
    .din (data),
    .enable (1'b1),
    .ctrl_state (ctrl_state),
    .ctrl_clk (ctrl_clk)
    );

initial begin

  data = 1'b1;

  $dumpfile("n64_readcmd_rx_tb.vcd");
  $dumpvars(0, n64_readcmd_rx_tb);

  repeat (50) begin
	#5000;
	data = 1'b0;
	#24;
	data = 1'b1;
	#72;
	repeat (31) begin
	data = 1'b0;
	#72;
	data = 1'b1;
	#24;
	end
	data = 1'b0;
	#24;
	data = 1'b1;
  end

  #500000 $display("Simulation end");
  $finish;
end

endmodule
