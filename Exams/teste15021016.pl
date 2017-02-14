%% 1

decoder([], []):-!.
decoder([E|L], NL):-extractor(E, LE), decoder(L, LN1), append(LE, LN1, NL).

extractor((_, 0), [nop]):-!. 
extractor((E, 1), [E]):-!.
extractor((E, N), [E|LE]):-N1 is N - 1, extractor((E, N1), LE).

%% 2

liga(a, b).
liga(a, c).
liga(a, d).
liga(b, e).
liga(b, f).
liga(f, h).
liga(d, g).

geraNos(N, L):-findall(E, (liga(N, ON), geraNos(ON, 1, E)), L).

geraNos(N, H, (N, H)):-not(liga(N, _)), !.
geraNos(N, H, L):-liga(N, ON), H1 is H + 1, geraNos(ON, H1, L).

%% 3

:- dynamic no/2.
:- dynamic ramo/3.

no(a, 0).
no(b, 0).
no(c, 0).
no(d, 1).
no(e, 1).
no(f, 0).
no(g, 0).
no(h, 0).

ramo(a, b, 2).
ramo(b, c, 1).
ramo(c, d, 3).
ramo(d, e, 4).
ramo(e, f, 2).
ramo(f, g, 3).
ramo(g, h, 3).
ramo(g, d, 2).

calcGrauNo(N, G):-findall(N, (ramo(N, _, _) ; ramo(_, N, _)), L), length(L, G).

remover_nos([]):-!.
remover_nos([No|ListaNos]):-retract(no(No, 0)), concatena_ramos(No), remover_nos(ListaNos).

concatena_ramos(No):-ramo(A, No, Peso1), ramo(No, B, Peso2),
	retract(ramo(A, No, Peso1)), retract(ramo(No, B, Peso2)),
	Peso is Peso1 + Peso2, assertz(ramo(A, B, Peso)).

simplifica:-
	findall(No, (no(No, 0), calcGrauNo(No, 2)), ListaNos),
	remover_nos(ListaNos),
	
	findall(no(ID, C), no(ID, C), LN),
	findall(ramo(X, Y, P), ramo(X, Y, P), LR),
	imprime(LN),
	imprime(LR).

imprime([]).
imprime([N|L]):-write(N), nl, imprime(L).



