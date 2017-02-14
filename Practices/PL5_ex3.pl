% Teste o seguinte predicado, pedindo soluções múltiplas. Indique o seu objectivo.
elimina(_, [], []).
elimina(X, [X|L1], L1):-!.
elimina(X, [Y|L1], [Y|L2]):-elimina(X, L1, L2).

p([],[]).
p(L,[X|L1]):-elimina(X,L,Li),p(Li,L1).

% O objetivo do predicado é verificar se toda uma lista de elementos existe na segunda lista.
