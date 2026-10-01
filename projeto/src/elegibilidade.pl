/*Camada 2: Regras de Elegibilidade*/


/* Verifica se o aluno já cursou todos as matérias de pré-requisito daquela matéria */
prerequisitos_ok(Aluno, Disciplina) :-
    aluno(Aluno),
    disciplina(Disciplina, _, _, _),              
    forall(prerequisito(Disciplina, Pre),         
           cursou(Aluno, Pre)).

/* Verifica se o aluno cumpriu as matérias de pré-requisito, e ainda não cursou a matéria */
pode_cursar(Aluno, Disciplina) :-
    prerequisitos_ok(Aluno, Disciplina),
    \+ cursou(Aluno, Disciplina).

/* Junta em uma lista todas as matérias que o aluno pode cursar agora (com exceção das pré-requisitos) */
disciplinas_liberadas(Aluno, Lista) :-
    aluno(Aluno),
    findall(Disciplina,pode_cursar(Aluno,Disciplina), Lista).
    
/* Junta em uma lista todas as disciplinas pendentes/faltantes obrigatórias do curso */
disciplinas_pendentes(Aluno, Lista) :-
    aluno(Aluno),
    findall(Disciplina, (disciplina(Disciplina, obrigatoria, _, _),
                         \+ cursou(Aluno, Disciplina)),
            		     Lista).

/* Soma os números de uma lista de forma recursiva */
somaLista([], 0).
somaLista([Head|Tail], Soma) :-
    somaLista(Tail, SomaTail),
    Soma is Head + SomaTail.

/* Junta todos os créditos que o aluno cursou, somando com o "somaLista" */
creditos_cursados(Aluno, Total) :-
    aluno(Aluno),
    findall(Creditos, (cursou(Aluno, Disciplina),
    					disciplina(Disciplina, _, Creditos, _)),
            		     Lista),
    				 somaLista(Lista, Total).