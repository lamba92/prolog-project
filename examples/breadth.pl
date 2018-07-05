:- dynamic trasforma/3, applicabile/2, finale/1, iniziale/1.

% stato rappresentato da nodo(S, ListaAzioniPerS)

ampiezza(Soluzione) :-
  iniziale(S),
  breadth([nodo(S, [])], [], Soluzione).

% depth(CodaNodiDaEsplorare, NodiEspansi, Soluzione)
breadth([nodo(S, ListaAzioniPerS)|_], _, ListaAzioniPerS) :-
  finale(S).

breadth([nodo(S, ListaAzioniPerS)|Frontiera], NodiEspansi, Soluzione) :-
  findall(Az, applicabile(Az, S), ListaAzioniApplicabili),
  visitati([nodo(S, ListaAzioniPerS)|Frontiera], NodiEspansi, ListaStatiVisitati),
  generateSons(nodo(S,ListaAzioniPerS), ListaAzioniApplicabili, ListaStatiVisitati, ListaFigliS),
  append(Frontiera, ListaFigliS, NuovaFrontiera),
  breadth(NuovaFrontiera, [S|NodiEspansi], Soluzione).

% visitati(Frontiera, NodiEspansi, ListaStatiVisitati)
visitati(Frontiera, NodiEspansi, ListaStatiVisitati) :-
  estraiStato(Frontiera, StatiFrontiera),
  append(StatiFrontiera, NodiEspansi, ListaStatiVisitati).

% estraiStato(Frontiera, ListaDiStati)
estraiStato([], []).
estraiStato([nodo(S,_)|Frontiera], [S|StatiFrontiera]) :-
  estraiStato(Frontiera, StatiFrontiera).

% generateSons(Nodo, ListaAzioniApplicabili, ListaStatiVisitati, Frontiera,ListaNodiFigli)
generateSons(_, [], _, []).
generateSons(nodo(S,ListaAzioniPerS), [Azione|AltreAzioni], ListaStatiVisitati, [nodo(SNuovo, [Azione|ListaAzioniPerS])|AltriFigli]) :-
  trasforma(Azione, S, SNuovo),
  \+member(SNuovo, ListaStatiVisitati),
  generateSons(nodo(S, ListaAzioniPerS), AltreAzioni, ListaStatiVisitati, AltriFigli).
generateSons(Nodo, [_|AltreAzioni], ListaStatiVisitati, ListaNodiFigli) :-
  generateSons(Nodo, AltreAzioni, ListaStatiVisitati, ListaNodiFigli).
