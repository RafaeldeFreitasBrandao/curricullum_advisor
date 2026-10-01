/* Teste de ciclo: a precisa de b e b precisa de a */

:- consult('../src/trilhas').

prerequisito(a, b).
prerequisito(b, a).

teste :-
    (   existe_ciclo(a)
    ->  writeln('ciclo detectado em a')
    ;   writeln('nao detectou ciclo em a')
    ),
    (   existe_ciclo(b)
    ->  writeln('ciclo detectado em b')
    ;   writeln('nao detectou ciclo em b')
    ).