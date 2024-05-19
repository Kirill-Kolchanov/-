`timescale 1ns / 1ps

module testAddRecFN_tb;
    reg [31:0] inputA;
    reg [31:0] inputB;
    wire [31:0] outputSum;

    // Инициализация экземпляра модуля testAddRecFN
    testAddRecFN uut (
        .inputA(inputA),
        .inputB(inputB),
        .outputSum(outputSum)
    );

    // Процедура инициализации и тестирования
    initial begin
    
        // Инициализация сигналов
        inputA = 0;
        inputB = 0;


        // Тестовый случай 1: сложение 2.5 и 3.5
        inputA = 32'h40200000; // 2.5 в формате IEEE 754 (float32)
        inputB = 32'h40600000; // 3.5 в формате IEEE 754 (float32)
        #100;

        // Проверка результата
        if (outputSum !== 32'h40c00000) // Ожидаемый результат 6.0 в формате IEEE 754 (float32)
            $display("Тест 1 провален: ожидаемое значение 6.0, получено %h", outputSum);
        else
            $display("Тест 1 пройден успешно.");

        // Тестовый случай 2: сложение -1.0 и 1.0
        inputA = 32'hbf800000; // -1.0 в формате IEEE 754 (float32)
        inputB = 32'h3F800000; // 1.0 в формате IEEE 754 (float32)
        #20;

        // Проверка результата
        if (outputSum !== 32'h00000000) // Ожидаемый результат 0.0 в формате IEEE 754 (float32)
            $display("Тест 2 провален: ожидаемое значение 0.0, получено %h", outputSum);
        else
            $display("Тест 2 пройден успешно.");

        // Завершение симуляции
        #100;
        $finish;
    end
endmodule
