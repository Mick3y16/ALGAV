% Crie um predicado prodvec(L1,L2,LV) que multiplique dois vectores contidos em L1 e L2, retornando o resultado em LV.
prodvec(L1, [], L1).
prodvec([], L2, L2).
prodvec([X|L1], [Y|L2], [Z|L3]):-prodvec(L1, L2, L3), Z is X * Y.
