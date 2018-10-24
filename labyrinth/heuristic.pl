:- dynamic move/3, finalPosition/1, col_num/1, row_num/1, maxDepth/1.

%#################################################
% Manhattan distance heuristic for labyrinth game.
%
% • heuristic/3
%#################################################

heuristic(pos(X1, Y1), [], L) :-
  finalPosition(pos(X2, Y2)),
  L is abs(X1-X2) + abs(Y1-Y2).
