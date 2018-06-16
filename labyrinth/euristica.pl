:- dynamic trasforma/3, finale/1, num_col/1, num_righe/1, maxDepth/1.

hApplicabile(nord, pos(R,_)) :-
  R>1.

hApplicabile(sud, pos(R,_)) :-
  \+num_righe(R).

hApplicabile(ovest, pos(_,C)) :-
  C>1.

hApplicabile(est, pos(_,C)) :-
  \+num_col(C).

euristica(NodoIniziale, Sol, L) :-
  maxDepth(D),
  length(_, L),
  L =< D,
  h_ric_prof_lim(NodoIniziale, Sol, [NodoIniziale], L),
  !.

h_ric_prof_lim(S, [], _, _) :- finale(S).
h_ric_prof_lim(S, [Azione|ListaAzioni], Visitati, L) :-
  L>0,
  hApplicabile(Azione, S),
  trasforma(Azione, S, SNuovo),
  \+member(SNuovo, Visitati),
  L1 is L-1,
  h_ric_prof_lim(SNuovo, ListaAzioni, [SNuovo|Visitati], L1).
