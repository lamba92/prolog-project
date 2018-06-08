consumo(X) :-
  buono(X),
  \+esaurito(X).

buono(the).
buono(caffe).
esaurito(the).
