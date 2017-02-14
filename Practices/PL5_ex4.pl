% Escreva um predicado que permite substituir todas as ocorrências de um dado elemento numa lista por outro elemento, conforme exemplo seguinte:
substitui(_, _, [], []).
substitui(X, Y, [X|L1], [Y|L2]):-!, substitui(X, Y, L1, L2).
substitui(X, Y, [Z|L1], [Z|L2]):-substitui(X, Y, L1, L2).
