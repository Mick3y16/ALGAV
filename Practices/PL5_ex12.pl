% Considere termos do tipo t(Di,Df) que representam os intervalos de datas disponíveis para uma equipa de futebol realizar jogos num dado
% mês. Esses intervalos são agrupados em listas ordenadas. Escreva um predicado que recebendo duas dessas listas, correspondentes a duas
% equipas, seja capaz de gerar outra lista com as datas possíveis dos jogos. Essa última lista também deverá vir no mesmo formato. Por exemplo:
equipa(1, [[2,7],[12,14],[19,19],[25,28]]).
equipa(2, [[1,3],[6,13],[17,21],[26,27]]).

% Primeira data da primeira equipa, datas da segunda equipa.
agendar_jogo(_, [], []).
agendar_jogo([I1, F1], [[I2,F2]|D], [[I1, F1]|L]):-agendar_jogo([I1, F1], D, L), I1 >= I2, F1 =< F2, I1 =< F1.
agendar_jogo([I1, F1], [[I2,F2]|D], [[I1, F2]|L]):-agendar_jogo([I1, F1], D, L), I1 >= I2, F2 =< F1, I1 =< F2.
agendar_jogo([I1, F1], [[I2,F2]|D], [[I2, F1]|L]):-agendar_jogo([I1, F1], D, L), I2 >= I1, F1 =< F2, I2 =< F1.
agendar_jogo([I1, F1], [[I2,F2]|D], [[I2, F2]|L]):-agendar_jogo([I1, F1], D, L), I2 >= I1, F2 =< F1, I2 =< F2.
agendar_jogo(D1, [_|D], L):-agendar_jogo(D1, D, L).

%datas
datas_jogo([], _, []).
datas_jogo([J|E1], E2, A):-agendar_jogo(J, E2, L), !, datas_jogo(E1, E2, B), append(L, B, A).
datas_jogo([_|E1], E2, A):-datas_jogo(E1, E2, A).
