% Escreva um predicado que permite eliminar todas as ocorrências de um elemento na lista, conforme exemplo seguinte:
elimina_todos(_, [], []).
elimina_todos(X, [X|L1], L2):-!, elimina_todos(X, L1, L2).
elimina_todos(X, [Y|L1], [Y|L2]):-elimina_todos(X, L1, L2).