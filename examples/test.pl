%orderedInsert(node(pos(5, 2), [sud], 1, 9, 1),
%              [node(pos(3, 2), [nord], 1, 11, 1)],
%              _7490)
orderedInsert(node(S, ActionsListForS, C, S, D),
              [node(S1, ListaAzioniPerS1, C1, S1, D1)|Rest],
              [node(S, ActionsListForS, C, S, D)|[node(S1, ListaAzioniPerS1, C1, S1, D1)|Rest]]).



%S = pos(5,2)              S1 = pos(3,2)
%ActionsListForS = [sud]   ListaAzioniPerS1 = [nord]
%C = 1                     C1 = 1
%S = 9                     S1 = 11
%D = 1                     D1 = 1

%_7490 = [node(pos(5,2), [sud], 1, 9, 1)|[node(pos(3,1), [nord], 1, 11, 1)|Rest]]

%orderedInsert(node(pos(5,2), [sud], 1, 9, 1),[node(pos(3, 2), [nord], 1, 11, 1)|Rest],[node(pos(5, 2), [sud], 1, 9, 1)|[node(pos(3,2), [nord], 1, 11, 11)]]).
