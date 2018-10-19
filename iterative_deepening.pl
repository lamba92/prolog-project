:- ['./tile_game/loader.pl', 'utils.pl'].

% ###################################################
% Iterative Deepening algorithm.
% ###################################################
start:-
  id(S),
  write(S).

id(Sol):-
  maxDepth(D),
  initialPosition(S),
  length(_, L),
  L =< D,
  write("Depth is "), write(L), write("\n"),
  id_search(S, Sol, [S], L),
  write("\n"),
  write(Sol).

% ###################################################
% ###################################################
id_search(S, [], _, _):- 
  finalPosition(S).
id_search(S, [Action|OtherActions], VisitedNodes, N):-
  N>0,
  allowed(Action, S),
  move(Action, S, NewS),
  \+member(NewS, VisitedNodes),
  N1 is N-1,
  id_search(NewS, OtherActions, [NewS|VisitedNodes], N1).
