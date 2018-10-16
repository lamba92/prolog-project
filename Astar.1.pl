% stato rappresentato da node(S, ActionsListForS, costoCamminoAttuale, costoEuristica)

:- ['./labyrinth/loader.pl', 'utils.pl'].

start:-
  aStar(S),
  write(S).

aStar(Solution) :-
  initialPosition(S),
  heuristic(S, _, L),
  %star([node(S, [], 0, L)], [], Solution),
  star([node(0, L, S, [])], [], Solution),
  write(Solution).

% star(CodaNodiDaEsplorare, ExpandedNodes, Solution)
%star([node(S, ActionsListForS, _, _)|_], _, ActionsListForS) :-
  %finalPosition(S).
star([node(_, _, S, ActionsListForS)|_], _, ActionsListForS) :-
  finalPosition(S).
%star([node(S, ActionsListForS, ActualPathCost, HeuristicCost)|Frontier], ExpandedNodes, Solution) :-

star([node(S, ActionsListForS, s, HeuristicCost)|Frontier], ExpandedNodes, Solution) :-
  findall(Az, allowed(Az, S), AllowedActionsList),
  generateSons(node(S,ActionsListForS, ActualPathCost, HeuristicCost), AllowedActionsList, ExpandedNodes, SChilderenList),
  append(SChilderenList, Frontier, NewFrontier),
  sort(NewFrontier, OF)
  star(OF, [S|ExpandedNodes], Solution).
  
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
