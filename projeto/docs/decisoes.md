# Decisões de Modelagem

## Dados da base

- 51 disciplinas, em 8 semestres
- 4 disciplinas eletivas
- 8 fatos de pré-requisito
- 2 cadeias de pré-requisitos com profundidade 4
- 3 alunos de teste

## Camada 1: Fatos

- Cada pré-requisito é um fato prerequisito/2 separado, em vez de uma lista
  dentro de um fato. Isso deixa as consultas mais simples.

- Existe o fato aluno/1. Com ele, consultas com aluno inexistente falham
  sem gerar erro.

## Camada 2: Elegibilidade

- Foi usado findall/3 porque as listas não precisam de ordenação e não
  geram repetidos nesta base.

- O setof/3 aparece apenas nos testes, para comparar listas ordenadas.

- A negação por falha (\+ cursou) só é chamada depois que o aluno e a
  disciplina já têm valor. Antes disso, o resultado seria imprevisível.

- O forall/2 é usado só para verificar se todos os pré-requisitos foram
  cursados. Ele não coleta valores.

## Camada 3: Fecho transitivo e trilhas

- O prerequisito_transitivo guarda uma lista de disciplinas já visitadas.
  Isso evita loop infinito se a base tiver ciclo.

- O existe_ciclo/1 verifica se uma disciplina é pré-requisito dela mesma.
  O teste está em tests/teste_ciclo.pl.

- Não foi usado assert/retract. A lista de disciplinas cursadas é passada
  de um semestre para o outro, e o backtracking desfaz as escolhas
  sozinho.

- A busca tem limite de 12 semestres, para não explodir em tempo e memória.
- Para formar, só as disciplinas obrigatórias contam. As eletivas podem
  aparecer na trilha, mas não são exigidas.

- A trilha confere só os pré-requisitos diretos. Como as disciplinas entram
  em ordem, os indiretos já foram cursados antes.

- O varias_trilhas/4 usa limit/2 para devolver apenas algumas trilhas.

## Limitações conhecidas

- A grade tem poucos pré-requisitos (8), apesar de grade real não ter pré-requisitos.

- As trilhas diferentes variam pouco entre si. Por exemplo, algumas só
  dividem o último semestre.

- O limite de 12 semestres está escrito direto no código.

- O aluno com trancamento não está modelado. Só existe o aluno atrasado.