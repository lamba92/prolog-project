:- dynamic setElement/4, dim/1.

%#################################################
% allowed/2 predicate checks if actions, that could
% be 'north', 'south', 'east' and 'west' are feasible
% or not in the current 8-tile puzzle configuration
% represent by 'State' variable.
% Action's feasibility is checked by testing on:
%   • 8-tile puzzle's bounds.
%#################################################
allowed(nord, State) :-
  dim(D),
  nth0(P_, State, v),
  P is P_ + 1,
  P > D.

allowed(sud, State) :-
  dim(D),
  nth0(P_, State, v),
  P is P_ + 1,
  P =< (D * D) - D.

allowed(ovest, State) :-
  dim(D),
  nth0(P, State, v),
  M is mod(P + 1, D),
  M =\= 1.

allowed(est, State) :-
  dim(D),
  nth0(P, State, v),
  M is mod(P + 1, D),
  M =\= 0.
  
%###################################################
% move/3 predicate provides a new state by modifying
% the older 8-tile puzzle's configuration using the
% swap/4 predicate.
%###################################################
move(est, S, NewS) :-
  nth0(OldP, S, v),
  NewP is OldP + 1,
  swap(S, OldP, NewP, NewS).
move(ovest, S, NewS) :-
  nth0(OldP, S, v),
  NewP is OldP - 1,
  swap(S, OldP, NewP, NewS).
move(nord, S, NewS) :-
  dim(D),
  nth0(OldP, S, v),
  NewP is OldP - D,
  swap(S, OldP, NewP, NewS).
move(sud, S, NewS) :-
  dim(D),
  nth0(OldP, S, v),
  NewP is OldP + D,
  swap(S, OldP, NewP, NewS).

%###################################################
% maxDepth/1 predicate provides a max depth bound
% within which ID search will stop.
%###################################################
maxDepth(Md) :-
  dim(D),
  Md is D*100.

%###################################################
% cost/3 predicate returns the cost of each feasible
% domain action; each of them have a unit cost.
% it's possible to modify it to obtain diffrent costs
% for each domain action. 
%###################################################
cost(_, _, Cost) :-
  Cost is 1.

% swap(Lista,Pos1,Pos2,NuovaLista)
%###################################################
% swap/4 predicate returns a new list referred by 
% 'NewList' variable in which elements in position
% 'Pos1' and 'Pos2' are swapped.
%###################################################
swap(List,Pos1,Pos2,NewList):-
  nth0(Pos1, List, X1),
  nth0(Pos2, List, X2),
  setElement(List,Pos2,X1,Temp),
  setElement(Temp,Pos1,X2,NewList).
