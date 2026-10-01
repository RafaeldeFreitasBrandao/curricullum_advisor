
/*Camada 3*/

/* Encontra todos os pré-requisitos de uma matéria, sendo direto ou indireto*/

prerequisito_transitivo(Disciplina, Ancestral) :-
    transitivo(Disciplina, Ancestral, [Disciplina]).

transitivo(Disciplina, Ancestral, _) :-
    prerequisito(Disciplina, Ancestral).

transitivo(Disciplina, Ancestral, Visitados) :-
    prerequisito(Disciplina, Pre),
    \+ member(Pre, Visitados),
    transitivo(Pre, Ancestral, [Pre|Visitados]).

/*Verifica se uma matéria é pré-requisito dela mesma */
existe_ciclo(Disciplina):-
    prerequisito_transitivo(Disciplina,  Disciplina).

/* Confere se o aluno existe, e pega o histórico dele pelo "tracar_Trilha" */
trilha_valida(Aluno, MaxCreditoSemestre, Trilha):-
    aluno(Aluno),
    findall(Disciplina, cursou(Aluno, Disciplina), JaCursadas),
    tracar_Trilha(JaCursadas, MaxCreditoSemestre, 1, Trilha).

/* Verifica se o aluno já se formou*/
tracar_Trilha(JaCursadas, _, _, []):-
    formou(JaCursadas).

/*Monta uma trilha para cada semestre */
tracar_Trilha(JaCursadas, MaxCreditoSemestre, N, [Semestre| Trilha]):-
    (   N =< 12 ),
    cabe_no_prazo(JaCursadas, MaxCreditoSemestre, N),
	findall(Disciplina, disponivel(JaCursadas, Disciplina), Disponiveis),
    escolher(Disponiveis, MaxCreditoSemestre,Semestre),
    Semestre \=[],
    append(JaCursadas, Semestre, Novas),
    N1 is N + 1,
    tracar_Trilha(Novas, MaxCreditoSemestre, N1, Trilha).


cabe_no_prazo(JaCursadas, Max, N) :-
    findall(Cr, (disciplina(D, obrigatoria, Cr, _), \+ member(D, JaCursadas)), L),
    somaLista(L, Falta),
    Falta =< Max * (13 - N),
    forall((disciplina(D2, obrigatoria, Cr2, _), \+ member(D2, JaCursadas)),
           Cr2 =< Max).

/* É verdadeiro se todas as disciplinas obrigatórias ja forma cursadas */
formou(JaCursadas):-
    forall(disciplina(Disciplina, obrigatoria, _, _),
           member(Disciplina, JaCursadas)).

/* É verdadeira se uma disciplina não foi cursada, mas seus pre-requisitos já */
disponivel(JaCursadas, Disciplina):-
    disciplina(Disciplina, _, _, _),
    \+ member(Disciplina, JaCursadas),
    forall(prerequisito(Disciplina, Pre), member(Pre, JaCursadas)).


/* Escolhe um conjunto de matérias disponíveis que cabem na sobra de créditos do semestre. É aqui que é geredo combinções diferentes  */
escolher([], _, []).

escolher([Disciplina|Resto], Sobra, [Disciplina|Semestre]) :-
    disciplina(Disciplina, _, Creditos, _),
    Creditos =< Sobra,
    NovaSobra is Sobra - Creditos,
    escolher(Resto, NovaSobra, Semestre).

escolher([_|Resto], Sobra, Semestre) :-
    escolher(Resto, Sobra, Semestre).
        
/* Junta em uma lista, todas as trilhas válidas */
varias_trilhas(Aluno, MaxCreditoSemestre, QuantidadeTrilhas, Lista):-
    findall(Trilha,
            limit(QuantidadeTrilhas, trilha_valida(Aluno, MaxCreditoSemestre, Trilha)),
            Lista).