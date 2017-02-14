mdc(A, B, C):-A < B, divisible(A, B, A, C).
mdc(A, B, C):-divisible(B, A, B, C).


divisible(_, _, 1, 1).
divisible(A, B, C, D):-A mod C =:= 0, B mod C =:= 0, D is C.
divisible(A, B, C, D):-C1 is C-1, divisible(A, B, C1, D). 


%C1 is C+1, divisible(A, B, C1, D1), (, D is C)

%6. Escreva o predicado mdc(A,B,C) que dados os número A e B determine o seu máximo divisor comum (C)