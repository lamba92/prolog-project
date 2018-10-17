:- ['./tile_game/loader.pl', 'utils.pl'].

start:-
  idastar(S),
  write(S).

idastar(S):-
    initialPosition(S),
    heuristic(S, _, Bound),
    ida_search(S, Sol, [S], 0, Bound),
    write("\n"),
    write(Sol).

ida_search(S, [], _, _, _):-
    finalPosition(S).
ida_search(S, [Action|OtherActions], VisitedNodes, PathCostS, Bound):-
    allowed(Action, S),
    move(Action, S, NewS),
    \+member(NewS, VisitedNodes),
    cost(S, NewS, Cost),
    PathCostNewS is PathCostS + Cost,
    assert(nodoIda(PathCostNewS,NewS)),
	PathCostNewS =< Bound,
    id_search(NewS, OtherActions, [NewS|VisitedNodes], PathCostNewS, Bound).
