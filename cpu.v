a) A latência do sistema é de 5 ciclos de clock, que equivale a __ ns.

b) O throughput  do sistema é de um período de clock, após o quinto ciclo,
que equivale a __ ns

c) A frequência máxima de operação do multiplicador seguindo
 o Time Quest Timing Analizer é de __ MHz, já a do sistema é de __ MHz.

d) A FPGA utilizada foi a CYCLONE IV EP4CGX150DF31I7AD e
 a máxima frequência de operação do sistema é de ___ MHz

e) A instrução não é executada corretamente por conta do pipeline hazzard. 
Esse problema acontece por conta do write back, que adiciona um atraso na execução 
de algumas instruções, uma vez que a informação deve passar por toda pipeline para 
poder voltar para os registros. Se alguma instrução tentar utilizar uma informação de 
alguma operação que ainda não foi finalizada ou gravada no registerfile, ocorrerá um 
erro lógico por uso de um valor incorreto ou lixo de memória. Podemos resolver isso 
adicionando “bolhas”, ou seja, funções de espera, como NOP ou outra função que não 
interfira no funcionamento da pipeline.

f) Não haverá metaestabilidade, pois o clk do Multiplicador será um múltiplo de clk 
da CPU. Por essa razão, não haverá defasagem entre os clocks e portanto não ocorrerá 
metaestabilidade.

g) A aplicação do multiplicador não é eficiente, pois demanda 34 pulsos de clock para 
executar a multiplicação e devolvê-la à pipeline, o que exige que o sistema seja pelo 
menos 34 vezes mais lento que a velocidade máxima do multiplicador, tornando-o 
ineficiente.

h) Uma possível alteração, seria modificar a implementação do multiplicador a 
deixá-lo com menor latência consequentemente aumentando a velocidade máxima da pipeline. Essa alteração aumentaria a frequência máxima do clock do sistema, porém, não alteraria a latência e o throughput em função do número de clocks, mas diminuiria o período de clock, diminuindo a latência e aumentando o throughput em função do tempo.