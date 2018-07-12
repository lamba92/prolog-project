:- dynamic move/3, allowed/2, finale/1, initialPosition/1.

ricercaProfondita(Sol) :-
  initialPosition(S),
  ric_prof(S, Sol, [S]),
  write(Sol).

ricercaProfLim(N, Sol) :-
  initialPosition(S),
  ric_prof_lim(S, Sol, [S], N),
  write("\n"),
  write(Sol).

ric_prof(S, _, _) :- finale(S), !.
ric_prof(S, [Action|ListaAzioni], Visitati) :-
  allowed(Action, S),
  move(Action, S, NewS),
  \+member(NewS, Visitati),
  ric_prof(NewS, ListaAzioni, [NewS|Visitati]).

ric_prof_lim(S, [], _, _) :- finale(S).
ric_prof_lim(S, [Action|ListaAzioni], Visitati, N) :-
  N>0,
  allowed(Action, S),
  move(Action, S, NewS),
  \+member(NewS, Visitati),
  N1 is N-1,
  ric_prof_lim(NewS, ListaAzioni, [NewS|Visitati], N1).
