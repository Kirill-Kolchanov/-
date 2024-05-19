module testAddRecFN(
    input wire [31:0] inputA, // ������ ������� float32 �� ��������� IEEE 754
    input wire [31:0] inputB, // ������ ������� float32 �� ��������� IEEE 754
    output wire [31:0] outputSum // �����: inputA + inputB
);
    wire [32:0] recodedA, recodedB, recodedSum;

    // ����������� �� ������������ ������� IEEE � ����������������
    fNToRecFN#(8, 24) convertA(inputA, recodedA);
    fNToRecFN#(8, 24) convertB(inputB, recodedB);

    // �������� � ���������������� �������
    addRecFN#(8, 24) adder(
        .control(0), 
        .subOp(0), 
        .a(recodedA), 
        .b(recodedB), 
        .roundingMode(0), 
        .out(recodedSum), 
        .exceptionFlags()
    );

    // ����������� ���������� ������� � ����������� ������ IEEE
    recFNToFN#(8, 24) convertSum(recodedSum, outputSum);
endmodule
