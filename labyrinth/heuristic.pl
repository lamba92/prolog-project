:- dynamic move/3, finalPosition/1, col_num/1, row_num/1, maxDepth/1.

hallowed(nord, pos(R,_)) :-
  R>1.

hallowed(sud, pos(R,_)) :-
  \+row_num(R).

hallowed(ovest, pos(_,C)) :-
  C>1.

hallowed(est, pos(_,C)) :-
  \+col_num(C).

heuristic(pos(X1, Y1), [], L) :-
  finalPosition(pos(X2, Y2)),
  L is abs(X1-X2) + abs(Y1-Y2).
  
limitedDeapthSearch(S, [], _, _) :- finalPosition(S).
limitedDeapthSearch(S, [Action|ListaAzioni], Visitati, L) :-
  L>0,
  hallowed(Action, S),
  move(Action, S, NewS),
  \+member(NewS, Visitati),
  L1 is L-1,
  limitedDeapthSearch(NewS, ListaAzioni, [NewS|Visitati], L1).
