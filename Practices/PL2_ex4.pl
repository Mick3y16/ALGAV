divisible(X,Y) :- X mod Y =:= 0.
divisible(X,Y) :- Y1 is Y + 1, X / 2 > Y1, divisible(X, Y1).

prime(2).
prime(N):-N < 2, fail.
prime(N):-not(divisible(N, 2)).
