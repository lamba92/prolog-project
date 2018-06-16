ricercaProfondita(Sol) :-
  iniziale(S),
  ric_prof(S, Sol, [S]),
  write(Sol).

ricercaProfLim(N, Sol) :-
  iniziale(S),
  ric_prof_lim(S, Sol, [S], N),
  write("\n"),
  write(Sol).

ric_prof(S, _, _) :- finale(S), !.
ric_prof(S, [Azione|ListaAzioni], Visitati) :-
  applicabile(Azione, S),
  trasforma(Azione, S, SNuovo),
  \+member(SNuovo, Visitati),
  ric_prof(SNuovo, ListaAzioni, [SNuovo|Visitati]).

ric_prof_lim(S, [], _, _) :- finale(S).
ric_prof_lim(S, [Azione|ListaAzioni], Visitati, N) :-
  N>0,
  applicabile(Azione, S),
  trasforma(Azione, S, SNuovo),
  \+member(SNuovo, Visitati),
  N1 is N-1,
  ric_prof_lim(SNuovo, ListaAzioni, [SNuovo|Visitati], N1).
