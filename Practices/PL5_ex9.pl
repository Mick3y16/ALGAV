% Implemente um predicado que faça o conjunto diferença entre 2 conjuntos, ou seja, que seja capaz
% de gerar um conjunto com os elementos que pertencem a um dos dois conjuntos, mas não a ambos.
membro(X,[X|_]).
membro(X,[_|L]):-membro(X,L).

elimina_todos(_, [], []).
elimina_todos(X, [X|L1], L2):-!, elimina_todos(X, L1, L2).
elimina_todos(X, [Y|L1], [Y|L2]):-elimina_todos(X, L1, L2).

diferenca([], L2, L2).
diferenca([X|L1], L2, [X|L3]):-not(membro(X, L2)), diferenca(L1, L2, L3).
diferenca([X|L1], L2, L3):-elimina_todos(X, L2, L4), diferenca(L1, L4, L3).


/*
% Implemente um predicado que faça a intersecção entre 2 conjuntos.

interseccao([], _, []).
interseccao([X|L1], L2, [X|L3]):-membro(X, L2), !, interseccao(L1, L2, L3).
interseccao([_|L1], L2, L3):-interseccao(L1, L2, L3).
*/