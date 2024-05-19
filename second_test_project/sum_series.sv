`timescale 1ns / 1ps
// Module definition for sum_series
module sum_series #(parameter N = 10, DATA_WIDTH = 32)(
    input clk,                  // Clock input
    input reset,                // Reset input
    input start,                // Start input
    input logic [DATA_WIDTH-1:0] data_array [0:N-1],// Data array input
    output logic [DATA_WIDTH-1:0] sum_output,          // Sum output
    output logic done                                  // Done output
);

// Define states using localparam
localparam IDLE = 0,       
           ADD0 = 1,
           ADD1= 2,
           FINISH = 3;

integer i;  // Integer variable for iteration
// Declare state and next state variables
logic [DATA_WIDTH-1:0] rec_data, next_datasum_input_data, input_data;
logic [2:0] state, next_state;
// Declare temporary variables for calculations
logic [DATA_WIDTH-1:0] temp_sum, temp_next_data, temp_sum_input_data;
logic [DATA_WIDTH-1:0] out_add_sum; // Output of the adder

// Declare variables for input data

logic [DATA_WIDTH-1:0] next_data, sum_input_data;

assign next_data = temp_next_data;
assign sum_input_data = temp_sum_input_data;

// Instantiate an adder module
adder add (
    .inputA(sum_input_data),
    .inputB(next_data),
    .outputSum(out_add_sum)
);


// State machine logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        sum_output <= 0;
        i <= 0;
        temp_sum <= 0;
    end else begin
        // Update state based on next_state
        state <= next_state;
    end
end
// State transition and processing logic
always @* begin
    case (state)
        IDLE: begin
            if (start) next_state = ADD0; // Transition to ADD0 if start signal is asserted
            else next_state = IDLE;
        end

        ADD0: begin    
            temp_sum_input_data = temp_sum;                 
            temp_next_data = data_array[i];                        
            next_state = ADD1;
            
        end
        ADD1: begin
            sum_output = out_add_sum;
            if(i == N-1) begin
                next_state = FINISH;
            end else begin
                i = i + 1;
                temp_sum = out_add_sum;             
                next_state = ADD0;
            end
        end
        FINISH: begin
            done = 1;
            sum_output = out_add_sum;
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

endmodule


