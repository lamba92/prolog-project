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

setElement([_|Tail],0,X,[X|Tail]):-!.
setElement([Head|Tail],Pos,X,[Head|NuovaTail]):-
  Pos1 is Pos-1,
  setElement(Tail,Pos1,X,NuovaTail).

comparator_a_star(R, node(_, _, _, C1),node(_, _, _, C2)) :-
  C1>=C2 -> R = > ; R = < .

