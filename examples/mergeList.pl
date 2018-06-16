unione([], S, S).
unione([Head|Tail], S, U) :-
    member(Head, S),
    unione(Tail, S, U).
unione([Head|Tail], S, [Head|U]) :-
    unione(Tail, S, U).
