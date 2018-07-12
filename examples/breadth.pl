:- dynamic move/3, allowed/2, finalPosition/1, initialPosition/1.

% stato rappresentato da node(S, ActionsListForS)

ampiezza(Solution) :-
  initialPosition(S),
  breadth([node(S, [])], [], Solution).

% depth(CodaNodiDaEsplorare, ExpandedNodes, Solution)
breadth([node(S, ActionsListForS)|_], _, ActionsListForS) :-
  finalPosition(S).

breadth([node(S, ActionsListForS)|Frontier], ExpandedNodes, Solution) :-
  findall(Az, allowed(Az, S), AllowedActionsList),
  visitati([node(S, ActionsListForS)|Frontier], ExpandedNodes, ExpandedNodes),
  generateSons(node(S,ActionsListForS), AllowedActionsList, ExpandedNodes, SChilderenList),
  append(Frontier, SChilderenList, NewFrontier),
  breadth(NewFrontier, [S|ExpandedNodes], Solution).

% visitati(Frontier, ExpandedNodes, ExpandedNodes)
visitati(Frontier, ExpandedNodes, ExpandedNodes) :-
  estraiStato(Frontier, StatiFrontiera),
  append(StatiFrontiera, ExpandedNodes, ExpandedNodes).

% estraiStato(Frontier, ListaDiStati)
estraiStato([], []).
estraiStato([node(S,_)|Frontier], [S|StatiFrontiera]) :-
  estraiStato(Frontier, StatiFrontiera).

% generateSons(Node, AllowedActionsList, ExpandedNodes, Frontier,ChildNodesList)
generateSons(_, [], _, []).
generateSons(node(S,ActionsListForS), [Action|OtherActions], ExpandedNodes, [node(NewS, [Action|ActionsListForS])|OtherChildren]) :-
  move(Action, S, NewS),
  \+member(NewS, ExpandedNodes),
  generateSons(node(S, ActionsListForS), OtherActions, ExpandedNodes, OtherChildren).
generateSons(Node, [_|OtherActions], ExpandedNodes, ChildNodesList) :-
  generateSons(Node, OtherActions, ExpandedNodes, ChildNodesList).
