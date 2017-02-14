homem(joao).
homem(miguel).
homem(antonio).
homem(marco).
homem(jose).
homem(joaquim).
homem(manuel).
mulher(maria).
mulher(joana).
mulher(susana).
mulher(ana).
mulher(joaquina).
pai(jose, marco).
pai(joaquim, jose).
pai(manuel, joaquim).
mae(joaquina, marco).
cabelo(joao, loiro).
cabelo(miguel, preto).
cabelo(antonio, preto).
cabelo(jose, loiro).
cabelo(joaquim, loiro).
cabelo(manuel, preto).
cabelo(maria, moreno).
cabelo(joana, loiro).
cabelo(susana, loiro).
cabelo(ana, moreno).
cabelo(joaquina, loiro).
cabelo(X, loiro):-(pai(Y, X), cabelo(Y, loiro), mae(Z, X), cabelo(Z, loiro)).
possui(miguel, ouro).
possui(joana, ouro).
possui(jose, ouro).
possui(ana, carro).
possui(joao, carro).
rico(X):-possui(X, ouro); (pai(Y, X), rico(Y)); (mae(Z, X), rico(Z)).
gosta_ricos(joao).
gosta_ricos(miguel).
gosta_ricos(joana).
gosta_cabelo(joao, loiro).
gosta_cabelo(miguel, moreno).
gosta_cabelo(joana, preto).
gosta_cabelo(maria, preto).
relacao_hetero(X, Y):-(homem(X), mulher(Y));(homem(Y), mulher(X)).
relacao_posse(X, Y):-gosta_ricos(X), !, rico(Y).
relacao_posse(_, _).
cor_cabelo(X, Y):-gosta_cabelo(X, Z), !, cabelo(Y, Z).
cor_cabelo(_, _).
gosta(X, Y):-relacao_hetero(X, Y), relacao_posse(X, Y), cor_cabelo(X, Y).
gosta_mutuo(X, Y):-gosta(X, Y), gosta(Y, X).
ascendente(X,Y):-pai(X,Y);mae(X,Y).
ascendente(X,Y):-(pai(X,Z);mae(X,Z)), ascendente(Z,Y).
mestico(X):-cabelo(X,C1), ascendente(X,Y), cabelo(Y,C2), C1\=C2.
