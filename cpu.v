/* 
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1

Avaliação (responda em forma de comentários no módulo TOP MIPS_CPU):
Após a implementação e verificação do correto funcionamento do circuito, 
responda (respostas dentro do módulo MIPS_CPU como comentários):

a) Qual a latência do sistema?

Resp: A latência do sistema é de 5 ciclos de clock, que equivale a 599.245655 ns.

b) Qual o throughput do sistema?

Resp: O throughput  do sistema é de um período de clock, após o quinto ciclo,
que equivale a 119.849131 ns

c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer 
para o multiplicador e para o sistema? (Indique a FPGA utilizada)

Resp: A frequência máxima de operação do multiplicador seguindo o Time Quest Timing 
Analizer é de 283.69 MHz, já a do sistema é de __ MHz.A FPGA utilizada foi a CYCLONE IV
EP4CGX150DF31I7AD.

d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)

Resp: A FPGA utilizada foi a CYCLONE IV EP4CGX150DF31I7AD e a máxima frequência de 
operação do sistema é de 8.34382353 MHz, que é um 34 avos da frêquencia máxima do multiplicador

e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada corretamente 
(se executada em sequência ininterrupta)? Por quê? O que pode ser feito para que a 
expressão seja calculada corretamente?

Resp: A instrução não é executada corretamente por conta do pipeline hazzard. 
Esse problema acontece por conta do write back, que adiciona um atraso na execução 
de algumas instruções, uma vez que a informação deve passar por toda pipeline para 
poder voltar para os registros. Se alguma instrução tentar utilizar uma informação de 
alguma operação que ainda não foi finalizada ou gravada no registerfile, ocorrerá um 
erro lógico por uso de um valor incorreto ou lixo de memória. Podemos resolver isso 
adicionando “bolhas”, ou seja, funções de espera, como NOP ou outra função que não 
interfira no funcionamento da pipeline.

f) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas 
com metaestabilidade? Por que?

Resp: Não haverá metaestabilidade, pois o clk do Multiplicador será um múltiplo de clk 
da CPU. Por essa razão, não haverá defasagem entre os clocks e portanto não ocorrerá 
metaestabilidade.

g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, 
é eficiente em termos de velocidade? Por que?

Resp: A aplicação do multiplicador não é eficiente, pois demanda 34 pulsos de clock para 
executar a multiplicação e devolvê-la à pipeline, o que exige que o sistema seja pelo 
menos 34 vezes mais lento que a velocidade máxima do multiplicador, tornando-o 
ineficiente.

h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais 
rápido (frequência de operação maior). Para cada modificação sugerida, qual a nova 
latência e throughput do sistema?

Resp: Uma possível alteração, seria modificar a implementação do multiplicador a 
deixá-lo com menor latência consequentemente aumentando a velocidade máxima da 
pipeline. Essa alteração aumentaria a frequência máxima do clock do sistema, 
porém, não alteraria a latência e o throughput em função do número de clocks, 
mas diminuiria o período de clock, diminuindo a latência e aumentando o throughput 
em função do tempo.*/
