:- ['./labyrinth/loader.pl'].

ricercaID2(Sol) :-
  maxDepth(D),
  length(_, L),
  L =< D;
  write("Depth is "),
  write(L),
  write("\n"),
  ricercaProfLim(L, Sol).

ricercaID(Sol) :-
  ricerca_id(1, Sol),
  write("\nSolution found.").

ricerca_id(D, Sol) :-
  write("Depth is: "),
  write(D),
  \+ricercaProfLim(D, Sol),
  Tmp is D+1,
  write(" | Tmp is now set to: "),
  write(Tmp),
  write("\n"),
  Tmp<100,
  \+ricerca_id(Tmp, Sol).

ricercaProfLim(N, Sol) :-
  iniziale(S),
  ric_prof_lim(S, Sol, [S], N),
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
