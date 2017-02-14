membro(X,[X|_]).
membro(X,[_|L]):-membro(X,L).

% a) Contar os elementos de uma lista
contar([], 0).
contar([_|L], C):-contar(L, C1), C is C1 + 1.

% b) Somar os elementos de uma lista de números
somar([], 0).
somar([X|L], R):-somar(L, R1), R is R1 + X.

% c) Obter a média dos elementos de uma lista de números
media(L, M):-somar(L, S), contar(L, N), M is S / N.

% d) Obter a menor valor de entre os elementos de uma lista de números
/*verificar(V1, V2, V1):-V1 < V2.
verificar(_, V2, V2).
menor(Y , [Y]).
menor(X, [Y|L]):-menor(X1, L), verificar(Y, X1, X).*/

% Godlike solution...
menor([X], X).
menor([X1, X2| R], M):-X1<X2,!, menor([X1|R], M).
menor([_|R], M):-menor(R, M).

% e) Contar o nº de elementos da lista que se encontram dentro de uma determinada
% lista de valores (supõe-se a lista composta unicamente por valores numéricos)
conta_elementos_entre(_, _, [],[]).
conta_elementos_entre(X, Y, [Z|R1], [Z|R2]):-X>Z, Y<Z, !, conta_elementos_entre(X, Y, R1, R2).
conta_elementos_entre(X, Y, [_|R1], R2):-conta_elementos_entre(X, Y, R1, R2).

