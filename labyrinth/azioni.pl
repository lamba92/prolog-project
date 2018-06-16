:- dynamic num_col/1, num_righe/1, occupata/1.

applicabile(nord, pos(R,C)) :-
  R>1,
  R1 is R-1,
  \+occupata(pos(R1,C)).

applicabile(sud, pos(R,C)) :-
  \+num_righe(R),
  R1 is R+1,
  \+occupata(pos(R1,C)).

applicabile(ovest, pos(R,C)) :-
  C>1,
  C1 is C-1,
  \+occupata(pos(R,C1)).

applicabile(est, pos(R,C)) :-
  \+num_col(C),
  C1 is C+1,
  \+occupata(pos(R,C1)).

trasforma(est, pos(R,C), pos(R, CAdiacente)) :-
  CAdiacente is C+1.
trasforma(ovest, pos(R,C), pos(R, CAdiacente)) :-
  CAdiacente is C-1.
trasforma(nord, pos(R,C), pos(RSopra,C)) :-
  RSopra is R-1.
trasforma(sud, pos(R,C), pos(RSotto,C)) :-
  RSotto is R+1.

maxDepth(D) :-
  num_righe(R),
  num_col(L),
  D is R * L.
  
costoPasso(pos(_,_), pos(_, _), Costo) :-
  Costo is 1.
