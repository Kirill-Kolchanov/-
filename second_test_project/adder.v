`timescale 1ns / 1ps

module adder(
    input wire [31:0] inputA,
    input wire [31:0] inputB,
    output wire [31:0] outputSum
);
    wire [32:0] recodedA, recodedB, recodedSum;

    // Convert inputs to recoded format using fNToRecFN module
    fNToRecFN#(8, 24) convertA(inputA, recodedA);
    fNToRecFN#(8, 24) convertB(inputB, recodedB);

    // Perform addition in recoded format using addRecFN module
    addRecFN#(8, 24) adder(
        .control(0), 
        .subOp(0), // 0 - addition, 1 - subtraction
        .a(recodedA), 
        .b(recodedB), 
        .roundingMode(0), //rounding mode (nearest event)
        .out(recodedSum), 
        .exceptionFlags()
    );

    // Convert the sum from recoded format to normal floating-point IEEE using recFNToFN module
    recFNToFN#(8, 24) convertSum(recodedSum, outputSum);
endmodule
