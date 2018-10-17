% stato rappresentato da node(S, ActionsListForS, costoCamminoAttuale, costoEuristica)

:- ['./tile_game/loader.pl', 'utils.pl'].

start:-
  aStar(S),
  write(S).

aStar(Solution) :-
  initialPosition(S),
  heuristic(S, _, L),
  star([node(S, [], 0, L)], [], Solution),
  write(Solution).

% star(CodaNodiDaEsplorare, ExpandedNodes, Solution)
star([node(S, ActionsListForS, _, _)|_], _, ActionsListForS) :-
  finalPosition(S).
star([node(S, ActionsListForS, ActualPathCost, HeuristicCost)|Frontier], ExpandedNodes, Solution) :-
  findall(Az, allowed(Az, S), AllowedActionsList),
  generateSons(node(S,ActionsListForS, ActualPathCost, HeuristicCost), AllowedActionsList, ExpandedNodes, SChilderenList),
  append(SChilderenList, Frontier, NewFrontier),
  predsort(comparator, NewFrontier, OrderedResult),
  star(OrderedResult, [S|ExpandedNodes], Solution).

comparator(R, node(_,_,_, C1),node(_,_,_,C2)) :-
  C1>C2 -> R = > ; R = < .


% generateSons(Node, AllowedActionsList, ExpandedNodes, ChildNodesList)
generateSons(_, [], _, []).
generateSons(node(S, ActionsListForS, PathCostForS, HeuristicOfS),
             [Action|OtherActions],
             ExpandedNodes,
             [node(NewS, ActionsListForNewS, PathCostForNewS, HeuristicCostForNewS)|OtherChildren]) :-
  move(Action, S, NewS),
  \+member(NewS, ExpandedNodes),
  cost(S, NewS, Cost),
  PathCostForNewS is PathCostForS + Cost,
  heuristic(NewS, HSol, HeuristicCostForNewS),
  append(ActionsListForS, [Action], ActionsListForNewS),
  generateSons(node(S, ActionsListForS, PathCostForS, HeuristicOfS), OtherActions, ExpandedNodes, OtherChildren),
  !.
% serve per backtrackare sulle altre azione se l'Action porta ad uno stato già visitato o che fallisce
generateSons(Node, [_|OtherActions], ExpandedNodes, ChildNodesList) :-
  generateSons(Node, OtherActions, ExpandedNodes, ChildNodesList),
  !.
