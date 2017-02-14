% Escreva um predicado que dada uma lista de elementos representando uma aposta de totoloto, que poderá
% ter mais de 6 números, seja capaz de gerar as apostas simples correspondentes. Por exemplo:
totoloto(L, LS):-aposta(L, LS, 6). % ALTERAR PARA 5 NA SOLUÇÃO COMENTADA...

/*
aposta([X|_], [X], 0):-!.
aposta([X|L], [X|LS], N):-N1 is N - 1, aposta(L, LS, N1).
% aposta([_, Y| L], [Y| LS], N):-N1 is N - 1, aposta(L, LS, N1).
aposta([_|L], LS, N):-aposta(L, LS, N).
*/

aposta(_, [], 0):-!.
aposta([X|L], [X|LS], N):-N1 is N-1, aposta(L, LS, N1).
aposta([_|L], LS, N):-aposta(L, LS, N). 
