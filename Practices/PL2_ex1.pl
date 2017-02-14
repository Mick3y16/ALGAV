power(_, 0, 1).
power(X, Y, R):-Y>0, Y1 is Y-1, power(X, Y1, R1), R is X*R1.

factorial(0, 1).
factorial(X, R):-X>0, X1 is X-1, factorial(X1, R1), R is X*R1.

div(X, Y, 0):-X<Y.
div(X, Y, R):-X1 is X-Y, div(X1, Y, R1), R is R1+1.

mod(X, Y, X):-X<Y.
mod(X, Y, R):-X1 is X - Y, mod(X1, Y, R).