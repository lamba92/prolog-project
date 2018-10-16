:- dynamic dim/1.

heuristic(Stato, Sol, E) :-
  ricorri(Stato, [Stato], 0, 0, E),
  length(Sol, 0).

ricorri(_, [], _, A, A).
ricorri(Stato, [_|T], Pos, In, Out) :-
  distanzaTile(Stato, Pos, Dis),
  Pos2 is Pos + 1,
  In2 is In + Dis,
  ricorri(Stato, T, Pos2, In2, Out).

distanzaTile(Stato, Pos, Dis) :-
  dim(D),
  nth0(Pos, Stato, Elem),
  Elem == v,
  Y is floor(abs((D*D - (Pos + 1))/D)),
  X is mod(abs(D*D - (Pos + 1)), D),
  Dis is X + Y,
  !.

distanzaTile(Stato, Pos, Dis) :-
  dim(D),
  nth0(Pos, Stato, Elem),
  Y is floor(abs((Elem - (Pos + 1))/D)),
  X is mod(abs(Elem - (Pos + 1)), D),
  Dis is X + Y.
