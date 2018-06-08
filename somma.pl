sommaLista([], 0).
sommaLista([Head|Tail], Totale) :-
  sommaLista(Tail, SommaCoda),
  Totale is SommaCoda + Head.
