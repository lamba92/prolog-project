:- dynamic n_factorial/2, setElement/4, dim/1.

allowed(nord, Stato) :-
  dim(D),
  nth0(P_, Stato, v),
  P is P_ + 1,
  P>D.

allowed(sud, Stato) :-
  dim(D),
  nth0(P_, Stato, v),
  P is P_ + 1,
  P =< (D * D) - D.

allowed(ovest, Stato) :-
  dim(D),
  nth0(P, Stato, v),
  M is mod(P + 1, D),
  M =\= 1.

allowed(est, Stato) :-
  dim(D),
  nth0(P, Stato, v),
  M is mod(P + 1, D),
  M =\= 0.
  

move(est, S, NewS) :-
  nth0(OldP, S, v),
  NewP is OldP + 1,
  swap(S, OldP, NewP, NewS).
move(ovest, S, NewS) :-
  nth0(OldP, S, v),
  NewP is OldP - 1,
  swap(S, OldP, NewP, NewS).
move(nord, S, NewS) :-
  dim(D),
  nth0(OldP, S, v),
  NewP is OldP - D,
  swap(S, OldP, NewP, NewS).
move(sud, S, NewS) :-
  dim(D),
  nth0(OldP, S, v),
  NewP is OldP + D,
  swap(S, OldP, NewP, NewS).

maxDepth(Md) :-
  dim(D),
  Md is D*100.
  %n_factorial(D, F),
  %Md is F / 2.

cost(_, _, Costo) :-
  Costo is 1.

% swap(Lista,Pos1,Pos2,NuovaLista)
swap(Lista,Pos1,Pos2,NuovaLista):-
  nth0(Pos1, Lista, X1),
  nth0(Pos2, Lista, X2),
  setElement(Lista,Pos2,X1,Temp),
  setElement(Temp,Pos1,X2,NuovaLista).
