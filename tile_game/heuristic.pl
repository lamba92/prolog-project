:- dynamic dim/1.

%#################################################
% Manhattan distance heuristic for 8-tile puzzle.
% It returns the sum of the distance of each tile 
% from its proper position.
%
% • heuristic/3
% • calculate/4
% • tileDistance/3
%#################################################
heuristic(State, Sol, H) :-
  calculate(State, State, 0, H),
  length(Sol, 0).

calculate(_, [], H, H).
calculate(State, [Tile|OtherTiles], In, Out) :-
  tileDistance(State, Tile, ManDis),
  In1 is In + ManDis,
  calculate(State, OtherTiles, In1, Out).

tileDistance(State, Tile, ManDis) :-
  dim(D),
  nth0(Pos, State, Tile),
  Tile == v,
  Y is floor(abs((D*D - (Pos + 1))/D)),
  X is mod(abs(D*D - (Pos + 1)), D),
  ManDis is X + Y,
  !.

tileDistance(State, Tile, ManDis) :-
  dim(D),
  nth0(Pos, State, Tile),
  Y is floor(abs((Tile - (Pos + 1))/D)),
  X is mod(abs(Tile - (Pos + 1)), D),
  ManDis is X + Y.
