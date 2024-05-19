`timescale 1ns / 1ps

module testAddRecFN_tb;
    reg [31:0] inputA;
    reg [31:0] inputB;
    wire [31:0] outputSum;

    // ������������� ���������� ������ testAddRecFN
    testAddRecFN uut (
        .inputA(inputA),
        .inputB(inputB),
        .outputSum(outputSum)
    );

    // ��������� ������������� � ������������
    initial begin
    
        // ������������� ��������
        inputA = 0;
        inputB = 0;


        // �������� ������ 1: �������� 2.5 � 3.5
        inputA = 32'h40200000; // 2.5 � ������� IEEE 754 (float32)
        inputB = 32'h40600000; // 3.5 � ������� IEEE 754 (float32)
        #100;

        // �������� ����������
        if (outputSum !== 32'h40c00000) // ��������� ��������� 6.0 � ������� IEEE 754 (float32)
            $display("���� 1 ��������: ��������� �������� 6.0, �������� %h", outputSum);
        else
            $display("���� 1 ������� �������.");

        // �������� ������ 2: �������� -1.0 � 1.0
        inputA = 32'hbf800000; // -1.0 � ������� IEEE 754 (float32)
        inputB = 32'h3F800000; // 1.0 � ������� IEEE 754 (float32)
        #20;

        // �������� ����������
        if (outputSum !== 32'h00000000) // ��������� ��������� 0.0 � ������� IEEE 754 (float32)
            $display("���� 2 ��������: ��������� �������� 0.0, �������� %h", outputSum);
        else
            $display("���� 2 ������� �������.");

        // ���������� ���������
        #100;
        $finish;
    end
endmodule
