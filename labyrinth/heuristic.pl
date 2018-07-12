:- dynamic move/3, finalPosition/1, col_num/1, row_num/1, maxDepth/1.

hallowed(nord, pos(R,_)) :-
  R>1.

hallowed(sud, pos(R,_)) :-
  \+row_num(R).

hallowed(ovest, pos(_,C)) :-
  C>1.

hallowed(est, pos(_,C)) :-
  \+col_num(C).

heuristic(NodoIniziale, Sol, L) :-
  maxDepth(D),
  length(_, L),
  L =< D,
  limitedDeapthSearch(NodoIniziale, Sol, [NodoIniziale], L),
  !.

limitedDeapthSearch(S, [], _, _) :- finalPosition(S).
limitedDeapthSearch(S, [Action|ListaAzioni], Visitati, L) :-
  L>0,
  hallowed(Action, S),
  move(Action, S, NewS),
  \+member(NewS, Visitati),
  L1 is L-1,
  limitedDeapthSearch(NewS, ListaAzioni, [NewS|Visitati], L1).
