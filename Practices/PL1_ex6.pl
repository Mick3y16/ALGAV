homem(joao).
homem(miguel).
homem(antonio).
mulher(maria).
mulher(joana).
mulher(susana).
mulher(ana).
cabelo(joao, loiro).
cabelo(miguel, preto).
cabelo(antonio, preto).
cabelo(maria, moreno).
cabelo(joana, loiro).
cabelo(susana, loiro).
cabelo(ana, moreno).
possui(miguel, ouro).
possui(joana, ouro).
possui(ana, carro).
possui(joao, carro).
rico(X):-possui(X, ouro).
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