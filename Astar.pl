:- ['./tile_game/loader.pl', 'utils.pl'].

% ###################################################
% A* algorithm.
% Node is represent by node/4 predicate and its structure is:
%   • S, current configuration's state
%   • ActionsListForS, list of action to reach S state
%   • ActualPathCost, cost of path to reach S state from initial state
%   • HeuristicCost, cost of heuristic for S state configuration.
% ###################################################
start:-
  astar(S),
  write(S).

astar(Solution) :-
  initialPosition(S),
  heuristic(S, _, HeuristicS),
  astar_search([node(S, [], 0, HeuristicS)], [], Solution),
  write(Solution).

% #####################################################################
% astar_search(NodesToBeExplored, ExpandedNodes, MaxDepth, Solution)
%          input               input       input     output
% #####################################################################
astar_search([node(S, ActionsListForS, _, _)|_], _, ActionsListForS):-
  finalPosition(S).
astar_search([node(S, ActionsListForS, ActualPathCost, HeuristicCost)|Frontier], ExpandedNodes, Solution):-
  findall(Az, allowed(Az, S), AllowedActionsList),
  generateSons(node(S, ActionsListForS, ActualPathCost, HeuristicCost), AllowedActionsList, ExpandedNodes, SChilderenList),
  append(SChilderenList, Frontier, NewFrontier),
  predsort(a_star_comparator, NewFrontier, OrderedResult),
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
% #####################################################################
% Used to backtrack on any other possible action in case of fail.
% #####################################################################
generateSons(Node, [_|OtherActions], ExpandedNodes, ChildNodesList) :-
  generateSons(Node, OtherActions, ExpandedNodes, ChildNodesList),
  !.