Feature: Geração de Relatórios
  As a usuário Administrador
  I want to gerar relatórios
  So that é possível fazer análise dos dados de modo mais simples
  
  @c1
  Scenario: Produzir um relatório do total de resíduo(s), por Laboratório / Departamento / Resíduos entre datas específicas
    Given o sistema possui o departamento de "Engenharia Química" cadastrado
    And o sistema possui o laboratório de "Processos Químicos" cadastrado no departamento de "Engenharia Química"
    And o sistema possui "500"kg de resíduos cadastrados no laboratório de "Processos Químicos"
    When eu tento produzir o relatório total de resíduos cadastrados entre as datas "21/02/2017" e "24/03/2017" para o departamento de "Engenharia Química"
    Then o valor retornado pelo sistema será "500"kg

  @c2
  Scenario: Produzir um relatório mensal para um Departamento / Laboratório / Resíduos  específico.
    Given o sistema possui o departamento de "Engenharia Química" cadastrado
    And o sistema possui o laboratório de "Processos Químicos" cadastrado no departamento de "Engenharia Química"
    And o sistema possui "300" kg de resíduos cadastrados entre entre as datas "21/02/2017" e "21/03/2017" para o laboratorio de "Processos Químicos"
    And o sistema possui "700" kg de resíduos cadastrados entre entre as datas "22/03/2017" e "24/03/2017" para o laboratorio de "Processos Químicos"
    When eu tento produzir o relatório total de resíduos cadastrados entre as datas "21/02/2017" e "21/03/2017" para o departamento de "Engenharia Química"
    Then o valor retornado pelo sistema será "300"kg
  
  @c3
  Scenario: Produzir relatório de resíduos por laboratório entre datas específicas.
    Given que estou na página Geração de Relatórios e eu possuo "300" kg de resíduos cadastrados entre as datas  "21/02/2017" e  "24/03/2017"
    And a opção de gerar por "Laboratório" está selecionada
    And eu vejo uma lista de "Laboratórios" disponíveis no sistema
    And eu seleciono a opção "Laboratório de Processos Químicos" na lista
    And no campo data eu vejo "21/02/2017" para início  e "24/03/2017" para final.
    When eu peço para Gerar Relatório
    And eu vou para a página de resumo de sistema
    Then eu devo visualizar a quantidade de resíduos produzidos, associado ao "Laboratório de Processos Químicos" entre as datas  "21/02/2017" e  "24/03/2017"
  
  @c4
  Scenario: Produzir relatório mensal do total de resíduo(s) para um departamento específico.
    Given que estou na página Geração de Relatórios e eu possuo "500" kg de resíduos cadastrados entre as datas  "21/02/2017" e  "21/03/2017"
    And a opção de gerar por "Departamento" está selecionada
    And eu vejo uma lista de "Departamentos" disponíveis no sistema
    And eu seleciono a opção "Departamento de Engenharia Química" na lista
    And no campo data eu vejo "21/02/2017" para início  e "21/03/2017" para final.
    When eu peço para Gerar Relatório
    And eu vou para a página de resumo de sistema
    Then eu devo visualizar a quantidade de resíduos produzidos, associado ao "Departamento de Engenharia Química" entre as datas  "21/02/2017" e  "21/03/2017"

  @c9
  Scenario: Produzir relatório de múltiplos departamentos (CONTROLLER)
    Given o sistema possui o departamento de "Anatomia Humana" cadastrado com o resíduo "Hidróxido de Amônio" com quantidade total de "150"Kg
    And o sistema possui o departamento de "Biofísica Radiologia" cadastrado com o resíduo "Perclorato de calcio" com quantidade total de "25"Kg
    And o sistema possui o departamento de "Botânica" cadastrado com o resíduo "Sulfato de Amônio" com quantidade total de "100"Kg
    When eu tento gerar um relatório dos resíduos dos departamentos de "Anatomia Humana", "Biofísica Radiologia" e "Botânica"
    Then o sistema retorna o valor de "150"Kg para o resíduo "Hidróxido de Amônio"
    And o sistema retorna o valor de "100"Kg para o resíduo "Sulfato de Amônio"
    And o sistema retorna o valor de "25"Kg para o resíduo "Perclorato de calcio"
    
  @c10
  Scenario: Produzir relatórios com filtros sobre laboratórios (CONTROLLER)
    Given o sistema possui o departamento de "Engenharia Química" cadastrado
    And o sistema possui o laboratório de "Planejamento Avaliação e Síntese de Fármacos" cadastrado no departamento de "Engenharia Química"
    And o resíduo "Ácido Clorídrico" possui tipo como "Liquido Inorganico", peso como "300"Kg e código ONU como "2810" no laboratorio de "Planejamento Avaliação e Síntese de Fármacos"
    When eu tento produzir um relatório dos resíduos do laboratório de "Planejamento Avaliação e Síntese de Fármacos", com os filtros tipo e peso.
    Then o sistema retorna as informações "Liquido Inorganico" e "300"Kg para o resíduo "Ácido Clorídrico"
  
  @c11
  Scenario: Produzir relatório de departamentos sem resíduos cadastrados (GUI)
    Given que foi feito o cadastro do departamento de "Ciências Farmacêuticas" sem nenhum residuo cadastrado
    And que estou na página de Geração de Relatórios
    And a opção de gerar por "Departamento" está selecionada
    And eu vejo uma lista de "Departamentos" disponíveis no sistema
    When eu seleciono a opção "Ciências Farmacêuticas" na lista
    And peço para criar um novo relátorio
    Then eu vejo uma mensagem de notificação informando a inexistência de resíduos ligados aos departamentos.
  
  @c12
  Scenario: Produzir relatório de laboratórios com filtros (GUI)
    Given que foi feito o cadastro do laboratório de "Bioprocessos e Bioprodutos" com o resíduo "Ácido Nítrico" onde o tipo é "Líquido Inorgânico" e a quantidade total é "93"Kg
    And que estou na página de Geração de Relatórios
    And a opção de gerar por "Laboratório" está selecionada
    And eu vejo uma lista de "Laboratórios" disponíveis no sistema
    When eu seleciono a opção "Bioprocessos e Bioprodutos" na lista
    And eu seleciono o filtro "tipo"
    And eu seleciono o filtro "total"
    And peço para criar um novo relátorio
    Then sou redirecionado para a página do relatório de "laboratórios"
    And vejo uma tabela com os dados sobre o Laboratório de "Bioprocessos e Bioprodutos" contendo nome, tipo e quantidade total dos resíduos
    And vejo na coluna nome do residuo "Ácido Nítrico", na coluna tipo "Líquido Inorgânico" e na coluna quantidade total "93"Kg.
  
  @c13
  Scenario: Produzir relatório da coleta corrente (CONTROLLER)
    Given o sistema possui uma nova coleta com "7500"Kg de limite de peso
    And o sistema possui o departamento de "Fisiologia e Farmacologia" cadastrado com o resíduo "Hidróxido de Magnésio" com quantidade total de "33"Kg
    And o sistema possui uma coleta corrente com "7000"Kg de limite de peso
    And o sistema possui o departamento de "Fisiologia e Farmacologia" cadastrado com o resíduo "Hidróxido de Magnésio" com quantidade total de "66"Kg
    And o sistema possui o departamento de "Genética" cadastrado com o resíduo "Acetato de Amônio" com quantidade total de "228"Kg
    When eu tento gerar um relatório da última coleta corrente
    Then o sistema retorna o valor de "66"Kg para o resíduo "Hidróxido de Magnésio"
    And o sistema retorna o valor de "228"Kg para o resíduo "Acetato de Amônio"
    
  @c14
  Scenario: Produzir relatório de resíduos, demostração da união de resíduos semelhantes em departamentos diferentes (CONTROLLER)
    Given o sistema possui o departamento de "Histologia e Embriologia" cadastrado com o resíduo "Benzoato de Benzila" com quantidade total de "123"Kg
    And o sistema possui o departamento de "Micologia" cadastrado com o resíduo "Benzoato de Benzila" com quantidade total de "234"Kg
    And o sistema possui o departamento de "Zoologia" cadastrado com o resíduo "Benzoato de Benzila" com quantidade total de "345"Kg
    When eu tento produzir um relatório do resíduo "Benzoato de Benzila"
    Then o sistema retorna o valor de "702"Kg para o resíduo "Benzoato de Benzila"
    
  @c15
  Scenario: Produzir relatório de multiplos departamentos (GUI)
    Given que foi feito o cadastro do departamento de "Cirurgia" com o resíduo "Iodato de Potássio" e a quantidade total é "32"Kg
    And que foi feito o cadastro do departamento de "Enfermagem" com o resíduo "Álcool Isopropílico" e a quantidade total é "15"Kg
    And que foi feito o cadastro do departamento de "Fonodiaulogia" com o resíduo "Permanganato de Potássio" e a quantidade total é "65"Kg
    And que estou na página de Geração de Relatórios
    And a opção de gerar por "Departamento" está selecionada
    And eu vejo uma lista de "Departamentos" disponíveis no sistema
    When eu seleciono a opção "Cirurgia" na lista
    And eu seleciono a opção "Enfermagem" na lista
    And eu seleciono a opção "Fonodiaulogia" na lista
    And eu seleciono o filtro "total"
    And peço para criar um novo relátorio
    Then sou redirecionado para a página do relatório de "departamentos"
    And vejo uma tabela com os dados sobre os departamento contendo nome do departamento, nome do residuo e quantidade total do resíduo
    And vejo em uma coluna o nome do departamento com "Cirurgia", o nome do residuo com "Iodato de Potássio" e a quantidade total com "32"Kg.
    And vejo em uma coluna o nome do departamento com "Enfermagem", o nome do residuo com "Álcool Isopropílico" e a quantidade total com "15"Kg.
    And vejo em uma coluna o nome do departamento com "Fonodiaulogia", o nome do residuo com "Permanganato de Potássio" e a quantidade total com "65"Kg.
  
  @c16
  Scenario: Produzir relatório com data de inicio posterior a data de fim do intervalo (GUI)
    Given que foi feito o cadastro do laboratório de "Medicina Tropical" com o resíduo "Ácido Bórico" onde o tipo é "Líquido Inorgânico" e a quantidade total é "93"Kg
    And que estou na página de Geração de Relatórios
    And a opção de gerar por "Laboratório" está selecionada
    And eu vejo uma lista de "Laboratórios" disponíveis no sistema
    When eu seleciono a opção "Bioprocessos e Bioprodutos"
    And no campo data eu vejo "23/02/2017" para início  e "21/02/2017" para final.
    And peço para criar um novo relátorio
    Then eu vejo uma mensagem de notificação informando que a data e hora do inicio esta posterior ou iqual a data e hora do final do intervalo requerido.
  