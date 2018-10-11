:- ['./tile_game/loader.pl', 'utils.pl'].

start:-
  ricercaID(S),
  write(S).

ricercaID(Sol) :-
  maxDepth(D),
  initialPosition(S),
  length(_, L),
  L =< D,
  write("Depth is "), write(L), write("\n"),
  ric_prof_lim(S, Sol, [S], L),
  write("\n"),
  write(Sol).

ric_prof_lim(S, [], ExpandedNodes, _) :- 
  finalPosition(S),
  length(ExpandedNodes, EN),
  write(EN).

ric_prof_lim(S, [Action|ListaAzioni], Visitati, N) :-
  N>0,
  allowed(Action, S),
  move(Action, S, NewS),
  \+member(NewS, Visitati),
  N1 is N-1,
  ric_prof_lim(NewS, ListaAzioni, [NewS|Visitati], N1).
