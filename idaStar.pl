:- ['./labyrinth/loader.pl', 'utils.pl'].

start:-
  idastar(S),
  write(S).

idastar(S):-
    initialPosition(S),
    heuristic(S, _, Bound),
    ida_search(S, Sol, [S], 0, Bound),
    write("\n"),
    write(Sol).

ida_search(S, Sol, VisitedNodes, PathCostS, Bound):-
    ida_search_1(S, Sol, VisitedNodes, PathCostS, Bound);
    findall(FNewS, ida_node(_, FNewS), BoundsList),
    % usa sort/4, verifica con SWIPROLOG
    sort(oundsList, OrderedBoundsList),
    nth0(0, OrderedBoundsList, NewBound),
    write(NewBound),
    retract(ida_node(_, _)),
    ida_search(S, Sol, VisitedNodes, 0, NewBound).
    
ida_search_1(S, [], _, _, _):-
    finalPosition(S).
ida_search_1(S, [Action|OtherActions], VisitedNodes, PathCostS, Bound):-
    allowed(Action, S),
    move(Action, S, NewS),
    \+member(NewS, VisitedNodes),
    cost(S, NewS, Cost),
    PathCostNewS is PathCostS + Cost,
    heuristic(NewS, _, HeuristicCostForNewS),
    FNewS is PathCostNewS + HeuristicCostForNewS,
    assert(ida_node(NewS, FNewS)),
	FNewS =< Bound,
    ida_search(NewS, OtherActions, [NewS|VisitedNodes], FNewS, Bound).