:- ['./labyrinth/loader.pl', 'utils.pl'].

% #####################################################################
% LambA* algorithm.
% Node is represent by node/4 predicate and its structure is:
%   • S, current configuration's state
%   • ActionsListForS, list of action to reach S state
%   • ActualPathCost, cost of path to reach S state from initial state
%   • HeuristicCost, cost of heuristic for S state configuration.
%
% At the moment (probably forever) this won't work.
% #####################################################################
start:- 
  lambastar(S),
  write(S).

lambastar(Solution) :-
  initialPosition(S),
  heuristic(S, _, E),
  maxDepth(D),
  length(_, L),
  L =< D,
  lamba([node(S, [], 0, E, 0)], [], L, Solution),
  write("\nSoluzione trovata!\n"),
  write(Solution), write(" | "), write(L).

% #####################################################################
% lamba(NodesToBeExplored, ExpandedNodes, MaxDepth, Solution)
%          input               input       input     output
% #####################################################################
lamba([node(S, ActionsListForS, _, _, _)|_], _, _, ActionsListForS) :-
  finalPosition(S).
lamba([node(S, ActionsListForS, ActualPathCost, HeuristicCost, DepthOfS)|Frontier], ExpandedNodes, MaxDepth, Solution) :-
  findall(Az, allowed(Az, S), AllowedActionsList),
  generateSons(node(S,ActionsListForS, ActualPathCost, HeuristicCost, DepthOfS), AllowedActionsList, ExpandedNodes, MaxDepth, SChilderenList),
  length(ExpandedNodes, EN),
  write("|\n Nodi Espansi: "), write(EN), write("\n"),
  append(SChilderenList, Frontier, NewFrontier),
  predsort(a_star_comparator, NewFrontier, OrderedResult),
  lamba(OrderedResult, [S|ExpandedNodes], MaxDepth, Solution).

% #####################################################################
% generateSons(Node, AllowedActionsList, ExpandedNodes, MaxDepth, ChildNodesList)
% #####################################################################
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
% #####################################################################
% Used to backtrack on any other possible action in case of fail.
% #####################################################################
generateSons(Node, [_|OtherActions], ExpandedNodes, MaxDepth, ChildNodesList) :-
  generateSons(Node, OtherActions, ExpandedNodes, MaxDepth, ChildNodesList),
  !.