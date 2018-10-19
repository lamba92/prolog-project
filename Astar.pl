:- ['./labyrinth/loader.pl', 'utils.pl'].

% ###################################################
% A* algorithm.
% Node is represent by node/4 predicate and its structure is:
%   • S
%   • ActionsListForS
%   • ActualPathCost
%   • HeuristicCost
% ###################################################
start:-
  astar(S),
  write(S).

astar(Solution) :-
  initialPosition(S),
  heuristic(S, _, HeuristicS),
  astar_search([node(S, [], 0, HeuristicS)], [], Solution),
  write(Solution).

% ###################################################
% star(CodaNodiDaEsplorare, ExpandedNodes, Solution)
% ###################################################
astar_search([node(S, ActionsListForS, _, _)|_], _, ActionsListForS):-
  finalPosition(S).
astar_search([node(S, ActionsListForS, ActualPathCost, HeuristicCost)|Frontier], ExpandedNodes, Solution):-
  findall(Az, allowed(Az, S), AllowedActionsList),
  generateSons(node(S,ActionsListForS, ActualPathCost, HeuristicCost), AllowedActionsList, ExpandedNodes, SChilderenList),
  length(ExpandedNodes, EN),
  write("|\n Nodi Espansi: "), write(EN), write("\n"),
  append(SChilderenList, Frontier, NewFrontier),
  predsort(comparator_a_star, NewFrontier, OrderedResult),
  astar_search(OrderedResult, [S|ExpandedNodes], Solution).

% ###################################################
% generateSons(Node, AllowedActionsList, ExpandedNodes, ChildNodesList)
% ###################################################
generateSons(_, [], _, []).
generateSons(node(S, ActionsListForS, PathCostForS, HeuristicOfS),
             [Action|OtherActions],
             ExpandedNodes,
             [node(NewS, ActionsListForNewS, PathCostForNewS, HeuristicCostForNewS)|OtherChildren]):-
  move(Action, S, NewS),
  \+member(NewS, ExpandedNodes),
  cost(S, NewS, Cost),
  PathCostForNewS is PathCostForS + Cost,
  heuristic(NewS, _, HeuristicCostForNewS),
  append(ActionsListForS, [Action], ActionsListForNewS),
  generateSons(node(S, ActionsListForS, PathCostForS, HeuristicOfS), OtherActions, ExpandedNodes, OtherChildren),
  !.
% serve per backtrackare sulle altre azione se l'Action porta ad uno stato già visitato o che fallisce
generateSons(Node, [_|OtherActions], ExpandedNodes, ChildNodesList) :-
  generateSons(Node, OtherActions, ExpandedNodes, ChildNodesList),
  !.