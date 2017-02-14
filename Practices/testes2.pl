
%p2([], []).
%p2([X,Y|L1], [X|L2]):-X == Y, p2([Y|L1], L2), not(igual(X, L2)), !.
%p2([_|L1], L2):-p2(L1, L2).
%igual(X, [X|_]).

% Defina o predicado p4/2 que recebe uma lista e dois inteiros e  devolve uma sublista da primeira.
% O 1ºe último elementos dessasublista sãoespecificados pelos dois inteiros, conforme oexemplo
% seguinte(60%):?-p4([a,b,c,d,e,f,g,h],2,5,SL).SL = [b,c,d,e]
%p4(L1, I, J, NL):-length(L1, C), J2 is C - J, sublista(L1, 0, I, L2), reverse(L2, L3), sublista(L3, 0, J2, L4), reverse(L4, NL).
%sublista([_|L], N, I, NL):-N \== I, N1 is N + 1, sublista(L, N1, I, NL).
%sublista(L, I, I, L).

%p4(L1, I, J, L):-sublista(L1, 0, I, J, [], NL), reverse(NL, L).
%sublista(_, N, _, N, LT, LT):-!.
%sublista([X|L1], N, I, J, LT, NL):-N >= I, N =< J, N1 is N+1, sublista(L1, N1, I, J, [X|LT], NL).
%sublista([_|L1], N, I, J, LT, NL):-N1 is N+1, sublista(L1, N1, I, J, LT, NL).

%p5([]):-!.
%p5([X|L]):-number(X), not(0 is X mod 2), write(X), p5(L).
%p5([_|L]):-p5(L).

% Escreva um predicado em Prolog que dado um orçamento máximo por viagem e uma lista com os destinos com voo direto a partir
% do Porto, respetivos preços e lugares disponíveis, crie duas listas, com os destinos dentro do orçamento previsto:
% - uma com os destinos para os quais há lugares disponíveis
% - outra lista com os destinos para os quais será necessário ficar em lista de espera.
% destinoBudget (OrçamentoMax, ListaDestinosDiretos,ListaDestinosDisponíveis, ListaDestinosEspera)7
%destinos(_, [], [], []):-!.
%destinos(O, [(C, P, N)|L], [C|LV], LE):-P =< O, N > 0, !, destinos(O, L, LV, LE).
%destinos(O, [(C, P, N)|L], LV, [C|LE]):-P =< O, !, destinos(O, L, LV, LE).
%destinos(O, [(C, P, N)|L], LV, LE):-destinos(O, L, LV, LE).
