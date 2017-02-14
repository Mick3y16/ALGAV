% Escreva um predicado para inserir um elemento numa dada posição numa lista, conforme exemplo seguinte:
insere(X, _, [], [X|[]]).
insere(X, _, [], [X|_]).
% Pode ser usado de forma singular mas falha em listas vazias.
%insere(_,_, [], []).
insere(X, 1, L1, [X|L1]).
insere(X, P, [Y|L1], [Y|L2]):-P1 is P-1, insere(X, P1, L1, L2).
