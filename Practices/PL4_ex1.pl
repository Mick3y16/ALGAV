membro(X,[X|_]).
membro(X,[_|L]):-membro(X,L).

/*	membro(X, [X|_]). - falha, porque o elemento 3 não está à cabeça da lista, seguindo para o segundo predicado.
	membro(X, [_|L]):-membro[X, L] - Ignora a cabeça da lista, chamando de novo o primeiro predicado, usado a cauda da lista.

	O processo repete-se por 2 vezes. */
alinea_a():-membro(3, [1,2,3,4]).

/* Vai percorrer a lista recursivamente e falhar pois o elemento não existe na mesma. */
alinea_b():-membro(4, [1,2,3]).

/* Vai apresentar o primeiro elemento da lista, dado que X é uma variável por instanciar. */
alinea_c(X):-membro(X, [1,2,3]).

/* Coloca o valor 3 na cabeça de uma lista não instanciada deixando a sua cauda por instanciar. */
alinea_d(L):-membro(3, L).

/* e) Termina o processo mal seja encontrada a primeira solução válida. */

/* f) O primeiro membro seria seria chamado de forma recursiva, removendo sempre o primeiro elemento da lista, nunca fazendo
	  a comparação sobre o valor de X. */