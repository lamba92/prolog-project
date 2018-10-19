% #################################################
% printFrontier/1 predicate prints any node's
% infos inside the input list.
% #################################################
printFrontier([]).
printFrontier([node(S, ActionsListForS, ActualPathCost, HeuristicCost)|Frontier]) :-
  H is ActualPathCost + HeuristicCost,
  write("\n|Node: "), write(S), write(" | F: "), write(H),
  write("\n| - Actions performed to reach state: "), write(ActionsListForS),
  write("\n| - Actual path cost "), write(ActualPathCost),
  write("\n| - Heuristic cost: "), write(HeuristicCost),
  write("\n|"),
  printFrontier(Frontier).

% #################################################
% printFrontierWithBound/1 predicate prints any 
% node's infos inside the input list.
% #################################################
printFrontierWithBound([]).
printFrontierWithBound([node(S, ActionsListForS, ActualPathCost, HeuristicCost, DepthOfS)|Frontier]) :-
  H is ActualPathCost + HeuristicCost,
  write("\n|Node: "), write(S), write(" | F: "), write(H),
  write("\n| - Actions performed to reach stat: "), write(ActionsListForS),
  write("\n| - Actual path cost "), write(ActualPathCost),
  write("\n| - Heuristic cost: "), write(HeuristicCost),
  write("\n| - Depth': "), write(DepthOfS),
  write("\n|"),
  printFrontierWithBound(Frontier).

% #################################################
% setElement/1 predicate is used to ...
% #################################################
setElement([_|Tail],0,X,[X|Tail]):-!.
setElement([Head|Tail],Pos,X,[Head|NuovaTail]):-
  Pos1 is Pos-1,
  setElement(Tail,Pos1,X,NuovaTail).

% #################################################
% comparator_a_star/3 predicate provides a comparator
% used to sort A* frontier after each new expansion.
% #################################################
comparator_a_star(R, node(_, _, P1, C1), node(_, _, P2, C2)) :-
  F1 is P1 + C1,
  F2 is P2 + C2,
  F1>=F2 -> R = > ; R = < .