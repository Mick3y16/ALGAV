% Escreva um predicado que dada uma lista de elementos representando uma aposta de totobola, com múltiplas representadas por listas internas,
% seja capaz de gerar as apostas simples correspondentes. Por exemplo:
membro(X,[X|_]).
membro(X,[_|L]):-membro(X,L).

lista([]).
lista([_|L]):-lista(L).

totobola([], []).
totobola([X|L1], [Y|LS]):-lista(X), !, membro(Y, X), totobola(L1, LS).
totobola([X|L1], [X|LS]):-totobola(L1, LS).

/*
totobola([], []).
totobola([X|L1], [Y|LS]):-membro(Y, X), totobola(L1, LS).
totobola([X|L1], [X|LS]):-not(membro(_, X)), totobola(L1, LS).
*/
