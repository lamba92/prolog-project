antenato(X,Y):- genitore(X,Y).
antenato(X,Y):- genitore(X,Z), antenato(Z,Y).

fratello(X,Y):-
	genitore(Padre,X),
	genitore(Padre,Y),
	X \== Y,
	genitore(Madre,X),
	Padre \== Madre,
	genitore(Madre,Y).
	
fratelloU(X,Y):-
	genitore(GenComune,X),
	genitore(GenComune,Y),
	X \== Y,
	genitore(AltroGenX, X),
	AltroGenX \== GenComune,
	genitore(AltroGenY, Y),
	AltroGenX \== AltroGenY,
	AltroGenY \== GenComune.