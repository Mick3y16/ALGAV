hanoi(N):-move(N, esquerda, centro, direita, 1, _).
move(1, A, B, C, I1, I2):-informa(A, B, I1, I2).
move(N, A, B, C, I1, I4):-M is N-1, move(M, A, C, B, I1, I2), move(1, A, B, _, I2, I3), move(M, C, B, A, I3, I4).
informa(A, B, I1, I2):-write(I1), write(' - Mover disco de '), write(A), write(' para '), write(B), I2 is I1+1, nl.