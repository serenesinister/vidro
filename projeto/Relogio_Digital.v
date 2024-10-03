/****************************************** (c) 2024 Wemerson Soares
  Módulo	: Clock_Digital
  Descrição : Módulo de relógio digital com contagem de horas, minutos e segundos.
              Suporta ajuste de tempo e exibição em 4 displays de 7 segmentos.
******************************************************************************/
// Módulo principal do relógio digital
module Relogio_Digital (
    input clk,               // Clock de 1Hz
    input reset,             // Sinal de reset
    input btn_ajuste,        // Botão para ajuste do relógio
    input btn_inc,           // Botão para incremento de horas ou minutos
    output [6:0] display_unidade_min,  // Unidades dos minutos a serem exibidas
    output [6:0] display_unidade_hora,  // Unidades das horas a serem exibidas
    output [6:0] display_dezena_hora,   // Dezenas das horas a serem exibidas
    output [6:0] display_dezena_min,    // Dezenas dos minutos a serem exibidas
    output [7:0] leds,        // LEDs para exibição da contagem de segundos
    output wire seg_ponto     // Ponto entre horas e minutos
);

    wire [5:0] segundos, minutos; // Sinais para armazenar os segundos e minutos
    wire [4:0] horas;             // Sinal para armazenar as horas
    wire ajustando;               // Sinal para indicar se o relógio está em modo de ajuste
    wire [1:0] estado;            // Estado atual do relógio (ajuste ou contagem normal)

    // Instâncias dos módulos utilizados
    Contador_Relogio contador (
        .clk(clk),                // Conexão do clock
        .reset(reset),            // Conexão do sinal de reset
        .btn_ajuste(btn_ajuste),  // Conexão do botão de ajuste
        .btn_inc(btn_inc),        // Conexão do botão de incremento
        .segundos(segundos),      // Sinal para os segundos
        .minutos(minutos),        // Sinal para os minutos
        .horas(horas),            // Sinal para as horas
        .ajustando(ajustando),    // Sinal de ajuste
        .estado(estado)           // Estado do ajuste
    );
    
    Display_7Seg display (
        .horas(horas),                        // Conexão das horas
        .minutos(minutos),                    // Conexão dos minutos
        .display_unidade_min(display_unidade_min),  // Conexão para a unidade dos minutos
        .display_unidade_hora(display_unidade_hora), // Conexão para a unidade das horas
        .display_dezena_hora(display_dezena_hora),   // Conexão para a dezena das horas
        .display_dezena_min(display_dezena_min)      // Conexão para a dezena dos minutos
    );
    
    assign seg_ponto = 1; // O ponto entre horas e minutos é sempre aceso
    assign leds = segundos; // Exibe o valor dos segundos nos LEDs
endmodule

// Módulo para contagem do relógio
module Contador_Relogio (
    input clk,                    // Clock de entrada
    input reset,                  // Sinal de reset
    input btn_ajuste,            // Botão de ajuste
    input btn_inc,               // Botão de incremento
    output reg [5:0] segundos = 0, // Registro para armazenar os segundos
    output reg [5:0] minutos = 0,   // Registro para armazenar os minutos
    output reg [4:0] horas = 0,     // Registro para armazenar as horas
    output reg ajustando = 0,       // Flag de ajuste
    output reg [1:0] estado = 0      // Estado do ajuste (0: rodando, 1: ajusta minutos, 2: ajusta horas)
);

    reg [3:0] dezena_min = 0; // Variável para armazenar as dezenas de minutos

    // Lógica de contagem do relógio
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa os registros quando o sinal de reset é ativado
            horas <= 0;               // Reseta horas
            minutos <= 0;             // Reseta minutos
            dezena_min <= 0;          // Reseta dezenas de minutos
            segundos <= 0;            // Reseta segundos
            ajustando <= 0;           // Reseta flag de ajuste
            estado <= 0;              // Inicia no estado de contagem normal
        end else begin
            if (btn_ajuste) begin
                // Alterna entre os estados de ajuste e contagem
                estado <= (estado + 1) % 3; // Ciclo: 0 (rodando) -> 1 (ajustar minuto) -> 2 (ajustar hora) -> 0 (rodando)
            end
            
            if (estado == 0) begin
                // Estado de contagem normal
                segundos <= segundos + 1;  // Contagem de segundos
                if (segundos == 59) begin
                    segundos <= 0;              // Reseta segundos após 59
                    minutos <= minutos + 1;      // Incrementa minutos
                    if (minutos == 59) begin
                        minutos <= 0;              // Reseta minutos após 59
                        horas <= (horas + 1) % 24;  // Incrementa horas a cada 60 minutos
                    end
                end
            end else if (estado == 1) begin
                // Estado de ajuste de minutos
                if (btn_inc) begin
                    // Incrementa minutos ao pressionar o botão de incremento
                    if (minutos % 10 == 9) begin
                        dezena_min <= (dezena_min + 1) % 6; // Incrementa as dezenas se unidades chegarem a 9
                    end
                    minutos <= (minutos + 1) % 60;  // Incrementa minutos e reseta após 59
                end
            end else if (estado == 2) begin
                // Estado de ajuste de horas
                if (btn_inc) begin
                    // Incrementa horas ao pressionar o botão de incremento
                    horas <= (horas + 1) % 24;  // Incrementa horas e reseta após 23
                end
            end
        end
    end
endmodule

// Módulo para exibição nos displays de 7 segmentos
module Display_7Seg (
    input [4:0] horas,          // Horas a serem exibidas
    input [5:0] minutos,        // Minutos a serem exibidos
    output reg [6:0] display_unidade_min,  // Unidades dos minutos a serem exibidas
    output reg [6:0] display_unidade_hora, // Unidades das horas a serem exibidas
    output reg [6:0] display_dezena_hora,  // Dezenas das horas a serem exibidas
    output reg [6:0] display_dezena_min    // Dezenas dos minutos a serem exibidas
);

    // Sempre que houver mudança nas horas ou minutos, atualiza os displays
    always @(*) begin
        display_dezena_hora = hora_para_7seg(horas / 10);        // Converte as dezenas das horas para 7 segmentos
        display_unidade_hora = hora_para_7seg(horas % 10);       // Converte as unidades das horas para 7 segmentos
        display_dezena_min = min_para_7seg(minutos / 10);        // Converte as dezenas dos minutos para 7 segmentos
        display_unidade_min = min_para_7seg(minutos % 10);       // Converte as unidades dos minutos para 7 segmentos
    end

    // Função para converter horas em formato para displays de 7 segmentos
    function [6:0] hora_para_7seg(input [3:0] valor);
        case (valor)
            0: hora_para_7seg = 7'b1111110; // 0 - acende a, b, c, d, e, f
            1: hora_para_7seg = 7'b0110000; // 1 - acende b, c
            2: hora_para_7seg = 7'b1101101; // 2 - acende a, b, d, e, g
            3: hora_para_7seg = 7'b1111001; // 3 - acende a, b, c, d, g
            4: hora_para_7seg = 7'b0110011; // 4 - acende b, c, f, g
            5: hora_para_7seg = 7'b1011011; // 5 - acende a, c, d, f, g
            6: hora_para_7seg = 7'b1011111; // 6 - acende a, c, d, e, f, g
            7: hora_para_7seg = 7'b1110000; // 7 - acende a, b, c
            8: hora_para_7seg = 7'b1111111; // 8 - acende todos
            9: hora_para_7seg = 7'b1110011; // 9 - acende a, b, c, d, f, g
            default: hora_para_7seg = 7'b0000000; // Desligado
        endcase
    endfunction

    // Função para converter minutos em formato para displays de 7 segmentos
    function [6:0] min_para_7seg(input [3:0] valor);
        case (valor)
            0: min_para_7seg = 7'b1111110; // 0 - acende a, b, c, d, e, f
            1: min_para_7seg = 7'b0110000; // 1 - acende b, c
            2: min_para_7seg = 7'b1101101; // 2 - acende a, b, d, e, g
            3: min_para_7seg = 7'b1111001; // 3 - acende a, b, c, d, g
            4: min_para_7seg = 7'b0110011; // 4 - acende b, c, f, g
            5: min_para_7seg = 7'b1011011; // 5 - acende a, c, d, f, g
            6: min_para_7seg = 7'b1011111; // 6 - acende a, c, d, e, f, g
            7: min_para_7seg = 7'b1110000; // 7 - acende a, b, c
            8: min_para_7seg = 7'b1111111; // 8 - acende todos
            9: min_para_7seg = 7'b1110011; // 9 - acende a, b, c, d, f, g
            default: min_para_7seg = 7'b0000000; // Desligado
        endcase
    endfunction
endmodule
