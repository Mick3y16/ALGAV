liga(a,b).
liga(a,c).
liga(a,d).
liga(b,e).
liga(b,f).
liga(c,f).
liga(c,g).
liga(d,a).
liga(d,g).
liga(d,h).
liga(d,i).
liga(e,j).
liga(f,a).
liga(f,j).
liga(f,k).
liga(g,f).
liga(g,h).
liga(g,o).
liga(h,d).
liga(h,l).
liga(i,l).
liga(j,m).
liga(j,n).
liga(k,n).
liga(k,p).
liga(l,p).

% Escreva um programa em PROLOG que dado um nó origem e um nó destino escreva o
% caminho correspondente. Expresse o conhecimento com factos do tipo liga(a,b).
path(O, D, L):-path_nocycle(O, D, [O], L).
path_nocycle(O, O, _, [O]).
path_nocycle(O, D, V, [O|L]):-liga(O, X), not(member(X, V)), path_nocycle(X, D, [X|V], L), true.

%  Escreva um predicado que seja capaz de criar uma lista com todos os caminhos possíveis entre
%  um nó origem e um nó destino. Cada caminho também está representado através de uma lista
all_paths(O, D, LP):-findall(P, path(O, D, P), LP).

% Escreva um predicado que seja capaz de encontrar a solução passando pelo menor número de cidades.
smaller_path(P1, P2, P1):-length(P1, S1), length(P2, S2), S1 =< S2.
smaller_path(_, P2, P2).
select_path([P1|[]], P1).
select_path([P1|LP], SP):-select_path(LP, P2), smaller_path(P1, P2, SP).
shortest_path(O, D, P):-all_paths(O, D, [FP|LP]), select_path(LP, P).





