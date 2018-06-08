%orderedInsert(nodo(pos(5, 2), [sud], 1, 9, 1),
%              [nodo(pos(3, 2), [nord], 1, 11, 1)],
%              _7490)
orderedInsert(nodo(S, ListaAzioniPerS, C, S, D),
              [nodo(S1, ListaAzioniPerS1, C1, S1, D1)|Rest],
              [nodo(S, ListaAzioniPerS, C, S, D)|[nodo(S1, ListaAzioniPerS1, C1, S1, D1)|Rest]]).



%S = pos(5,2)              S1 = pos(3,2)
%ListaAzioniPerS = [sud]   ListaAzioniPerS1 = [nord]
%C = 1                     C1 = 1
%S = 9                     S1 = 11
%D = 1                     D1 = 1

%_7490 = [nodo(pos(5,2), [sud], 1, 9, 1)|[nodo(pos(3,1), [nord], 1, 11, 1)|Rest]]

%orderedInsert(nodo(pos(5,2), [sud], 1, 9, 1),[nodo(pos(3, 2), [nord], 1, 11, 1)|Rest],[nodo(pos(5, 2), [sud], 1, 9, 1)|[nodo(pos(3,2), [nord], 1, 11, 11)]]).
