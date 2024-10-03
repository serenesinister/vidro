# Relógio Digital - Projeto em Hardware

Este repositório contém o código em Verilog para a implementação de um relógio digital com contagem de horas, minutos e segundos. O relógio suporta ajuste de tempo através de botões e exibição em 4 displays de 7 segmentos.

## Descrição

O relógio digital é composto por diversos módulos:
- **Contador de Horas, Minutos e Segundos**: Realiza a contagem com base em um clock de 1Hz.
- **Ajuste de Tempo**: Permite o ajuste de horas e minutos através de dois botões.
- **Exibição em Displays de 7 Segmentos**: Apresenta o tempo atual em quatro displays, com o ponto separador entre horas e minutos sempre aceso.
- **LEDs para Contagem de Segundos**: LEDs representam visualmente o avanço dos segundos.

## Testes

O projeto foi testado na **FPGA Altera Cyclone II DE2** no laboratório de hardware, garantindo que todas as funcionalidades do relógio digital estejam operacionais.

## Diagramas do Projeto

### Diagrama de Módulos em Blocos

![Diagrama de Módulos](https://drive.google.com/uc?export=view&id=1sdCcCaLYIHHgaWaC9wTGsD7V94GAdK-W)

### Diagrama da Máquina de Estados

![Diagrama da Máquina de Estados](https://drive.google.com/uc?export=view&id=1a_hDYVOWhz1TCVEwwH5lOsJwg2dIqDj5)

## Vídeo Demonstrativo

Em breve será disponibilizado um vídeo no YouTube para demonstrar o funcionamento do relógio digital. Fique atento!

## Links Importantes

- **Repositório GitHub**: [https://github.com/serenesinister/vidro/](https://github.com/serenesinister/vidro/)
- **Diagramas**: [Diagrama de Módulos em Blocos](https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=RelogioDigital.drawio#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1PggjZC66QEcQSLhh32N1gI66Bg7osPoK%26export%3Ddownload)
- **Vídeo no YouTube**: [Link para o Vídeo](https://link-a-definir)

## Como Utilizar

Para utilizar este projeto, clone o repositório:

```bash
git clone https://github.com/serenesinister/vidro.git
