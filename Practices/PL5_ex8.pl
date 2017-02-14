% Implemente um predicado que faça a intersecção entre 2 conjuntos.
membro(X,[X|_]).
membro(X,[_|L]):-membro(X,L).

interseccao([], _, []).
interseccao([X|L1], L2, [X|L3]):-membro(X, L2), !, interseccao(L1, L2, L3).
interseccao([_|L1], L2, L3):-interseccao(L1, L2, L3).