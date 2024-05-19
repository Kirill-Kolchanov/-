`timescale 1ns / 1ps

module sum_series_tb;

parameter N = 100;
parameter DATA_WIDTH = 32;

// test signals
reg clk;
reg reset;
reg start;
reg [DATA_WIDTH-1:0] data_array [0:N-1];
wire [DATA_WIDTH-1:0] sum_output;
wire done;
integer i;

// Initializing the sum_series module
sum_series #(.N(N), .DATA_WIDTH(DATA_WIDTH)) uut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .data_array(data_array),
    .sum_output(sum_output),
    .done(done)
);

// Clock signal generator
always #5 clk = ~clk;

// Initialization and testing procedure
initial begin
    // Initialization of signals
    clk = 0;
    reset = 1;
    start = 0;

    for (i = 0; i < N; i = i + 1) begin
        data_array[i] = 32'h40A9999A; // Example of filling an array 5.3
    end
    // Reset and run the test
    #10;
    reset = 0;
    #10;
    start = 1;
    #1000;
    
    wait(done)
    #100;
    $finish;
    

end

endmodule
