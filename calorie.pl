piuCalorico(pancetta,wurstel).
piuCalorico(wurstel,banana).
piuCalorico(banana,verza).
piuCalorico(banana,cetriolo).

piuCalorico(X,Y) :-
  piuCalorico(X,Z),
  piuCalorico(Z,Y).
