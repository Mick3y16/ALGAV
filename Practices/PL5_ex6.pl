% Considere o seguinte predicado que permite realizar a inversão de uma lista.
inverte(L, LI):-inverte1(L, [], LI).
inverte1([], L, L).
inverte1([H|T], LI, LR):-inverte1(T, [H|LI], LR).

% a) Faça a traçagem desse predicado quando é aposta a questão: ?-inverte([1,2,3],LI).
%
% 
%
% b) Qual a função do 2º parâmetro do inverte1?
%
% É guardar a nova lista criada até ao momento em que a mesma é passada ao terceiro parametro