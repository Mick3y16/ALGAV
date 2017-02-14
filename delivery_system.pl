ar(amesterdam, paris, 430).
ar(berlin, paris, 878).
ar(copenhagen, helsinki, 884).
ar(copenhagen, oslo, 484).
ar(copenhagen, stockholm, 523).
ar(dublin, paris, 836).
ar(lisbon, madrid, 503).
ar(london, paris, 344).
ar(madrid, paris, 1054).
ar(paris, rome, 1107).
ar(paris, vienna, 1035).
% Verifica todas as alternativas existentes em viagens por ar.
por_ar(X, Y, Z):-ar(X, Y, Z); ar(Y, X, Z).
terra(amesterdam, brussels, 210).
terra(amesterdam, paris, 501).
terra(andorra, liublijana, 1430).
terra(andorra, madrid, 609).
terra(andorra, paris, 861).
terra(berlin, copenhagen, 356).
terra(berlin, paris, 1048).
terra(berlin, prague, 351).
terra(berlin, tallin, 1042).
terra(berlin, warsaw, 572).
terra(bratislava, budapest, 200).
terra(bratislava, vienna, 79).
terra(copenhagen, oslo, 606).
terra(copenhagen, stockholm, 657).
terra(dublin,paris, 1083).
terra(lisbon, madrid, 625).
terra(lisbon, porto, 313).
terra(liublijana, vienna, 384).
terra(liublijana, zagreb, 140).
terra(london, paris, 464).
terra(luxembourg, paris, 374).
terra(madrid, paris, 1276).
terra(madrid, porto, 561).
terra(oslo, stockholm, 521).
terra(paris, rome, 1424).
terra(paris, vienna, 1236).
terra(prague, vienna, 309).
terra(riga, tallin, 309).
terra(riga, vilnius, 302).
terra(vilnius, warsaw, 459).
% Verifica todas as alternativas existentes em viagens por terra.
por_terra(X, Y, Z):-terra(X, Y, Z); terra(Y, X, Z).
% Verifica todas as alternativas existentes em viagens.
viagem(X, Y, Z, ar):-por_ar(X, Y, Z).
viagem(X, Y, Z, terra):-por_terra(X, Y, Z).

% Dias nos meses do ano. year % 400 = 0 || year % 100 != 0 && year % 4 == 0
mes(1, 31, _).% Janeiro
mes(2, 29, YYYY):-0 is YYYY mod 400, !.
mes(2, 29, YYYY):-0 is YYYY mod 4, not(0 is YYYY mod 100), !.
mes(2, 28, _).
mes(3, 31, _).% Março
mes(4, 30, _).% Abril
mes(5, 31, _).% Maio
mes(6, 30, _).% Junho
mes(7, 31, _).% Julho
mes(8, 31, _).% Agosto
mes(9, 30, _).% Setembro
mes(10, 31, _).% Outubro
mes(11, 30, _).% Novembro
mes(12, 31, _).% Dezembro

/* date(Y,M,D) - Date using the same values as described above. Extracted using date_time_value/3.
time(H,Mn,S) - Time using the same values as described above. Extracted using date_time_value/3. */
% Determina o tempo necessário de espera até que seja possível seguir viagem.
determinar_tempo_espera(ar, Data, time(HH, MM, SS), Data, time(HH, MM, SS)):-day_of_the_week(Data, 2), 6 is HH, 0 is MM, !.% Via aérea 3as às 6h.
determinar_tempo_espera(ar, Data, time(HH, MM, SS), Data, time(HH, MM, SS)):-day_of_the_week(Data, 4), 6 is HH, 0 is MM, !.% Via aérea 5as às 6h.
determinar_tempo_espera(ar, Data, time(HH, MM, SS), Data, time(HH, MM, SS)):-day_of_the_week(Data, 6), 6 is HH, 0 is MM, !.% Via aérea sábados às 6h.
determinar_tempo_espera(terra, Data, time(HH, MM, SS), Data, time(HH, MM, SS)):-7 is HH, 0 is MM, !.% Via terrestre diário às 7h.
determinar_tempo_espera(terra, Data, time(HH, MM, SS), Data, time(HH, MM, SS)):-12 is HH, 0 is MM, !.% Via terrestre diário às 12h.
% Incrementa o ano.
determinar_tempo_espera(Tipo, date(YYYY, MN, DD), time(HH, __, SS), DataFinal, HoraFinal):-
	0 is (HH + 1) mod 24, mes(MN, DL, YYYY), (DD+1) > DL, (MN + 1) > 12, TYYYY is YYYY + 1, !,
	determinar_tempo_espera(Tipo, date(TYYYY, 1, 1), time(0, 0, SS), DataFinal, HoraFinal).
% Incrementa o mês.
determinar_tempo_espera(Tipo, date(YYYY, MN, DD), time(HH, _, SS), DataFinal, HoraFinal):-
	0 is (HH + 1) mod 24, mes(MN, DL, YYYY), (DD+1) > DL, TMN is MN + 1, !,
	determinar_tempo_espera(Tipo, date(YYYY, TMN, 1), time(0, 0, SS), DataFinal, HoraFinal).
% Incrementa o dia.
determinar_tempo_espera(Tipo, date(YYYY, MN, DD), time(HH, _, SS), DataFinal, HoraFinal):-
	0 is (HH + 1) mod 24, TDD is DD+1, !,
	determinar_tempo_espera(Tipo, date(YYYY, MN, TDD), time(0, 0, SS), DataFinal, HoraFinal).
% Incrementa a hora.
determinar_tempo_espera(Tipo, Data, time(HH, _, SS), DataFinal, HoraFinal):-THH is HH + 1, !,
	determinar_tempo_espera(Tipo, Data, time(THH, 0, SS), DataFinal, HoraFinal).

% Determina a duração de uma viagem com base na distancia e na velocidade.
duracao(Distancia, Velocidade, time(HH, MM, 00)):-HH is Distancia // Velocidade, MM is floor(((Distancia / Velocidade) - HH) * 60).

% Determina a hora resultante da soma de duas outras, descobrindo se houve mudança de dia ou não.
soma_tempo(time(EHH, EMM, _), time(HH, MM, _), time(NHH, NMM, 00), 1):-
	EMM + MM >= 60, (EHH + HH + 1) >= 24, NMM is (EMM+MM) mod 60, NHH is (EHH+HH+1) mod 24, !.
soma_tempo(time(EHH, EMM, _), time(HH, MM, _), time(NHH, NMM, 00), 0):-
	EMM + MM >= 60, (EHH + HH + 1) < 24, NMM is (EMM+MM) mod 60, NHH is EHH+HH+1, !.
soma_tempo(time(EHH, EMM, _), time(HH, MM, _), time(NHH, NMM, 00), 1):-
	(EHH + HH) >= 24, NMM is EMM+MM, NHH is (EHH+HH) mod 24, !.
soma_tempo(time(EHH, EMM, _), time(HH, MM, _), time(NHH, NMM, 00), 0):-NHH is EHH+HH, NMM is EMM+MM.

% Determina o tempo dispendido na viagem devolvendo a hora de chegada.
determinar_tempo_viagem(Distancia, ar, Data, Hora, DataFinal, HoraFinal):-!,
	duracao(Distancia, 500, Duracao), determinar_tempo_viagem(Duracao, Data, Hora, DataFinal, HoraFinal).
determinar_tempo_viagem(Distancia, terra, Data, Hora, DataFinal, HoraFinal):-!,
	duracao(Distancia, 80, Duracao), determinar_tempo_viagem(Duracao, Data, Hora, DataFinal, HoraFinal).

determinar_tempo_viagem(Duracao, Data, Hora, Data, HoraFinal):-soma_tempo(Duracao, Hora, HoraFinal, D), 0 =:= D, !.
% Incrementa o ano.
determinar_tempo_viagem(Duracao, date(YYYY, MN, DD), Hora, date(NYYYY, 1, 1), HoraFinal):-
	soma_tempo(Duracao, Hora, HoraFinal, 1), mes(MN, DL, YYYY), DD + 1 > DL, MN + 1 > 12, NYYYY is YYYY + 1, !.
% Incrementa o mês.
determinar_tempo_viagem(Duracao, date(YYYY, MN, DD), Hora, date(YYYY, NMN, 1), HoraFinal):-
	soma_tempo(Duracao, Hora, HoraFinal, 1), mes(MN, DL, YYYY), DD + 1 > DL, NMN is MN + 1, !.
% Incrementa o dia.
determinar_tempo_viagem(Duracao, date(YYYY, MN, DD), Hora, date(YYYY, MN, NDD), HoraFinal):-
	soma_tempo(Duracao, Hora, HoraFinal, 1), NDD is DD + 1.

% Calcula o preço da viagem tendo em conta o meio e a distância.
calcular_preco(Distancia, Peso, ar, Preco):-Preco is Distancia*Peso*0.05.%€ por km e kg de peso.
calcular_preco(Distancia, Peso, terra, Preco):-Preco is Distancia*Peso*0.01.%€ por km e kg de peso

% Calcula a rota mais rápida entre dois pontos.
rota(Orig, Dest, Peso, DD-MN-YYYY, HH:MM:SS, RotaR, Preco, DataChegada, HoraChegada):-
	rota1(Orig, Dest, Peso, date(YYYY, MN, DD), time(HH, MM, SS), 0, [], Rota, Preco, DataChegada, HoraChegada), reverse(Rota, RotaR).
rota1(Dest, Dest, _, DataPartida, HoraPartida, Preco, RotaTemporaria, RotaTemporaria, Preco, DataPartida, HoraPartida).
rota1(Orig, Dest, Peso, DataPartida, HoraPartida, Preco, RotaTemporaria, Rota, PrecoFinal, DataChegada, HoraChegada):-
	viagem(Orig, Entre, Distancia, Tipo), not(member((Entre -> _ -> _), RotaTemporaria)),
	determinar_tempo_espera(Tipo, DataPartida, HoraPartida, DataPartidaEspera, HoraPartidaEspera),
	determinar_tempo_viagem(Distancia, Tipo, DataPartidaEspera, HoraPartidaEspera, DataChegadaViagem, HoraChegadaViagem),
	calcular_preco(Distancia, Peso, Tipo, PrecoViagem), PrecoIntermedio is Preco + PrecoViagem,
	rota1(Entre, Dest, Peso, DataChegadaViagem, HoraChegadaViagem, PrecoIntermedio, [(Orig -> Tipo -> Entre)|RotaTemporaria], Rota, PrecoFinal, DataChegada, HoraChegada).

/* 2. Determinar qual o percurso mais barato e mais rápido.	*/

rotas(Orig, Dest, Peso, DD-MN-YYYY, HH:MM:SS, Lista, ListaBarata, ListaRapida):-
findall([Preco, (DataChegada, HoraChegada), RotaR], rota(Orig, Dest, Peso, DD-MN-YYYY, HH:MM:SS, RotaR, Preco, DataChegada, HoraChegada), Lista), sort(0, @=<, Lista, [ListaBarata|_]),
sort([2,1], @=<, Lista, [ListaRapida|_]).

printLista([[Preco, (DataChegada, HoraChegada), RotaR]|[]]):-write('Preco: '), write(Preco), nl, write('Dia de Chegada: '), write(DataChegada), nl, write('Hora de Chegada: '),write(HoraChegada), nl, write('Caminho: '), write(RotaR), nl, write('------------------------------'), nl,!.
printLista([[Preco, (DataChegada, HoraChegada), RotaR]|L]):-write('Preco: '), write(Preco), nl, write('Dia de Chegada: '), write(DataChegada), nl, write('Hora de Chegada: '), write(HoraChegada), nl, write('Caminho: '), write(RotaR),nl,
write('------------------------------'), nl, printLista(L).

rotas(Orig, Dest, Peso, DD-MN-YYYY, HH:MM:SS):-
findall([Preco, (DataChegada, HoraChegada), RotaR], rota(Orig, Dest, Peso, DD-MN-YYYY, HH:MM:SS, RotaR, Preco, DataChegada, HoraChegada), Lista), write('Caminhos: '), nl,
printLista(Lista), sort([2,1], @=<, Lista, [ListaRapida|_]), printMaisRapido(ListaRapida),  sort(0, @=<, Lista, [ListaBarata|_]), printMaisBarato(ListaBarata).

printMaisBarato([Preco, _, RotaR| _]):- write('Caminho mais Barato: '), nl, write('Preco: '), write(Preco), nl, write('Caminho: '), write(RotaR), nl.
printMaisRapido([_, (DataChegada, HoraChegada), RotaR| _]):- write('Caminho mais Rapido: '), nl, write('Dia de Chegada: '), write(DataChegada), nl, write('Hora de Chegada: '), write(HoraChegada), nl, write('Caminho: '), write(RotaR), nl, write('------------------------------'), nl .

% Pontos de entrega (Ponto, X, Y)
% Assumindo uma velocidade de deslocação média de 41Km/h (approx. 700m/min) e que cada coordenada equivale a aproximadamente 700metros.
coordenadas(1,10,50):-!.
coordenadas(2,30,20):-!.
coordenadas(3,60,70):-!.
coordenadas(4,60,50):-!.
coordenadas(5,50,30):-!.
coordenadas(6,70,30):-!.
coordenadas(7,100,60):-!.
coordenadas(8,100,60):-!.
coordenadas(9,90,40):-!.
coordenadas(10,100,10):-!.
coordenadas(11,120,130):-!.
coordenadas(12,120,10):-!.
coordenadas(13,140,50):-!.
coordenadas(14,140,20):-!.

% Base de conhecimento relativa a encomendas.
% Uma encomanda pode ter uma data/intervalo de entrega ou não.
% Base 1 - Nenhuma encomenda tem data de entrega, todas são livres.
encomenda(1, 1, []).
encomenda(2, 2, []).
encomenda(3, 3, []).
encomenda(4, 4, []).
encomenda(5, 5, []).
encomenda(6, 6, []).
encomenda(7, 7, []).
encomenda(8, 8, []).
encomenda(9, 9, []).
encomenda(10, 10, []).
encomenda(11, 11, []).
encomenda(12, 12, []).
encomenda(13, 13, []).
encomenda(14, 14, []).
encomenda(15, 14, []).

%Base 2
/*encomenda(1, 1, [time(9, 0, 0)]).
encomenda(2, 2, [time(9, 30, 0)]).
encomenda(3, 3, [time(10, 0, 0)]).
encomenda(4, 4, [time(10, 30, 0)]).
encomenda(5, 5, [time(11, 0, 0)]).
encomenda(6, 6, [time(11, 30, 0)]).
encomenda(7, 7, [time(12, 0, 0)]).
encomenda(8, 8, [time(12, 30, 0)]).
encomenda(9, 9, [time(13, 0, 0)]).
encomenda(10, 10, [time(13, 30, 0)]).
encomenda(11, 11, [time(14, 0, 0)]).
encomenda(12, 12, [time(14, 30, 0)]).
encomenda(13, 13, [time(15, 0, 0)]).
encomenda(14, 14, [time(15, 30, 0)]).
encomenda(15, 14, [time(10, 0, 0)]).*/

%Base 3
/*encomenda(1, 1, [time(8, 0, 0),time(11, 0, 0)]).
encomenda(2, 2, [time(9, 30, 0),time(14, 0, 0)]).
encomenda(3, 3, [time(10, 0, 0),time(12, 0, 0)]).
encomenda(4, 4, [time(10, 30, 0),time(13, 30, 0)]).
encomenda(5, 5, [time(11, 0, 0),time(15, 0, 0)]).
encomenda(6, 6, [time(11, 30, 0),time(12, 30, 0)]).
encomenda(7, 7, [time(12, 0, 0),time(19, 0, 0)]).
encomenda(8, 8, [time(12, 30, 0),time(15, 50, 0)]).
encomenda(9, 9, [time(13, 0, 0),time(17, 20, 0)]).
encomenda(10, 10, [time(13, 30, 0),time(16, 20, 0)]).
encomenda(11, 11, [time(14, 0, 0),time(18, 0, 0)]).
encomenda(12, 12, [time(14, 30, 0),time(20, 0, 0)]).
encomenda(13, 13, [time(15, 0, 0),time(16, 0, 0)]).
encomenda(14, 14, [time(15, 30, 0),time(17, 0, 0)]).
encomenda(15, 14, [time(10, 0, 0),time(19, 30, 0)]).
*/

%Base 4
/*
encomenda(1, 1, [time(19, 0, 0)]).
encomenda(2, 2, [time(9, 30, 0)]).
encomenda(3, 3, [time(10, 0, 0),time(12, 0, 0)]).
encomenda(4, 4, []).
encomenda(5, 5, []).
encomenda(6, 6, [time(11, 30, 0),time(12, 30, 0)]).
encomenda(7, 7, []).
encomenda(8, 8, [time(12, 30, 0),time(15, 50, 0)]).
encomenda(9, 9, []).
encomenda(10, 10, []).
encomenda(11, 11, [time(14, 0, 0),time(18, 0, 0)]).
encomenda(12, 12, []).
encomenda(13, 13, []).
encomenda(14, 14, [time(15, 30, 0)]).
encomenda(15, 14, [time(10, 0, 0)]).
*/

% Configurações para um dia normal de trabalho.
ponto_partida(1).
hora_partida(time(8, 0, 0)).
hora_saida(time(17, 0, 0)).

% Calcula a distancia entre dois pontos de entrega.
distancia(O, D, R):-coordenadas(D, XD, YD), coordenadas(O, XO, YO), R is floor(sqrt((XD-XO)*(XD-XO)+(YD-YO)*(YD-YO))), !.

% Diferença em minutos entre duas horas.
diferenca_minutos(time(H1, M1, _), time(H2, M2, _), D):-D is ((H2 - H1)* 60) + ((M2 - M1) mod 60).

% Garante que uma encomenda ainda é passivel de ser entregue.
nao_falhou_entrega(_, []) :-!.
nao_falhou_entrega(HoraAtual, HoraEntrega):-!, compare((>), HoraEntrega, HoraAtual), hora_saida(H), compare((<), HoraAtual, H).

% Incrementa o tempo, após a deslocação e entrega de uma encomenda.
entregar_encomenda(time(H, M, S), Incremento, time(NH, NM, S)):-1 is (M + 10 + Incremento) // 60, !,
	NM is (M + 10 + Incremento) mod 60, NH is H + 1.
entregar_encomenda(time(H, M, S), Incremento, time(H, NM, S)):-NM is (M + 10 + Incremento) mod 60.

% Estimativa que determina a urgencia de escolher um caminho.
estimativa(O, T, (D, []), E, NT):-distancia(O, D, Dist), E is Dist, Incremento is Dist, entregar_encomenda(T, Incremento, NT), !.
estimativa(O, T, (D, [TI, TF]), E, NT):-
	distancia(O, D, Dist), diferenca_minutos(T, TF, DifTemp),
	E is Dist + (floor(DifTemp * 1.5)) - 10, Incremento is (Dist // 10),
	entregar_encomenda(T, Incremento, NT),
	nao_falhou_entrega(TI, NT), nao_falhou_entrega(NT, TF), !.
estimativa(_, _, (_, [_,_]), 100000, time(0,0,0)).
estimativa(O, T, (D, [TF]), E, NT):-
	distancia(O, D, Dist), diferenca_minutos(T, TF, DifTemp),
	E is Dist + (floor(DifTemp * 1.5)) - 10, Incremento is (Dist // 10),
	entregar_encomenda(T, Incremento, NT),
	nao_falhou_entrega(NT, TF), !.
estimativa(_, _, (_, [_]), 50000, time(0,0,0)).

% Restringe o comprimento de uma lista, de forma a optimizar os resultados.
restringir_pesquisa(Lista, ListaRestringida):-restringir_pesquisa(0, Lista, ListaRestringida).
restringir_pesquisa(_, [], []).
restringir_pesquisa(5, _, []).
restringir_pesquisa(N, [Elemento|Lista], [Elemento|ListaRestringida]):-N1 is N + 1, restringir_pesquisa(N1, Lista, ListaRestringida).

% Determina e extrai o menor percurso de dentro duma lista, gerando uma nova sem o percurso extraido.
menor_percurso(Percursos, Menor, Restantes):-sort(0, @<, Percursos, Ordenados), restringir_pesquisa(Ordenados, [Menor|Restantes]).

% Imprime os resultados da solução ótima.
imprimir_resultados(Total, Percurso):-
	imprimir(Percurso),
	write('Estimativa total: '), write(Total), nl.
imprimir([(IDEncomenda, PontoEntrega, HoraEntrega, HoraEntregue)|[]]):-
	write('ID Encomenda: '), write(IDEncomenda), nl,
	write('Ponto de Entrega: '), write(PontoEntrega), nl,
	write('Hora de Entrega: '), write(HoraEntrega), nl,
	write('Hora de Entrega na Realidade: '), write(HoraEntregue), nl, !.
imprimir([(IDEncomenda, PontoEntrega, HoraEntrega, HoraEntregue)|T]):-
	write('ID Encomenda: '), write(IDEncomenda), nl,
	write('Ponto de Entrega: '), write(PontoEntrega), nl,
	write('Hora de Entrega: '), write(HoraEntrega), nl,
	write('Hora de Entrega na Realidade: '), write(HoraEntregue), nl,
	write('------------------------------'), nl,  imprimir(T).

% Determina a solução ótima de entrega de encomendas.
shinning_star():-
	ponto_partida(PontoPartida), hora_partida(Hora), % Local e hora de partida
	findall(
		(Estimativa, HoraEntregue, [(IDEncomenda, PontoEntrega, HoraEntrega, HoraEntregue)]),
			(encomenda(IDEncomenda, PontoEntrega, HoraEntrega),
			estimativa(PontoPartida, Hora, (PontoEntrega, HoraEntrega), Estimativa, HoraEntregue)),
		Lista),
	length(Lista, TamanhoLista),
	shinning_star(TamanhoLista, Lista, PercursoInvertido, Total), reverse(PercursoInvertido, Percurso), imprimir_resultados(Total, Percurso).

shinning_star(_, [(Total, HoraEntrega, Percurso)|_], Percurso, Total):-
	hora_saida(H), compare((>), HoraEntrega, H), !.
shinning_star(NumeroEncomendas, [(Total, _, Percurso)|_], Percurso, Total):-length(Percurso, NumeroEncomendas), !.
shinning_star(NumeroEncomendas, Percursos, Percurso, Total):-
	menor_percurso(Percursos, Menor, Restantes), !,
	percursos_seguintes(NumeroEncomendas, Menor, Restantes, Percurso, Total), !.

percursos_seguintes(NumeroEncomendas, (Estimativa, Hora, [(IDEncomendaAnterior, PontoEntregaAnterior, HoraEntregaAnterior, HoraEntregue)|L]), Restantes, Percurso, Total):-
	findall(
		(Custo, NovaHoraEntregue, [(IDEncomenda, PontoEntrega, HoraEntrega, NovaHoraEntregue), (IDEncomendaAnterior, PontoEntregaAnterior, HoraEntregaAnterior, HoraEntregue)|L]),
			(
			encomenda(IDEncomenda, PontoEntrega, HoraEntrega),
			not(member((IDEncomenda, PontoEntrega, HoraEntrega, _), [(IDEncomendaAnterior, PontoEntregaAnterior, HoraEntregaAnterior, _)|L])),
			estimativa(PontoEntregaAnterior, Hora, (PontoEntrega, HoraEntrega), EstimativaAdicional, NovaHoraEntregue),
			EstimativaAdicional < 100000,
			Custo is Estimativa + EstimativaAdicional
			),
		Lista),
	analisa_situacao(Lista, NumeroEncomendas, (Estimativa, Hora, [(IDEncomendaAnterior, PontoEntregaAnterior, HoraEntregaAnterior, HoraEntregue)|L]), Restantes, Percurso, Total).

analisa_situacao(Lista, NumeroEncomendas, (Estimativa, HoraEntregue, Percursos), Restantes, Percurso, Total):-
	length([1|Lista], 1), !,
	avancar_tempo(HoraEntregue, NovaHoraEntregue),
	shinning_star(NumeroEncomendas, [(Estimativa, NovaHoraEntregue, Percursos)|Restantes], Percurso, Total).
	
analisa_situacao(Lista, NumeroEncomendas, _, Restantes, Percurso, Total):-
	restringir_pesquisa(Lista, ListaRestringida),
	append(ListaRestringida, Restantes, NovosPercursos),
	shinning_star(NumeroEncomendas, NovosPercursos, Percurso, Total).
	

% Avança o tempo ao minuto sempre que não é possível gerar resultados.
avancar_tempo(time(H, M, S), time(NH, 00, S)):-1 is (M + 1) // 60, !, NH is H + 1.
avancar_tempo(time(H, M, S), time(H, NM, S)):-NM is M + 1.