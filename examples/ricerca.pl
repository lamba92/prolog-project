ricerca(X, [X|_]) :- !.
ricerca(X, [_|Tail]) :- 
  ricerca(X, Tail).
