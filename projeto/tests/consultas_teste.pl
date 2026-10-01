/*Testes*/

:- consult('../src/curriculum').
:- consult('../src/elegibilidade').
:- consult('../src/trilhas').

:- discontiguous caso/2, teste/1.


/*EXECUTOR DOS TESTES*/

rodar_testes :-
    format("~n===== BATERIA DE TESTES =====~n"),
    forall(caso(Id, Descricao), rodar(Id, Descricao)),
    findall(Id, caso(Id, _), Todos),           length(Todos, Total),
    findall(Id, (caso(Id, _), passou(Id)), Ok), length(Ok, NOk),
    format("=============================~n"),
    format("~w de ~w testes passaram.~n", [NOk, Total]).

rodar(Id, Descricao) :-
    catch(( call_with_time_limit(10, teste(Id)) -> R = ok ; R = falhou ),
          Erro,
          R = erro(Erro)),
    mostrar(R, Descricao).

mostrar(ok,      D) :- format("[OK]     ~w~n", [D]).
mostrar(falhou,  D) :- format("[FALHOU] ~w~n", [D]).
mostrar(erro(E), D) :- format("[ERRO]   ~w~n         -> ~q~n", [D, E]).

passou(Id) :- catch(call_with_time_limit(10, teste(Id)), _, fail), !.


/*CAMADA 1: BASE DE FATOS*/

caso(c1_semestre4,    'C1: disciplinas do 4o semestre sugerido').
caso(c1_minimo20,     'C1: base tem pelo menos 20 disciplinas').
caso(c1_seis_sem,     'C1: base cobre pelo menos 6 semestres').
caso(c1_tres_elet,    'C1: base tem pelo menos 3 eletivas').

teste(c1_semestre4) :-
    findall(D, disciplina(D, _, _, 4), Lista),
    Lista == [teologiaSociedade, resolucaoProblemasEstruturadosComputacao,
              programacaoLogicaFuncional, bigData,
              sistemasOperacionaisCiberfisicos, redesConvergentes,
              modelagemSistemasComputacionais].

teste(c1_minimo20) :-
    findall(D, disciplina(D, _, _, _), L),
    length(L, N),
    N >= 20.

teste(c1_seis_sem) :-
    setof(S, D^T^C^disciplina(D, T, C, S), Semestres),
    length(Semestres, N),
    N >= 6.

teste(c1_tres_elet) :-
    findall(D, disciplina(D, eletiva, _, _), L),
    length(L, N),
    N >= 3.

/*CAMADA 2: REGRAS DE ELEGIBILIDADE*/

caso(c2_liberadas_diferentes, 'C2: liberadas de noslen e tremilik sao diferentes').
caso(c2_qtd_liberadas,        'C2: noslen tem 30 liberadas, tremilik tem 38').
caso(c2_qtd_pendentes,        'C2: noslen tem 30 pendentes, tremilik tem 39').
caso(c2_negacao_decisiva,     'C2: \\+ cursou decide pode_cursar (POO: tremilik sim, noslen nao)').
caso(c2_prereq_bloqueia,      'C2: tremilik NAO pode cursar EC Inovando (falta pre-requisito)').
caso(c2_creditos,             'C2: creditos cursados (noslen=76, tremilik=36, jubileu=82)').
caso(c2_inexistente_liberadas,'C2: aluno inexistente -> disciplinas_liberadas falha limpo').
caso(c2_inexistente_pode,     'C2: aluno inexistente -> pode_cursar falha limpo').

teste(c2_liberadas_diferentes) :-
    disciplinas_liberadas(noslen, L1),
    disciplinas_liberadas(tremilik, L2),
    L1 \== L2.

teste(c2_qtd_liberadas) :-
    disciplinas_liberadas(noslen, L1),   length(L1, 30),
    disciplinas_liberadas(tremilik, L2), length(L2, 38).

teste(c2_qtd_pendentes) :-
    disciplinas_pendentes(noslen, P1),   length(P1, 30),
    disciplinas_pendentes(tremilik, P2), length(P2, 39).

teste(c2_negacao_decisiva) :-
    pode_cursar(tremilik, programacaoOrientadaObjetos),
    \+ pode_cursar(noslen, programacaoOrientadaObjetos).

teste(c2_prereq_bloqueia) :-
    \+ pode_cursar(tremilik, experienciaCriativaInovandoColaborativamente).

teste(c2_creditos) :-
    creditos_cursados(noslen, 76),
    creditos_cursados(tremilik, 36),
    creditos_cursados(jubileu, 82).

teste(c2_inexistente_liberadas) :-
    \+ disciplinas_liberadas(fulano, _).

teste(c2_inexistente_pode) :-
    \+ pode_cursar(fulano, _).


/*CAMADA 3: FECHO TRANSITIVO E TRILHAS*/

caso(c3_transitivo_ec,     'C3: ancestrais de Projeto Transformador II (cadeia de profundidade 4)').
caso(c3_transitivo_prog,   'C3: ancestrais de Programacao Distribuida (cadeia de profundidade 4)').
caso(c3_sem_prereq,        'C3: disciplina sem pre-requisito nao tem ancestrais').
caso(c3_sem_ciclo,         'C3: base correta nao tem ciclo').
caso(c3_trilha_noslen,     'C3: trilha_valida(noslen, 30) e uma trilha correta ate a formatura').
caso(c3_trilha_tremilik,   'C3: trilha_valida(tremilik, 20) e uma trilha correta ate a formatura').
caso(c3_varias_trilhas,    'C3: varias_trilhas devolve 3 trilhas distintas e corretas').
caso(c3_limite_impossivel, 'C3: limite de 4 creditos e impossivel -> falha (sem travar)').
caso(c3_aluno_inexistente, 'C3: trilha para aluno inexistente falha limpo').

teste(c3_transitivo_ec) :-
    setof(A, prerequisito_transitivo(experienciaCriativaProjetoTransformadorII, A), L),
    L == [experienciaCriativaCriandoSolucoesComputacionais,
          experienciaCriativaInovandoColaborativamente,
          experienciaCriativaNavegandoComputacao,
          experienciaCriativaProjetoTransformadorI].

teste(c3_transitivo_prog) :-
    setof(A, prerequisito_transitivo(programacaoDistribuida, A), L),
    L == [programacaoImperativa, programacaoLogicaFuncional,
          programacaoOrientadaObjetos, raciocinioAlgoritimo].

teste(c3_sem_prereq) :-
    \+ prerequisito_transitivo(filosofia, _).

teste(c3_sem_ciclo) :-
    \+ existe_ciclo(_).

teste(c3_trilha_noslen) :-
    trilha_valida(noslen, 30, T), !,
    trilha_correta(noslen, 30, T).

teste(c3_trilha_tremilik) :-
    trilha_valida(tremilik, 20, T), !,
    trilha_correta(tremilik, 20, T).

teste(c3_varias_trilhas) :-
    varias_trilhas(noslen, 30, 3, Trilhas),
    length(Trilhas, 3),
    sort(Trilhas, SemRepetir), length(SemRepetir, 3),
    forall(member(T, Trilhas), trilha_correta(noslen, 30, T)).

teste(c3_limite_impossivel) :-
    \+ trilha_valida(noslen, 4, _).

teste(c3_aluno_inexistente) :-
    \+ trilha_valida(fulano, 30, _).

/*VERIFICADOR DE TRILHA*/

trilha_correta(Aluno, Max, Trilha) :-
    length(Trilha, NSem),
    NSem =< 12,
    findall(D, cursou(Aluno, D), Historico),
    semestres_corretos(Trilha, Max, Historico, Final),
    forall(disciplina(D, obrigatoria, _, _),
           memberchk(D, Final)).

semestres_corretos([], _, Feitas, Feitas).
semestres_corretos([Sem|Resto], Max, Feitas, Final) :-
    Sem \== [],
    is_set(Sem),
    creditos_semestre(Sem, C), C =< Max,
    forall(member(D, Sem),
           ( \+ memberchk(D, Feitas),
             forall(prerequisito_transitivo(D, P),
                    memberchk(P, Feitas)) )),
    append(Feitas, Sem, Feitas1),
    semestres_corretos(Resto, Max, Feitas1, Final).

creditos_semestre(Sem, Total) :-
    findall(C, (member(D, Sem), disciplina(D, _, C, _)), Cs),
    sum_list(Cs, Total).