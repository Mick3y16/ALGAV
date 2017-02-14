liga(a,b).
liga(a,c).
liga(a,d).
liga(b,e).
liga(b,f).
liga(c,f).
liga(c,g).
liga(d,g).
liga(d,h).
liga(d,i).
liga(e,j).
liga(f,j).
liga(f,k).
liga(g,f).
liga(g,o).
liga(g,h).
liga(h,l).
liga(i,l).
liga(j,m).
liga(j,n).
liga(k,n).
liga(k,p).
liga(l,p).

caminho(X, X):-write(X).
caminho(X, Y):-liga(Z, Y), caminho(X, Z), write(Z).