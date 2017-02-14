mulher(maria,30).
mulher(rosa,15).
mulher(teresa,21).
homem(pedro,18).
homem(tiago,43).
par(X,Y):-homem(X,IX), mulher(Y,IY).
mostra_par:-par(X,Y), write(X), write(' '), write(Y), nl, fail; true.
escolhe_par(X,Y,43,S).
escolhe_par(X,Y,MAX,SOM):-MAX > 35, homem(X,IX), mulher(Y,IY), SOM is IX+IY, SOM =< MAX.

/*
a) Quantos pares seriam apresentados após a chamada do predicado mostra_par?
	Para cada solução de homem, são apresentadas todas as soluções de mulher, ou seja, 6.
b) Quantos pares seriam apresentados se o predicado fosse alterado das formas seguintes?
	1) par(X,Y):-homem(X,IX), mulher(Y,IY), !.
		Primeira solução válida, pois o cut impede o backtrack após a primeira solução.
	
	2) par(X,Y):-homem(X,IX), !, mulher(Y,IY).
		Todas as soluções de mulher para a primeira solução de homem, pois o cut impede que se encontrem mais soluções de homem.
		
	3) par(X,Y):-!,	homem(X,IX), mulher(Y,IY).
		Nenhuma, pois o cut faz com que a árvore de pesquisa não seja sequer aberta.
		
c) Qual é o funcionamento da construção 'fail; true'?
	Vai fazer com que o backtrack aconteça automaticamente, apresentando todas as soluções de forma automática devolvendo true no final.

d) Adicione o seguinte predicado ao programa anterior. Este predicado permite escolher pares cuja soma das idades seja menor ou igual ao valor MAX Por exemplo:
   Modifique o predicado para que este termine a execução no caso de o utilizador introduzir um valor de MAX inferior a 36. Por exemplo:
	escolhe_par(X,Y,30,S).
*/
	