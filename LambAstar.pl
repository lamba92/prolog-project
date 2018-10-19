:- ['./labyrinth/loader.pl', 'utils.pl'].

% ###################################################
% LambA* algorithm.
% Node is represent by node/4 predicate and its structure is:
%   • S
%   • ActionsListForS
%   • ActualPathCost
%   • HeuristicCost
% ###################################################
start:- 
  lambaStar(S),
  write(S).

lambaStar(Solution) :-
  initialPosition(S),
  heuristic(S, _, E),
  maxDepth(D),
  length(_, L),
  L =< D,
  lamba([node(S, [], 0, E, 0)], [], L, Solution),
  write("\nSoluzione trovata!\n"),
  write(Solution), write(" | "), write(L).


% ###################################################
% ###################################################
% star(CodaNodiDaEsplorare, ExpandedNodes, MaxDepth, Solution)
%          input               input       input     output
lamba([node(S, ActionsListForS, _, _, _)|_], _, _, ActionsListForS) :-
  finalPosition(S).
lamba([node(S, ActionsListForS, ActualPathCost, HeuristicCost, DepthOfS)|Frontier], ExpandedNodes, MaxDepth, Solution) :-
  findall(Az, allowed(Az, S), AllowedActionsList),
  generateSons(node(S,ActionsListForS, ActualPathCost, HeuristicCost, DepthOfS), AllowedActionsList, ExpandedNodes, MaxDepth, SChilderenList),
  length(ExpandedNodes, EN),
  write("|\n Nodi Espansi: "), write(EN), write("\n"),
  append(SChilderenList, Frontier, NewFrontier),
  predsort(comparator_a_star, NewFrontier, OrderedResult),
  lamba(OrderedResult, [S|ExpandedNodes], MaxDepth, Solution).

% ###################################################
% ###################################################
% generateSons(Node, AllowedActionsList, ExpandedNodes, MaxDepth, ChildNodesList)
generateSons(_, [], _, _, []).
generateSons(node(S, ActionsListForS, PathCostForS, HeuristicOfS, DepthOfS),
             [Action|OtherActions],
             ExpandedNodes,
             MaxDepth,
             [node(NewS, ActionsListForNewS, PathCostForNewS, HeuristicCostForNewS, NewSDepth)|OtherChildren]) :-
  NewSDepth is DepthOfS + 1,
  NewSDepth =< MaxDepth,
  move(Action, S, NewS),
  \+member(NewS, ExpandedNodes),
  cost(S, NewS, Cost),
  PathCostForNewS is PathCostForS + Cost,
  heuristic(NewS, HSol, HeuristicCostForNewS),
  append(ActionsListForS, [Action], ActionsListForNewS),
  generateSons(node(S, ActionsListForS, PathCostForS, HeuristicOfS, DepthOfS), OtherActions, ExpandedNodes, MaxDepth, OtherChildren),
  !.
% serve per backtrackare sulle altre azione se l'Action porta ad uno stato già visitato o che fallisce
generateSons(Node, [_|OtherActions], ExpandedNodes, MaxDepth, ChildNodesList) :-
  generateSons(Node, OtherActions, ExpandedNodes, MaxDepth, ChildNodesList),
  !.