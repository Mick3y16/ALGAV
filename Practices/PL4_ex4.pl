% Implemente um predicado lista(L) que quando for chamado terá sucesso se L for uma lista.
lista([]).
lista([_|L]):-lista(L).