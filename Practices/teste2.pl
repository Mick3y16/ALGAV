preProc(L, LC, LE):-preProc1(L, LC, LE, 1).
preProc1([], [], [], _).
preProc1([X|L], [X|LC], LE, N):-X >= 0, N1 is N+1, !, preProc1(L, LC, LE, N1).
preProc1([X|L], [0|LC], [(X, N)|LE], N):-N1 is N+1, preProc1(L, LC, LE, N1).