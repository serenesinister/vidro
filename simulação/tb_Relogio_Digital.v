module tb_Relogio_Digital;

  // Declaração dos sinais de entrada e saída
  reg clk;
  reg reset;
  reg btn_ajuste;
  reg btn_inc;
  wire [6:0] display_unidade_min;
  wire [6:0] display_unidade_hora;
  wire [6:0] display_dezena_hora;
  wire [6:0] display_dezena_min;
  wire [7:0] leds;
  wire seg_ponto;

  // Instanciando o módulo Relogio_Digital
  Relogio_Digital uut (
    .clk(clk),
    .reset(reset),
    .btn_ajuste(btn_ajuste),
    .btn_inc(btn_inc),
    .display_unidade_min(display_unidade_min),
    .display_unidade_hora(display_unidade_hora),
    .display_dezena_hora(display_dezena_hora),
    .display_dezena_min(display_dezena_min),
    .leds(leds),
    .seg_ponto(seg_ponto)
  );

  // Geração do clock (1 Hz)
  initial begin
    clk = 0;
    forever #500 clk = ~clk;  // Alterna o clock a cada 500 unidades de tempo (simulando 1 Hz)
  end

  // Gerando o arquivo VCD para visualizar no GTKWave
  initial begin
    $dumpfile("dump.vcd");  // Nome do arquivo de dump de ondas
    $dumpvars(0, tb_Relogio_Digital);  // Dump de todas as variáveis do testbench
  end

  // Simulação
  initial begin
    // Inicializa os sinais
    reset = 1;
    btn_ajuste = 0;
    btn_inc = 0;

    // Aguardar alguns ciclos de clock
    #1000;
    
    // Libera o reset e começa a simulação
    reset = 0;
    
    // Simulação da contagem normal de tempo
    #5000;
    
    // Ajusta o relógio (estado de ajuste de minutos)
    btn_ajuste = 1;
    #1000;
    btn_ajuste = 0;

    // Incrementa minutos
    btn_inc = 1;
    #1000;
    btn_inc = 0;

    // Aguardar alguns ciclos para observar o incremento de minutos
    #5000;

    // Ajusta o relógio (estado de ajuste de horas)
    btn_ajuste = 1;
    #1000;
    btn_ajuste = 0;

    // Incrementa horas
    btn_inc = 1;
    #1000;
    btn_inc = 0;

    // Aguardar mais alguns ciclos para observar o incremento de horas
    #5000;

    // Finalizar a simulação
    $finish;
  end

endmodule
