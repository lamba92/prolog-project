% stato rappresentato da nodo(S, ListaAzioniPerS, costoCamminoAttuale, costoEuristica)

:- ['./labyrinth/loader.pl', 'utils.pl'].

aStar(Soluzione) :-
  iniziale(S),
  euristica(S, _, L),
  star([nodo(S, [], 0, L)], [], Soluzione),
  write("\nSoluzione trovata!\n"),
  write(Soluzione).

% star(CodaNodiDaEsplorare, NodiEspansi, Soluzione)
star([nodo(S, ListaAzioniPerS, _, _)|_], _, ListaAzioniPerS) :-
  finale(S).
star([nodo(S, ListaAzioniPerS, CostoCamminoAttuale, CostoEuristica)|Frontiera], NodiEspansi, Soluzione) :-
  write("\nNodo in analisi: "), write(S),
  write("\nLista azioni: "), write(ListaAzioniPerS),
  write("\nCosto: "), write(CostoCamminoAttuale), write(" | Euristica: "), write(CostoEuristica),
  findall(Az, applicabile(Az, S), ListaAzioniApplicabili),
  write("\nAzioni applicabili: "), write(ListaAzioniApplicabili),
  generateSons(nodo(S,ListaAzioniPerS, CostoCamminoAttuale, CostoEuristica), ListaAzioniApplicabili, NodiEspansi, ListaFigliS),
% write("\nFigli trovati: "), write(ListaFigliS), write("\n"),
  appendOrdinata(ListaFigliS, Frontiera, NuovaFrontiera),
  write("\n\n___________________________"),
  write("\n|FRONTIERA ATTUALE:\n|"),
  stampaFrontiera(NuovaFrontiera),
  write("\n|___________________________"),
  star(NuovaFrontiera, [S|NodiEspansi], Soluzione).

% generateSons(Nodo, ListaAzioniApplicabili, ListaStatiVisitati, ListaNodiFigli)
generateSons(_, [], _, []).
generateSons(nodo(S, ListaAzioniPerS, CostoCamminoS, CostoEuristicaS),
             [Azione|AltreAzioni],
             NodiEspansi,
             [nodo(SNuovo, ListaAzioniPerSNuovo, CostoCamminoSNuovo, CostoEuristicaSNuovo)|AltriFigli]) :-
  trasforma(Azione, S, SNuovo),
  \+member(SNuovo, NodiEspansi),
  costoPasso(S, SNuovo, CostoPasso),
  CostoCamminoSNuovo is CostoCamminoS + CostoPasso,
  write("\nCalcolo euristica per "), write(Azione),
  euristica(SNuovo, SolE, CostoEuristicaSNuovo),
  write("\n"), write(SolE), write(" | "), write(CostoEuristicaSNuovo),
  append(ListaAzioniPerS, [Azione], ListaAzioniPerSNuovo),
  generateSons(nodo(S, ListaAzioniPerS, CostoCamminoS, CostoEuristicaS), AltreAzioni, NodiEspansi, AltriFigli).
% serve per backtrackare sulle altre azione se l'Azione porta ad uno stato già visitato o che fallisce
generateSons(Nodo, [_|AltreAzioni], ListaStatiVisitati, ListaNodiFigli) :-
  generateSons(Nodo, AltreAzioni, ListaStatiVisitati, ListaNodiFigli).
