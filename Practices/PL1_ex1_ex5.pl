homem(manuel).
homem(fernando).
homem(jose).
homem(anibal).
homem(francisco).
homem(alvaro).
homem(carlos).
homem(paulo).
homem(ricardo).
homem(daniel).
homem(samuel).
mulher(maria).
mulher(marta).
mulher(delfina).
mulher(diana).
mulher(alzira).
mulher(zulmira).
mulher(fatima).
mulher(adriana).
mulher(celia).
mulher(sara).
casados(alvaro,celia).
casados(manuel,maria).
casados(jose,marta).
casados(anibal,alzira).
casados(fernando,diana).
casados(carlos,zulmira).
casados(paulo,fatima).
descendente_directo(marta,manuel,maria).
descendente_directo(fernando,manuel,maria).
descendente_directo(delfina,jose,marta).
descendente_directo(diana,anibal,alzira).
descendente_directo(francisco,anibal,alzira).
descendente_directo(alvaro,anibal,alzira).
descendente_directo(carlos, fernando,diana).
descendente_directo(paulo, fernando,diana).
descendente_directo(ricardo, carlos,zulmira).
descendente_directo(daniel, carlos,zulmira).
descendente_directo(adriana,paulo,fatima).
descendente_directo(samuel,paulo,fatima).
descendente_directo(sara,alvaro,celia).
filho(X,Y):-homem(X),(descendente_directo(X,Y,_);descendente_directo(X,_,Y)).
filha(X,Y):-mulher(X),(descendente_directo(X,Y,_);descendente_directo(X,_,Y)).
pai(X,Y):-homem(X),descendente_directo(Y,X,_).
mae(X,Y):-mulher(X),descendente_directo(Y,_,X).
avo(X,Y):-mae(X,Z),(pai(Z,Y);mae(Z,Y)).
avoo(X,Y):-pai(X,Z),(pai(Z,Y);mae(Z,Y)).
neto(X,Y):-filho(X,Z),(filho(Z,Y);filha(Z,Y)).
neta(X,Y):-filha(X,Z),(filho(Z,Y);filha(Z,Y)).
irmao(X,Y):-filho(X,Z),(pai(Z,Y);mae(Z,Y)).
irma(X,Y):-filha(X,Z),(pai(Z,Y);mae(Z,Y)).
tio(X,Y):-irmao(X,Z),(filho(Y,Z);filha(Y,Z));tia(Z,Y),casados(X,Z).
tia(X,Y):-irma(X,Z),(filho(Y,Z);filha(Y,Z));tia(Z,Y),casados(Z,X).
sobrinho(X,Y):-homem(X),(tia(Y,X);tio(Y,X)).
sobrinha(X,Y):-mulher(X),(tia(Y,X);tio(Y,X)).
ascendente(X,Y):-pai(X,Y);mae(X,Y).
ascendente(X,Y):-(pai(X,Z);mae(X,Z)), ascendente(Z,Y).
descendente(X,Y):-ascendente(Y,X).
