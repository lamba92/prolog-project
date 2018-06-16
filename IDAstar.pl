% stato rappresentato da nodo(S, ListaAzioniPerS, costoCamminoAttuale, costoEuristica, depth)

:- ['./labyrinth/loader.pl', 'utils.pl'].

i(S) :- idaStar(S).

idaStar(Soluzione) :-
  iniziale(S),
  euristica(S, _, E),
  maxDepth(D),
  length(_, L),
  L =< D,
  write("\n_____________________________________"),
  write("\n| IDA* CON PROFONDITA' MASSIMA "), write(L),
  write("\n|____________________________________\n"),
  ida([nodo(S, [], 0, E, 0)], [], L, Soluzione),
  write("\nSoluzione trovata!\n"),
  write(Soluzione), write(" | "), write(L).

% star(CodaNodiDaEsplorare, NodiEspansi, MaxDepth, Soluzione)
%          input               input       input     output
ida([nodo(S, ListaAzioniPerS, _, _, _)|_], _, _, ListaAzioniPerS) :-
  finale(S).
ida([nodo(S, ListaAzioniPerS, CostoCamminoAttuale, CostoEuristica, ProfonditaS)|Frontiera], NodiEspansi, MaxDepth, Soluzione) :-
  write("\nNodo in analisi: "), write(S),
  write("\nLista azioni: "), write(ListaAzioniPerS),
  write("\nCosto: "), write(CostoCamminoAttuale), write(" | Euristica: "), write(CostoEuristica), write(" | Profondita': "), write(ProfonditaS),
  findall(Az, applicabile(Az, S), ListaAzioniApplicabili),
  write("\nAzioni applicabili: "), write(ListaAzioniApplicabili),
  generateSons(nodo(S,ListaAzioniPerS, CostoCamminoAttuale, CostoEuristica, ProfonditaS), ListaAzioniApplicabili, NodiEspansi, MaxDepth, ListaFigliS),
% write("\nFigli trovati: "), write(ListaFigliS), write("\n"),
  appendOrdinata(ListaFigliS, Frontiera, NuovaFrontiera),
  write("\n\n___________________________"),
  write("\n|FRONTIERA ATTUALE:\n|"),
  stampaFrontieraConP(NuovaFrontiera),
  write("\n|___________________________"),
  ida(NuovaFrontiera, [S|NodiEspansi], MaxDepth, Soluzione).

% generateSons(Nodo, ListaAzioniApplicabili, ListaStatiVisitati, MaxDepth, ListaNodiFigli)
generateSons(_, [], _, _, []).
generateSons(nodo(S, ListaAzioniPerS, CostoCamminoS, CostoEuristicaS, ProfonditaS),
             [Azione|AltreAzioni],
             NodiEspansi,
             MaxDepth,
             [nodo(SNuovo, ListaAzioniPerSNuovo, CostoCamminoSNuovo, CostoEuristicaSNuovo, ProfonditaSNuovo)|AltriFigli]) :-
  ProfonditaSNuovo is ProfonditaS + 1,
  ProfonditaSNuovo =< MaxDepth,
  trasforma(Azione, S, SNuovo),
  \+member(SNuovo, NodiEspansi),
  costoPasso(S, SNuovo, CostoPasso),
  CostoCamminoSNuovo is CostoCamminoS + CostoPasso,
  write("\nCalcolo euristica per "), write(Azione),
  euristica(SNuovo, SolE, CostoEuristicaSNuovo),
  append(ListaAzioniPerS, [Azione], ListaAzioniPerSNuovo),
  write("\n"), write(SolE), write(" | "), write(CostoEuristicaSNuovo),
  generateSons(nodo(S, ListaAzioniPerS, CostoCamminoS, CostoEuristicaS, ProfonditaS), AltreAzioni, NodiEspansi, MaxDepth, AltriFigli),
  !.
% serve per backtrackare sulle altre azione se l'Azione porta ad uno stato già visitato o che fallisce
generateSons(Nodo, [_|AltreAzioni], ListaStatiVisitati, MaxDepth, ListaNodiFigli) :-
  generateSons(Nodo, AltreAzioni, ListaStatiVisitati, MaxDepth, ListaNodiFigli),
  !.
