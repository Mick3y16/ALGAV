% 1

no(a, 3).
no(b, 6).
no(c, 1).
no(d, 10).
no(e, 5).
no(f, 8).
no(g, 4).
no(h, 7).

liga(a, b, 4).
liga(a, c, 4).
liga(b, d, 6).
liga(c, f, 3).
liga(c, e, 2).
liga(d, e, 7).
liga(e, f, 5).
liga(f, h, 5).
liga(h, g, 6).

maior_capacidade(CP, LN):-findall(A, (no(A, C), C > CP), LN).

% 2 A solução ideal é usar o primeiro em largura, pois garante que a primeira solução é aquela com menos ligações.
calcula_total([_|[]], 0).
calcula_total([Elem, ElemSeguinte|Lista], T):-liga(Elem, ElemSeguinte, C), calcula_total([ElemSeguinte|Lista], T1), T is T1 + C.

procura_ligacao(Orig, Dest, Media, Lista):-go(Orig, Dest, Lista), length(Lista, Tamanho),
	calcula_total(Lista, Total), Media is Total // Tamanho.
	
go(Orig,Dest,Perc):-go1([[Orig]],Dest,P), inverte(P,Perc). 
go1([Prim|Resto],Dest,Prim):-Prim=[Dest|_]. 
go1([[Dest|T]|Resto], Dest, Perc):-!, go1(Resto, Dest, Perc). 
go1([[Ult|T]|Outros], Dest, Perc):-findall([Z,Ult|T], proximo_no(Ult,T,Z), Lista), append(Outros, Lista, NPerc), go1(NPerc, Dest, Perc).

proximo_no(X,T,Z):-not(member(Z,T)), liga(X,Z, _), write(X), write(' '), write(Z), write(' '), write(T), nl.
 
inverte(L,LI) :- inverte(L,[],LI). 
inverte([],LI,LI). 
inverte([H|T],L,LI) :- inverte(T,[H|L],LI). 



% 3 

%ligacao_qualidade(NoX, NoY, L).




















