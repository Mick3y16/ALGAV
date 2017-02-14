% O problema das 8 rainhas consiste em colocar 8 rainhas num tabuleiro de xadrez vazio (com 8x8 posições) tal que não seja possível que uma
% rainha ataque qualquer outra. Uma rainha ataca uma outra se esta estiver na mesma linha, coluna ou diagonal. O tabuleiro pode ser representado
% por uma lista de 8 elementos em que cada elemento da lista representa a posição de uma das rainhas no tabuleiro. Uma possível solução para o
% problema é a seguinte: [(1,4),(2,2),(3,7),(4,3),(5,6),(6,8),(7,5),(8,1)]
pos(1).
pos(2).
pos(3).
pos(4).
pos(5).
pos(6).
pos(7).
pos(8).
pos_inicial([[1,Y1],[2,Y2],[3,Y3],[4,Y4],[5,Y5],[6,Y6],[7,Y7],[8,Y8]]):-solucao([[1,Y1],[2,Y2],[3,Y3],[4,Y4],[5,Y5],[6,Y6],[7,Y7],[8,Y8]], []).
solucao([], _).
solucao([[_, Y|_]|L], LI):-pos(X), not(member(X, LI)), Y is X, solucao(L, [X|LI]).
