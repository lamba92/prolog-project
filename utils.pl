stampaFrontiera([]).
stampaFrontiera([node(S, ActionsListForS, ActualPathCost, HeuristicCost)|Frontier]) :-
  H is ActualPathCost + HeuristicCost,
  write("\n|Node: "), write(S), write(" | F: "), write(H),
  write("\n| - lista azioni: "), write(ActionsListForS),
  write("\n| - costo cammino attuale "), write(ActualPathCost),
  write("\n| - heuristic: "), write(HeuristicCost),
  write("\n|"),
  stampaFrontiera(Frontier).

stampaFrontieraConP([]).
stampaFrontieraConP([node(S, ActionsListForS, ActualPathCost, HeuristicCost, DepthOfS)|Frontier]) :-
  H is ActualPathCost + HeuristicCost,
  write("\n|Node: "), write(S), write(" | F: "), write(H),
  write("\n| - lista azioni: "), write(ActionsListForS),
  write("\n| - costo cammino attuale "), write(ActualPathCost),
  write("\n| - heuristic: "), write(HeuristicCost),
  write("\n| - profondita': "), write(DepthOfS),
  write("\n|"),
  stampaFrontieraConP(Frontier).

% appendOrdinata(SChilderenList, Frontier, NewFrontier)
%                 input        input        output
appendOrdinata([], F, F).
appendOrdinata([Figlio|OtherChildren], Frontier, NewFrontier) :-
  checkDuplicate(Figlio, Frontier, FrontieraIntermedia1),
  orderedInsert(Figlio, FrontieraIntermedia1, FrontieraIntermedia2),
  appendOrdinata(OtherChildren, FrontieraIntermedia2, NewFrontier),
  !.
appendOrdinata([_|OtherChildren], Frontier, NewFrontier) :-
  appendOrdinata(OtherChildren, Frontier, NewFrontier).

% checkDuplicate(FiglioDaControllare, Frontier, NewFrontier)
%                    input              input       output
% Serve ad evitare di inserire lo stesso nodo nella frontiera. Se il
% nodo fornito è presente in frontiera e migliore per cammino minimo,
% viene cancellato il nodo già presente nella frontiera, se il nodo
% non è presente in frontiera torna true, se il nodo è presente in
% frontiera con costo minore di quello attualmente fornito torna
% false
checkDuplicate(_, [], []).
checkDuplicate(node(N, _, C, _, _),
               [node(N, _, C1, _, _)|AltriNodi],
               AltriNodi) :-
  C =< C1,
  !.
checkDuplicate(node(N, _, C, _),
               [node(N, _, C1, _)|AltriNodi],
               AltriNodi) :-
  C =< C1,
  !.
checkDuplicate(A, [N|Rest], [N|Rest0]) :-
  checkDuplicate(A, Rest, Rest0),
  !.

% insert(Node, Frontier, NewFrontier)
%         in      in           out
orderedInsert(X, [], [X]).
orderedInsert(node(N, ActionsListForS, C, S, D),
              [node(N1, ListaAzioniPerS1, C1, S1, D1)|Rest],
              [node(N, ActionsListForS, C, S, D)|[node(N1, ListaAzioniPerS1, C1, S1, D1)|Rest]]) :-
  C + S < C1 + S1,
  !.
orderedInsert(node(S, ActionsListForS, C, S, D),
              [node(S1, ListaAzioniPerS1, C1, S1, D1)|Rest],
              [node(S, ActionsListForS, C, S, D)|[node(S1, ListaAzioniPerS1, C1, S1, D1)|Rest]]) :-
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
