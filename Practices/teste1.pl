%produto (nome, produto, preço)
produto(p1, 423, 11).
produto(p2, 567, 197).
produto(p3, 128, 99).
produto(p4, 256, 299).
produto(p5, 511, 347).

%stock (produto, quantidade)
stock(423, 36).
stock(567, 200).
stock(128, 5).
stock(256, 93).
stock(511, 489).

%encomenda(cliente, produto, quantidade)
encomenda('M. Santos',423, 30).
encomenda('E. Silva', 567, 100).
encomenda('B. Costa', 511, 194).
encomenda('B. Costa', 256, 972).
encomenda('M. Santos',128, 12).

lista(C):-(write(C), nl, encomenda(C, P, Q), produto(N, P, S), write(P), write(' '), write(N), write(' '), write(Q), write(' '), T is Q * S, write(T), nl, fail); true.

com_stock(C):-encomenda(C, P, Q), stock(P, S), Q < S.
sem_stock(C):-encomenda(C, P, Q), stock(P, S), Q > S.

prontaExpedir(C):-com_stock(C), not(sem_stock(C)).
