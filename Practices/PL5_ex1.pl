%Escreva um predicado que permite eliminar apenas a primeira ocorrência de um elemento na lista, conforme exemplo seguinte:
elimina_um(_, [], []).
elimina_um(X, [X|L1], L1):-!.
elimina_um(X, [Y|L1], [Y|L2]):-elimina_um(X, L1, L2).