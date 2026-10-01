/* main.pl */
:- consult(curriculum).
:- consult(elegibilidade).
:- consult(trilhas).  


/* Demonsttração da camada 1 */

demo_camada_1:-
    format("-- CAMADA 1: BASE DE FATOS --~n"),
    format("-------------------------------~n"),
	findall(Disciplina,disciplina(Disciplina, _, _, 4), Lista),
	format(" DISCIPLINAS DO 4o SEMESTRE ~n"),
    format("-------------------------------~n"),
	forall(member(Disciplina, Lista),
           format(" - ~w~n", [Disciplina])).

/* Demonsttração da camada 2 */

demo_camada_2 :-
    format("-- CAMADA 2: REGRAS DE ELEGIBILIDADE --~n"),
    format("--------------------------------~n"),
    disciplinas_liberadas(noslen, Liberadas),
    format(" DISCIPLINAS LIBERADAS DO NOSLEN ~n"),
    format("--------------------------------~n"),
    forall(member(Disciplina, Liberadas),
           format(" - ~w~n", [Disciplina])),
    format("--------------------------------~n"),
    disciplinas_pendentes(noslen, Pendentes),
    format(" DISCIPLINAS PENDENTES DO NOSLEN ~n"),
    format("--------------------------------~n"),
    forall(member(Disciplina, Pendentes),
           format(" - ~w~n", [Disciplina])),
    format("--------------------------------~n"),
    creditos_cursados(noslen, CreditosCursados),
    format("  CREDITOS DO NOSLEN ~n"),
    format("--------------------------------~n"),
    format(" Creditos Cursados - ~w~n", [CreditosCursados]),
    format("--------------------------------~n").


/* Demonsttração da camada 3 */

demo_camada_3 :-
    format("-- CAMADA 3: GERAÇÃO DE TRILHAS --~n"),
    format("--------------------------------~n"),
    
    findall(Ancestral,
            prerequisito_transitivo(experienciaCriativaProjetoTransformadorII, Ancestral),
            Ancestrais),
    format(" PRE-REQUISITOS (DIRETOS E INDIRETOS) DE PROJETO TRANSFORMADOR II ~n"),
    format("--------------------------------~n"),
    forall(member(Disciplina, Ancestrais),
           format(" - ~w~n", [Disciplina])),
    
    format("--------------------------------~n"),
    format(" VERIFICACAO DE CICLOS ~n"),
    format("--------------------------------~n"),
    (   existe_ciclo(DisciplinaCiclo)
    ->  format(" Ciclo encontrado em: ~w~n", [DisciplinaCiclo])
    ;   format(" Nenhum ciclo na base de pre-requisitos.~n")
    ),
    format("--------------------------------~n"),
    format(" UMA TRILHA VALIDA DO NOSLEN (MAX. 30 CREDITOS) ~n"),
    format("--------------------------------~n"),
    (   trilha_valida(noslen, 30, Trilha)
    ->  imprimir_trilha(Trilha)
    ;   format(" Nenhuma trilha encontrada.~n")
    ),
    
    format("--------------------------------~n"),
    format(" VARIAS TRILHAS DO NOSLEN (3 TRILHAS) ~n"),
    format("--------------------------------~n"),
    varias_trilhas(noslen, 30, 3, Trilhas),
    forall(nth1(Numero, Trilhas, T),
           (   format(" Trilha ~w:~n", [Numero]),
               imprimir_trilha(T)
           )).
    
    imprimir_trilha(Trilha) :-
    forall(nth1(N, Trilha, Semestre),
           format("   Semestre ~w: ~w~n", [N, Semestre])).
    

/* Chama todos os outros demos em um  */
demo_main :-
    demo_camada_1,
    demo_camada_2,
    demo_camada_3.


/* Chama o demo_main  */
demo :-
    demo_main.
    

