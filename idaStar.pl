:- ['./labyrinth/loader.pl', 'utils.pl'].
:- use_module(library(apply)).

start:-
  ida(S),
  write(S).

ida(S):-
    initialPosition(S),
    heuristic(S, _, InitialThreshold),
    idastar(S, Sol, [S], 0, InitialThreshold),
    write("\n"), write(Sol).

idastar(S, Sol, VisitedNodes, PathCostS, Threshold):-
    ida_search(S, Sol, VisitedNodes, PathCostS, Threshold);
    findall(FS, ida_node(_, FS), ThresholdList),
    exclude(>=(Threshold), ThresholdList, OverThresholdList),
    sort(OverThresholdList, SortedTList),
    nth0(0, SortedTList, NewThreshold),
    retractall(ida_node(_, _)),
    idastar(S, Sol, VisitedNodes, 0, NewThreshold).
    
ida_search(S, [], _, _, _):-
    finalPosition(S).
ida_search(S, [Action|OtherActions], VisitedNodes, PathCostS, Threshold):-
    allowed(Action, S),
    move(Action, S, NewS),
    \+member(NewS, VisitedNodes),
    cost(S, NewS, Cost),
    PathCostNewS is PathCostS + Cost,
    heuristic(NewS, _, HeuristicCostForNewS),
    FNewS is PathCostNewS + HeuristicCostForNewS,
    assert(ida_node(NewS, FNewS)),
	FNewS =< Threshold,
    ida_search(NewS, OtherActions, [NewS|VisitedNodes], PathCostNewS, Threshold).
