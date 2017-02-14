cor(ceu, azul).
cor(ceu, cinzento).
cor(ceu, preto).
cor(mar, azul).
cor(mar, verde).
cor(mar, cinzento).
cor(via, cinzenta).
cor(via, castanha).
cor(via, preta).
transporte(ceu,aviao).
transporte(ceu,helicoptero).
transporte(ceu,foguete).
transporte(mar,navio).
transporte(mar,lancha).
transporte(via,carro).
transporte(via,camiao).
transporte(via,mota).
transporte(via,autocarro).
nega(X):-call(X), !, fail.
nega(_).
se_entao_senao(A, B, _):-call(A), !, call(B).
se_entao_senao(_, _, C):-call(C).
/*teste1():-se_entao_senao(cor(mar,verde),
	(write(ok),nl,write('...'),nl),
	(write(falhou),nl,write('...'),nl)).
teste2():-se_entao_senao(cor(mar,vermelho),
	(write(ok),nl,write('...'),nl),
	(write(falhou),nl,write('...'),nl)).*/
se_entao(A, B):-call(A), call(B).
se_entao(_, _).

questao(X):-
write('Qual o atributo? '), read(P),
write('Qual o objeto? '), read(O), repeat,
write('Qual o valor do/da '), write(P), write(' do/da '), write(O), write('? '), read(X),
C=..[P, O, X], call(C).

/*
a) Implemente um predicado que simule a negação da chamada de outro predicado com todos os argumentos instanciados. Por
	exemplo, a chamada a nega(cor(ceu,azul)) falha enquanto que a chamada a nega(transporte(mar,carro)) tem sucesso.

b) Implemente um predicado se_entao_senao que tenha 3 argumentos. O primeiro é o predicado de teste, o segundo é a consequência que
	ocorrerá se o predicado de teste tiver sucesso e o terceiro é a consequência caso o predicado de teste falhe. Por exemplo, a chamada:

c) Implemente um predicado se_entao que tenha 2 argumentos. O primeiro é o predicado de teste e o segundo é a consequência que ocorrerá se o
	predicado de teste tiver sucesso. Independentemente do sucesso ou insucesso do predicado de teste, o se_entao deverá ter sempre sucesso.

d) Implemente um predicado questao(Valor) que peça ao utilizador um atributo (cor ou transporte) e um objecto (ceu, mar ou via) e pergunte ao utilizador
	“Qual o valor do/da <atributo> do/da <objecto>?” (por exemplo: “Qual o valor do/da cor do/da mar?”. O mesmo utilizador responde a essa questão. Se a
	resposta for válida o predicado tem sucesso, caso contrário volta a ser posta a mesma questão ao utilizador, até que este dê uma resposta acertada.
	Por exemplo: ?- questao(Valor).
	Qual é o atributo? cor.
	Qual é o objecto? mar.
	Qual o valor do/da cor do/da mar? vermelho.
	Qual o valor do/da cor do/da mar? castanho.
	Qual o valor do/da cor do/da mar? branco.
	Qual o valor do/da cor do/da mar? verde.
	Valor=verde
	Nota: o operador =.. , usado na forma Predicado=..Lista, converte
	bidireccionalmente um predicado numa lista em que o primeiro elemento da
	lista é o nome do functor e os outros elementos da lista são os vários
	argumentos do predicado.
*/