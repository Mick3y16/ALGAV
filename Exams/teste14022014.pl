% 1

salto(N, (X, Y), PF):-findall(Salto, salto_valido(N, (X, Y), Salto), PF).
	
salto_valido(N, (X1, Y1), (X2, Y2)):-X2 is X1 + 2, Y2 is Y1 + 1, X2 =< N, X2 > 0, Y2 =< N, Y2 > 0.
salto_valido(N, (X1, Y1), (X2, Y2)):-X2 is X1 + 2, Y2 is Y1 - 1, X2 =< N, X2 > 0, Y2 =< N, Y2 > 0.
salto_valido(N, (X1, Y1), (X2, Y2)):-X2 is X1 - 2, Y2 is Y1 + 1, X2 =< N, X2 > 0, Y2 =< N, Y2 > 0.
salto_valido(N, (X1, Y1), (X2, Y2)):-X2 is X1 - 2, Y2 is Y1 - 1, X2 =< N, X2 > 0, Y2 =< N, Y2 > 0.
salto_valido(N, (X1, Y1), (X2, Y2)):-X2 is X1 + 1, Y2 is Y1 + 2, X2 =< N, X2 > 0, Y2 =< N, Y2 > 0.
salto_valido(N, (X1, Y1), (X2, Y2)):-X2 is X1 - 1, Y2 is Y1 + 2, X2 =< N, X2 > 0, Y2 =< N, Y2 > 0.
salto_valido(N, (X1, Y1), (X2, Y2)):-X2 is X1 + 1, Y2 is Y1 - 1, X2 =< N, X2 > 0, Y2 =< N, Y2 > 0.
salto_valido(N, (X1, Y1), (X2, Y2)):-X2 is X1 - 1, Y2 is Y1 - 2, X2 =< N, X2 > 0, Y2 =< N, Y2 > 0.

% 2

visita(N, PI, Saltos):-visita(N, PI, [PI], Saltos).

% Para quando o tamanho da lista for igual ao do tabuleiro.
visita(N, _, SaltosTemporario, SaltosTemporario):-
	NSquared is N * N, length(SaltosTemporario, NSquared).

visita(N, PI, SaltosTemporario, Saltos):-
	salto(N, PI, LP),
	member(PN, LP),
	not(member(PN, SaltosTemporario)),
	visita(N, PN, [PN|SaltosTemporario], Saltos).
	
percurso(N, PI, Saltos):-findall([Ult|CnjSaltos], (visita(N, PI, [Ult|CnjSaltos]), salto(N, Ult, S), member(PI, S)), [Saltos|_]).