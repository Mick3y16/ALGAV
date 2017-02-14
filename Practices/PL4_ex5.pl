% Construa um predicado repetidos(L) que verifica se uma lista tem ou não elementos repetidos.
repetidos([X|R]):-membro(X, R), !.
repetidos([_|R]):-repetidos(R).