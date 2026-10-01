# Curriculum Advisor (Prolog)
**Alunos:** Arthur Domingues, Carlos Eduardo Aguiar Sacerdote, Gustavo Fagundes e Rafael de Freitas Brandão

Este é um trabalho acadêmico da disciplina de Programação Lógica e Funcional, o objetivo dele é fixar os fundamentos da programação lógica através de um problema concreto. Esse projeto tem como propósito representar a grade curricular do Curso de Ciência da Computação com uma base de conhecimento em Prolog, sendo capaz de responder as seguintes perguntas:

1. "Quais disciplinas eu posso cursar?"
2. "Existe algum caminho válido daqui até a formatura?"

## Como rodar (no VSCode)

### Instalação do Prolog

- Instale o SWI-Prolog: https://www.swi-prolog.org/download/stable
- Durante a instalação marque "adicionar swipl no PATH"

### Adicione a pasta do projeto no VSCode

- Abra o VSCode > Add Folder to workSpace > procure e clique na pasta do projeto.
- Abra o terminal > New Terminal, e rode `swipl --version` para verficar se o SWI-Prolog está funcionando.


### Demonstração

No terminal:

    swipl src/main.pl

No prompt do Prolog (?-):

    demo.

### Testes

No terminal:

    swipl tests/consultas_teste.pl

No prompt do Prolog:

    rodar_testes.

Resultado esperado: 21 de 21 testes passaram.

### Teste de ciclo

No terminal:

    swipl tests/teste_ciclo.pl

No prompt do Prolog:

    teste.

Resultado esperado:

    ciclo detectado em a
    ciclo detectado em b

Para sair do Prolog, digite: halt.

## Consultas úteis

Digitadas no prompt do Prolog, depois de carregar o src/main.pl:

    disciplinas_liberadas(noslen, L).
    disciplinas_pendentes(tremilik, L).
    creditos_cursados(jubileu, T).
    prerequisito_transitivo(programacaoDistribuida, A).
    trilha_valida(noslen, 30, T).
    varias_trilhas(noslen, 30, 3, L).

## Como ele funciona?
O projeto é divido em 3 camadas principais obrigatórias:

1. Camada 1: Construção dos fatos 
2. Camada 2: Implementação das regras de elegibilidade
3. Camada 3: Implementação do fecho transitivo e da geração de trilhas. 

Os outros arquivos dentro do projeto servem para demonstração de cada camada, testes obrigatórios pedidos pelo professor e justificativa de modelagem dos predicados.

## Arquivos

- src/curriculum.pl:--------------------------------- Camada 1, fatos (disciplinas, pré-requisitos e alunos)
- src/elegibilidade.pl:------------------------------ Camada 2, regras de elegibilidade
- src/trilhas.pl:------------------------------------ Camada 3, fecho transitivo e geração de trilhas
- src/main.pl:--------------------------------------- Demonstração de implmentação em cada camada
- tests/consultas_teste.pl: ------------------------- Testes das três camadas
- tests/teste_ciclo.pl: ----------------------------- Teste de detecção de ciclo
- docs/decisoes.md:---------------------------------- Decisões de modelagem e limitações

## Camada 1: Base de Fatos 

A grade curricular foi espelhada na grade do curso de Ciência da Computação na PUC-PR. Existem no total 51 disciplinas na base de fatos, sendo :

- 47 obrigatórias
- 4 eletivas 

Além disso, existem matérias pré-requisitos, ou seja, para você fazer uma discplina do próximo semestre você deve ter passado em uma pré-requisto do semestre passado. Existem no total duas trilhas de matérias com pré-requisito:

1. experienciaCriativaNavegandoComputacao ---> experienciaCriativaCriandoSolucoesComputacionais --->   experienciaCriativaInovandoColaborativamente ---> experienciaCriativaInovandoColaborativamente ---> experienciaCriativaProjetoTransformadorI ---> experienciaCriativaProjetoTransformadorII

2.raciocinioAlgoritimo ---> programacaoImperativa ---> programacaoOrientadaObjetos ---> programacaoLogicaFuncional ---> programacaoDistribuida


### Alunos de teste

Foram criados também 3 perfis de aluno, um adiantado (com mais matérias do que a grade do período), um normal (segue a grade período) e um atrasado (um que não segue a grade do período).


| Aluno    | Perfil       | Créditos cursados |
|----------|--------------|-------------------|
| jubileu  | Adiantado    | 82                |
| noslen   | Ritmo normal | 76                |
| tremilik | Atrasado     | 36                |


## Camada 2: Regras de Elegibilidade

As regras de elegibilidade verificam e ditam quais matérias o aluno pode cursar, sem se preucupar com os semestres seguintes.

| Predicado | O que faz |
|-----------|-----------|
| prerequisitos_ok(Aluno, Disciplina) | Verifica se o aluno já cursou todos os pré-requisitos diretos da disciplina. |
| pode_cursar(Aluno, Disciplina) | Verifica se os pré-requisitos estão ok e o aluno ainda não cursou a disciplina. |
| disciplinas_liberadas(Aluno, Lista) | Lista todas as disciplinas que o aluno pode cursar agora. |
| disciplinas_pendentes(Aluno, Lista) | Lista todas as obrigatórias que o aluno ainda não cursou, liberadas ou não. |
| creditos_cursados(Aluno, Total) | Soma os créditos de todas as disciplinas que o aluno já cursou. |
| somaLista(Lista, Soma) | Auxiliar: soma os números de uma lista por recursão. |

## Camada 3: Fecho Transitivo e Geração de Trilhas

Aqui é onde é validado todos os pré-requisitos de uma disciplina (diretos ou indiretos), e planeja o caminho do aluno até a formatura, semestre a semestre, respeitando os pré-requisitos e o limite de créditos por semestre.

| Predicado | O que faz |
|-----------|-----------|
| prerequisito_transitivo(Disciplina, Ancestral) | Encontra todos os pré-requisitos diretos e indiretos de uma disciplina. |
| transitivo(Disciplina, Ancestral, Visitados) | predicado auxiliar: faz a recursão do fecho transitivo, guardando as disciplinas já visitadas para não entrar em loop. |
| existe_ciclo(Disciplina) | Verdadeiro se a disciplina é pré-requisito dela mesma. |
| trilha_valida(Aluno, MaxCreditoSemestre, Trilha) | Gera uma trilha até a formatura, uma lista de semestres, cada um com uma lista de disciplinas. |
| tracar_Trilha(Cursadas, Max, N, Trilha) | predicado auxiliar: monta a trilha semestre a semestre, até o aluno se formar ou até atingir o limite de 12 semestres. |
| cabe_no_prazo(Cursadas, Max, N) | predicado auxiliar: descarta caminhos em que as obrigatórias que faltam não cabem nos semestres restantes. |
| formou(Cursadas) | Verdadeiro se todas as obrigatórias já foram cursadas. |
| disponivel(Cursadas, Disciplina) | Verifica se a disciplina ainda não foi cursada e todos os seus pré-requisitos já foram. |
| escolher(Disponiveis, Sobra, Semestre) | Escolhe um grupo de disciplinas disponíveis cuja soma de créditos cabe no limite do semestre. |
| varias_trilhas(Aluno, MaxCreditos, Qtd, Lista) | Devolve uma lista com as primeiras Qtd trilhas válidas do aluno. |




## Mais informações

As decisões de modelagem e as limitações estão em docs/decisoes.md.
