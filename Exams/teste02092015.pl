
linha('1').
linha('2').

ligacao('La Defense', 'Esplanade de la Defense', '1', 1).
ligacao('Reuilly-Diderot', 'Nation', '1', 1).
ligacao('Avron', 'Nation', '2', 3).
ligacao(A, B, C, D):-ligacao(B, A, C, D).

cruzamento(1, 2, 'Nation').

poi('Louvre', 120, ['Palais Royal-Musee du Louvre', 'Louvre-Rivoli'], 540, 1140).

% 1

aberto(POI, HoraAtual, ListaEstacoesProximas, HoraFimVisita):-
	poi(POI, TempoVisita, ListaEstacoesProximas, HoraAbertura, HoraFecho),
	HoraAtual >= HoraAbertura,
	HoraAtual + TempoVisita =< HoraFecho,
	HoraFimVisita is HoraAtual + TempoVisita.

% 2
	
caminho(EstOrig, EstOrig, []):-!.
caminho(EstOrig, EstDest, [(EstOrig, EstInt, Linha)|Caminho]):-
	ligacao(EstOrig, EstInt, Linha, _), !,
	caminho(EstInt, EstDest, Caminho).
caminho(EstOrig, EstDest, [(EstOrig, EstInt, Linha)|Caminho]):-
	ligacao(EstInt, EstOrig, Linha, _), !,
	caminho(EstInt, EstDest, Caminho).

% 3

tempo_percurso([], HoraInicio, HoraInicio):-!.
tempo_percurso([(EstOrig, EstDest, _)|Caminho], HoraInicio, HoraFim):-
	ligacao(EstOrig, EstDest, _, Tempo),
	tempo_percurso(Caminho, HoraInicio, HoraAcumulada), HoraFim is HoraAcumulada + Tempo.
