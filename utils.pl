stampaFrontiera([]).
stampaFrontiera([nodo(S, ListaAzioniPerS, CostoCamminoAttuale, CostoEuristica)|Frontiera]) :-
  H is CostoCamminoAttuale + CostoEuristica,
  write("\n|Nodo: "), write(S), write(" | F: "), write(H),
  write("\n| - lista azioni: "), write(ListaAzioniPerS),
  write("\n| - costo cammino attuale "), write(CostoCamminoAttuale),
  write("\n| - euristica: "), write(CostoEuristica),
  write("\n|"),
  stampaFrontiera(Frontiera).

stampaFrontieraConP([]).
stampaFrontieraConP([nodo(S, ListaAzioniPerS, CostoCamminoAttuale, CostoEuristica, ProfonditaS)|Frontiera]) :-
  H is CostoCamminoAttuale + CostoEuristica,
  write("\n|Nodo: "), write(S), write(" | F: "), write(H),
  write("\n| - lista azioni: "), write(ListaAzioniPerS),
  write("\n| - costo cammino attuale "), write(CostoCamminoAttuale),
  write("\n| - euristica: "), write(CostoEuristica),
  write("\n| - profondita': "), write(ProfonditaS),
  write("\n|"),
  stampaFrontieraConP(Frontiera).

% appendOrdinata(ListaFigliS, Frontiera, NuovaFrontiera)
%                 input        input        output
appendOrdinata([], F, F).
appendOrdinata([Figlio|AltriFigli], Frontiera, NuovaFrontiera) :-
  checkDuplicate(Figlio, Frontiera, FrontieraIntermedia1),
  orderedInsert(Figlio, FrontieraIntermedia1, FrontieraIntermedia2),
  appendOrdinata(AltriFigli, FrontieraIntermedia2, NuovaFrontiera),
  !.
appendOrdinata([_|AltriFigli], Frontiera, NuovaFrontiera) :-
  appendOrdinata(AltriFigli, Frontiera, NuovaFrontiera).

% checkDuplicate(FiglioDaControllare, Frontiera, NuovaFrontiera)
%                    input              input       output
% Serve ad evitare di inserire lo stesso nodo nella frontiera. Se il
% nodo fornito è presente in frontiera e migliore per cammino minimo,
% viene cancellato il nodo già presente nella frontiera, se il nodo
% non è presente in frontiera torna true, se il nodo è prensete in
% frontiera con costo minore di quello attualmente fornito torna
% false
checkDuplicate(_, [], []).
checkDuplicate(nodo(N, _, C, _, _),
               [nodo(N, _, C1, _, _)|AltriNodi],
               AltriNodi) :-
  C =< C1,
  !.
checkDuplicate(nodo(N, _, C, _),
               [nodo(N, _, C1, _)|AltriNodi],
               AltriNodi) :-
  C =< C1,
  !.
checkDuplicate(A, [N|Rest], [N|Rest0]) :-
  checkDuplicate(A, Rest, Rest0),
  !.

% insert(Nodo, Frontiera, NuovaFrontiera)
%         in      in           out
orderedInsert(X, [], [X]).
orderedInsert(nodo(N, ListaAzioniPerS, C, S, D),
              [nodo(N1, ListaAzioniPerS1, C1, S1, D1)|Rest],
              [nodo(N, ListaAzioniPerS, C, S, D)|[nodo(N1, ListaAzioniPerS1, C1, S1, D1)|Rest]]) :-
  C + S < C1 + S1,
  !.
orderedInsert(nodo(S, ListaAzioniPerS, C, S, D),
              [nodo(S1, ListaAzioniPerS1, C1, S1, D1)|Rest],
              [nodo(S, ListaAzioniPerS, C, S, D)|[nodo(S1, ListaAzioniPerS1, C1, S1, D1)|Rest]]) :-
  C + S == C1 + S1,
  C < C1,
  !.
orderedInsert(X, [Y|Rest0], [Y|Rest]) :-
  orderedInsert(X, Rest0, Rest),
  !.

n_factorial(0, 1).
n_factorial(N, F) :-
  N>0,
  N1 is N-1,
  n_factorial(N1,F1),
  F is N * F1.

setElement([_|Tail],0,X,[X|Tail]):-!.
setElement([Head|Tail],Pos,X,[Head|NuovaTail]):-
  Pos1 is Pos-1,
  setElement(Tail,Pos1,X,NuovaTail).
