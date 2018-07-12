:- dynamic move/3, finale/1, num_col/1, num_righe/1, maxDepth/1.

hallowed(nord, pos(R,_)) :-
  R>1.

hallowed(sud, pos(R,_)) :-
  \+num_righe(R).

hallowed(ovest, pos(_,C)) :-
  C>1.

hallowed(est, pos(_,C)) :-
  \+num_col(C).

heuristic(NodoIniziale, Sol, L) :-
  maxDepth(D),
  length(_, L),
  L =< D,
  h_ric_prof_lim(NodoIniziale, Sol, [NodoIniziale], L),
  !.

h_ric_prof_lim(S, [], _, _) :- finale(S).
h_ric_prof_lim(S, [Action|ListaAzioni], Visitati, L) :-
  L>0,
  hallowed(Action, S),
  move(Action, S, NewS),
  \+member(NewS, Visitati),
  L1 is L-1,
  h_ric_prof_lim(NewS, ListaAzioni, [NewS|Visitati], L1).
