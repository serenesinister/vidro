# Relógio Digital - Projeto em Hardware

Este repositório contém o código em Verilog para a implementação de um relógio digital com contagem de horas, minutos e segundos. O relógio suporta ajuste de tempo através de botões e exibição em 4 displays de 7 segmentos.

## Autor

**Wemerson Soares**

## Descrição

O relógio digital é composto por diversos módulos:
- **Contador de Horas, Minutos e Segundos**: Realiza a contagem com base em um clock de 1Hz.
- **Ajuste de Tempo**: Permite o ajuste de horas e minutos através de dois botões.
- **Exibição em Displays de 7 Segmentos**: Apresenta o tempo atual em quatro displays, com o ponto separador entre horas e minutos sempre aceso.
- **LEDs para Contagem de Segundos**: LEDs representam visualmente o avanço dos segundos.

## Simulação

O projeto foi simulado e testado na **FPGA Altera Cyclone II DE2** no laboratório de hardware. Durante essa fase, foi apresentada uma demonstração prática de todas as funcionalidades do relógio digital, garantindo que o sistema operasse conforme o esperado.

## Diagramas do Projeto

### Diagrama de Módulos em Blocos

![Diagrama de Módulos](https://drive.google.com/uc?export=view&id=1sdCcCaLYIHHgaWaC9wTGsD7V94GAdK-W)

### Diagrama da Máquina de Estados

![Diagrama da Máquina de Estados](https://drive.google.com/uc?export=view&id=1a_hDYVOWhz1TCVEwwH5lOsJwg2dIqDj5)

## Apresentação e Demonstração em Vídeo

Um vídeo demonstrativo do projeto já está disponível no YouTube. Neste vídeo, apresento a introdução ao projeto, suas especificações, os diagramas de blocos e da máquina de estados, além de uma análise do código e uma demonstração do funcionamento na placa Pitanga S-Board da In-Place. Também incluo os resultados dos testes e uma demonstração da implementação na FPGA.

Confira como o projeto funciona na prática: [Assista ao Vídeo](https://youtu.be/OifkEoE0GLU).

## Links Importantes

- **Repositório GitHub**: Acesse o código-fonte do projeto [Relógio Digital no GitHub](https://github.com/serenesinister/vidro/).
- **Diagramas do Projeto**: Visualize os diagramas utilizados na implementação [Diagramas do Relógio Digital](https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=RelogioDigital.drawio#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1PggjZC66QEcQSLhh32N1gI66Bg7osPoK%26export%3Ddownload).
- **Vídeo do Projeto**: Assista à apresentação e demonstração do projeto no YouTube [Vídeo Demonstrativo do Relógio Digital](https://youtu.be/OifkEoE0GLU).
