:- dynamic col_num/1, row_num/1, occupied/1.

%#################################################
% allowed/2 predicate checks if actions, that could
% be 'north', 'south', 'east' and 'west' are feasible
% or not in position 'pos(R,C)'.
% Action's feasibility is checked by testing on:
%   • labyrinth's bounds
%   • and possible labyrinth's walls.
%#################################################
allowed(nord, pos(R,C)) :-
  R>1,
  R1 is R-1,
  \+occupied(pos(R1,C)).

allowed(sud, pos(R,C)) :-
  \+row_num(R),
  R1 is R+1,
  \+occupied(pos(R1,C)).

allowed(ovest, pos(R,C)) :-
  C>1,
  C1 is C-1,
  \+occupied(pos(R,C1)).

allowed(est, pos(R,C)) :-
  \+col_num(C),
  C1 is C+1,
  \+occupied(pos(R,C1)).

%###################################################
% move/3 predicate provides a new state by modifying
% the older position 'pos(R,C)' with a new one.
%###################################################
move(est, pos(R,C), pos(R, CAdjacent)) :-
  CAdjacent is C+1.
move(ovest, pos(R,C), pos(R, CAdjacent)) :-
  CAdjacent is C-1.
move(nord, pos(R,C), pos(RUp,C)) :-
  RUp is R-1.
move(sud, pos(R,C), pos(RDown,C)) :-
  RDown is R+1.

%###################################################
% maxDepth/1 predicate provides a max depth bound
% within which ID search will stop.
%###################################################
maxDepth(D) :-
  row_num(R),
  col_num(L),
  D is R * L.

%###################################################
% cost/3 predicate returns the cost of each feasible
% domain action; each of them have a unit cost.
% it's possible to modify it to obtain diffrent costs
% for each domain action. 
%###################################################
cost(pos(_,_), pos(_, _), Cost) :-
  Cost is 1.
