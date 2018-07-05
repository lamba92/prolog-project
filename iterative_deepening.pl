:- ['./tile_game/loader.pl', 'utils.pl'].

start:-
  ricercaID(S),
  write(S).

ricercaID(Sol) :-
  maxDepth(D),
  iniziale(S),
  length(_, L),
  L =< D,
  write("Depth is "), write(L), write("\n"),
  ric_prof_lim(S, Sol, [S], L),
  write("\n"),
  write(Sol).

ric_prof_lim(S, [], _, _) :- finale(S).
ric_prof_lim(S, [Azione|ListaAzioni], Visitati, N) :-
  N>0,
  applicabile(Azione, S),
  trasforma(Azione, S, SNuovo),
  \+member(SNuovo, Visitati),
  N1 is N-1,
  ric_prof_lim(SNuovo, ListaAzioni, [SNuovo|Visitati], N1).
