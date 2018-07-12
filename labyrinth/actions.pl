:- dynamic col_num/1, row_num/1, occupied/1.

allowed(nord, pos(R,C)) :-
  R>1,
  R1 is R-1,
  \+occupied(pos(R1,C)).

allowed(sud, pos(R,C)) :-
  \+row_num(R),
  R1 is R+1,
  \+occupied(pos(R1,C)).

allowed(ovest, pos(R,C)) :-
  C>1,
  C1 is C-1,
  \+occupied(pos(R,C1)).

allowed(est, pos(R,C)) :-
  \+col_num(C),
  C1 is C+1,
  \+occupied(pos(R,C1)).

move(est, pos(R,C), pos(R, CAdiacente)) :-
  CAdiacente is C+1.
move(ovest, pos(R,C), pos(R, CAdiacente)) :-
  CAdiacente is C-1.
move(nord, pos(R,C), pos(RSopra,C)) :-
  RSopra is R-1.
move(sud, pos(R,C), pos(RSotto,C)) :-
  RSotto is R+1.

maxDepth(D) :-
  row_num(R),
  col_num(L),
  D is R * L.
  
cost(pos(_,_), pos(_, _), Costo) :-
  Costo is 1.
