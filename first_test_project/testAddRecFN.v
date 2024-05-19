module testAddRecFN(
    input wire [31:0] inputA, // первый операнд float32 по стандарту IEEE 754
    input wire [31:0] inputB, // второй операнд float32 по стандарту IEEE 754
    output wire [31:0] outputSum // сумма: inputA + inputB
);
    wire [32:0] recodedA, recodedB, recodedSum;

    // Конвертация из стандартного формата IEEE в перекодированный
    fNToRecFN#(8, 24) convertA(inputA, recodedA);
    fNToRecFN#(8, 24) convertB(inputB, recodedB);

    // Сложение в перекодированном формате
    addRecFN#(8, 24) adder(
        .control(0), 
        .subOp(0), 
        .a(recodedA), 
        .b(recodedB), 
        .roundingMode(0), 
        .out(recodedSum), 
        .exceptionFlags()
    );

    // Конвертация результата обратно в стандартный формат IEEE
    recFNToFN#(8, 24) convertSum(recodedSum, outputSum);
endmodule
