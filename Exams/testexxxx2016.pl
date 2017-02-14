% 1 

/* Supostamente isto cria uma lista de soluções em vez de gerar os vários valores de R...

adjacente_diferenca([Elem|Lista], Val, R):-ElemAnterior is Elem + 2, adjacente_diferenca1(ElemAnterior, [Elem|Lista], Val, R).

adjacente_diferenca1(ElemAnterior, [Elem|[]], Val, [Elem]):-Val is ElemAnterior - Elem, !.
adjacente_diferenca1(_, [_|[]], _, []):-!.
adjacente_diferenca1(ElemAnterior, [Elem, ElemSeguinte|Lista], Val, [Elem|R]):-Val is ElemAnterior - Elem, Val is Elem - ElemSeguinte, !, adjacente_diferenca1(Elem, [ElemSeguinte|Lista], Val, R).
adjacente_diferenca1(_, [Elem, ElemSeguinte|Lista], Val, R):-adjacente_diferenca1(Elem, [ElemSeguinte|Lista], Val, R).
*/

adjacente_diferenca([Elem|Lista], Val, R):-ElemAnterior is Elem + 2, adjacente_diferenca1(ElemAnterior, [Elem|Lista], Val, R).

adjacente_diferenca1(ElemAnterior, [Elem|[]], Val, Elem):-Val is abs(ElemAnterior - Elem).
adjacente_diferenca1(ElemAnterior, [Elem, ElemSeguinte|_], Val, Elem):-Val is abs(ElemAnterior - Elem), Val is abs(Elem - ElemSeguinte).
adjacente_diferenca1(_, [Elem, ElemSeguinte|Lista], Val, R):-adjacente_diferenca1(Elem, [ElemSeguinte|Lista], Val, R).

% 2

todos_adj_dif([], _, []):-!.
todos_adj_dif([Lista|ListaDeListaas], Val, ListaResultado):-
 findall(E, (adjacente_diferenca(Lista, Val, E)), L),
 todos_adj_dif(ListaDeListaas, Val, ListaResultado1),
 append(L, ListaResultado1, ListaResultado).

% 3

estrada(a, b, 1, 10).
estrada(a, d, 3, 4).
estrada(b, e, 1, 5).
estrada(d, c, 2, 8).
estrada(d, h, 3, 3).
estrada(e, c, 2, 12).
estrada(e, g, 2, 15).
estrada(c, f, 1, 6).
estrada(g, f, 1, 4).
estrada(g, i, 2, 9).
estrada(h, i, 3, 8).

caminho(Orig, Dest, Vias, TempoTotal, Percurso):-go1([(0, [Orig])], Dest, Vias, TempoTotal, P), reverse(P, Percurso).

go1([(C, Prim)|_], Dest, _, C, Prim):-Prim=[Dest|_].
go1([(_, [Dest|_])|Resto], Dest, Vias, TempoTotal, Perc):-!, go1(Resto, Dest, Vias, TempoTotal, Perc). 
go1([(C, [Ult|T])|Outros], Dest, Vias, TempoTotal, Perc):-
 findall((NC, [Z,Ult|T]), (proximo_no(Ult, T, Z, C1, Vias), NC is C+C1), Lista),
 append(Outros, Lista, NPerc), sort(NPerc, NPerc1), go1(NPerc1, Dest, Vias, TempoTotal, Perc).

proximo_no(X, T, Z, C, Vias):-estrada(X, Z, V, C), member(V, Vias), not(member(Z, T)). 








