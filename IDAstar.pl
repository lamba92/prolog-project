% stato rappresentato da node(S, ActionsListForS, costoCamminoAttuale, costoEuristica, depth)

:- ['./tile_game/loader.pl', 'utils.pl'].

start:- 
  idaStar(S),
  write(S).
  
idaStar(Solution) :-
  initialPosition(S),
  heuristic(S, _, E),
  maxDepth(D),
  length(_, L),
  L =< D,
  write("\n_____________________________________"),
  write("\n| IDA* CON PROFONDITA' MASSIMA "), write(L),
  write("\n|____________________________________\n"),
  ida([node(S, [], 0, E, 0)], [], L, Solution),
  write("\nSoluzione trovata!\n"),
  write(Solution), write(" | "), write(L).

% star(CodaNodiDaEsplorare, ExpandedNodes, MaxDepth, Solution)
%          input               input       input     output
ida([node(S, ActionsListForS, _, _, _)|_], _, _, ActionsListForS) :-
  finalPosition(S).
ida([node(S, ActionsListForS, ActualPathCost, HeuristicCost, DepthOfS)|Frontier], ExpandedNodes, MaxDepth, Solution) :-
  write("\nNodo in analisi: "), write(S),
  write("\nLista azioni: "), write(ActionsListForS),
  write("\nCosto: "), write(ActualPathCost), write(" | Euristica: "), write(HeuristicCost), write(" | Profondita': "), write(DepthOfS),
  findall(Az, allowed(Az, S), AllowedActionsList),
  write("\nAzioni applicabili: "), write(AllowedActionsList),
  generateSons(node(S,ActionsListForS, ActualPathCost, HeuristicCost, DepthOfS), AllowedActionsList, ExpandedNodes, MaxDepth, SChilderenList),
  appendOrdinata(SChilderenList, Frontier, NewFrontier),
  write("\n\n___________________________"),
  write("\n|FRONTIERA ATTUALE:\n|"),
  stampaFrontieraConP(NewFrontier),
  write("\n|___________________________"),
  ida(NewFrontier, [S|ExpandedNodes], MaxDepth, Solution).

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
  write("\nCalcolo heuristic per "), write(Action),
  heuristic(NewS, HSol, HeuristicCostForNewS),
  write("\n"), write(HSol), write(" | "), write(HeuristicCostForNewS),
  append(ActionsListForS, [Action], ActionsListForNewS),
  generateSons(node(S, ActionsListForS, PathCostForS, HeuristicOfS, DepthOfS), OtherActions, ExpandedNodes, MaxDepth, OtherChildren),
  !.
% serve per backtrackare sulle altre azione se l'Action porta ad uno stato già visitato o che fallisce
generateSons(Node, [_|OtherActions], ExpandedNodes, MaxDepth, ChildNodesList) :-
  generateSons(Node, OtherActions, ExpandedNodes, MaxDepth, ChildNodesList),
  !.