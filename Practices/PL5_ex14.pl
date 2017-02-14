% Dado um conjunto de n homens e n mulheres, o objectivo deste exercício é juntá-los em pares após cada homem ter dado a lista de mulheres que
% prefere de 1 até n [m1,…,mn] e cada mulher ter feito o mesmo para os homens [h1,…hn]. A solução será uma lista de pares [hi,mj] e é considerada
% aceitável se os casamentos forem estáveis isto é, não existirem dois pares [hi,mj], [hk,ml] tal que hi prefere ml em vez de mj e ml prefere hi
% em vez de hk. A teoria de grafos demonstra que este problema tem sempre solução e adaptações da solução deste problema são utilizadas para a
% colocação de candidatos em lugares quando estes manifestam uma ordem de preferência.
% Homens = [a,b,c,d,e]
preferencias(a, [q,t,p,r,s]).
preferencias(b, [p,q,r,s,t]).
preferencias(c, [q,r,t,s,p]).
preferencias(d, [p,r,q,s,t]).
preferencias(e, [t,r,q,p,s]).
% Mulheres = [p,q,r,s,t]
preferencias(p, [e,a,d,b,c]).
preferencias(q, [d,e,b,a,c]).
preferencias(r, [a,d,b,c,e]).
preferencias(s, [c,b,d,a,e]).
preferencias(t, [d,b,c,e,a]).

podem_casar(H, M):-preferencias(H, PH), preferencias(M, PM), member(H, PM), member(M, PH).

casamentos_estaveis(_, [], _).
casamentos_estaveis([], _, _).
casamentos_estaveis([], [], _).
casamentos_estaveis([H|LH], [M|LM], [[H,M]|C]):-podem_casar(H, M), write(H), write(M), casamentos_estaveis(LH, [M|LM], C).
casamentos_estaveis(LH, [_|LM], C):-casamentos_estaveis(LH, LM, C).


/*casamentos_estaveis(Homens, Mulheres, Casamentos).
Para a base de conhecimento anterior, a chamada ao predicado
implementado deverá resultar no seguinte:
?- casamentos_estaveis([a,b,c,d,e], [p,q,r,s,t], C).
C = [m(a,p),m(b,s),m(c,t),m(d,r),m(e,q)].
*/


