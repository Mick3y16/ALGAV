ve(v1, v2, 1).
ve(v1, v3, 3).
ve(v2, v4, 3).
ve(v2, v5, 2).
ve(v2, v7, 2).
ve(v3, v5, 1).
ve(v3, v6, 4).
ve(v5, v7, 2).
ve(v5, v8, 1).
ve(v6, v7, 3).

retransmissor([v1,v2,v3,v5,v6]).

empresa(a, [v1, v3, v4]).
empresa(b, [v2, v5, v6, v7]).
empresa(c, [v8]).

% 1

retrans_emp(Lista):-
	retransmissor(ListaTotal),
	findall(
		(Nome, Numero),
		%(empresa(Nome, Lista), intersection(ListaTotal, Lista, NovaLista), length(NovaLista, Numero)),
		(empresa(Nome, Lista), contar_v(Lista, ListaTotal, Numero)),
		Lista
	).
	
contar_v([], _, 0):-!.
contar_v([Elem|Lista], ListaTotal, Numero):-member(Elem, ListaTotal), !, contar_v(Lista, ListaTotal, N), Numero is N + 1.
contar_v([_|Lista], ListaTotal, Numero):-contar_v(Lista, ListaTotal, Numero).

% 2

caminho_qos(Orig, Dest, Caminho, QoS):-caminho_qos1([[Orig]], Dest, Caminho), reverse(Caminho, CaminhoInv), menor_qos(CaminhoInv, QoS).

caminho_qos1([Prim|_], Dest, Prim):-Prim=[Dest|_].
caminho_qos1([[Dest|_]|Resto], Dest, Perc):-!, caminho_qos1(Resto, Dest, Perc).
caminho_qos1([[Ult|T]|Outros], Dest, Perc):-
	findall([Z, Ult|T], (ve(Ult, Z, _), not(member(Z, [Ult|T]))), Lista),
	append(Outros, Lista, NPerc), caminho_qos1(NPerc, Dest, Perc).

menor_qos([Veiculo1, Veiculo2|[]], QoS):-ve(Veiculo1, Veiculo2, QoS).
menor_qos([Veiculo1, Veiculo2|Caminho], QoS):-ve(Veiculo1, Veiculo2, QoS1), menor_qos([Veiculo2|Caminho], QoS2), menor(QoS1, QoS2, QoS).

menor(QoS1, QoS2, QoS1):-QoS1 < QoS2, !.
menor(_, QoS2, QoS2).

% 3

caminho_melhor_qos(V1, V2, Caminho, QoS, Empresas):-
	findall((MinQoS, CaminhoPossivel), (caminho_qos(V1, V2, CaminhoPossivel, MinQoS)), Lista),
	sort(Lista, ListaOrdenada), reverse(ListaOrdenada,  [(QoS, Caminho)|_]),
	findall(Empresa, (empresa(Empresa, ListaVeiculos), intersection(ListaVeiculos, Caminho, Interseccao), length(Interseccao, Tamanho), Tamanho > 0), Empresas).
	

