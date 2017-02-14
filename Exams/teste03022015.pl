% recursos(tipo,listaRecursos)
recursos(doenca,[doenca1,doenca2,doenca3]).
recursos(subAtiva,[subAtiva1,subAtiva2,subAtiva3,subAtiva4,subAtiva5]).
recursos(documento,[documento1,documento2,documento3]).
recursos(medicamento,[medicamentoX,medicamentoY,medicamentoZ,medicamentoK,medicamentoH,medicamentoB,medicamentoH]).
recursos(contraIndicacao,[contraA1,contraA2,contraA3]).
% relacao(recurso, relacao, listaRecursos)
relacao(doenca1,temMedicacao,[subAtiva1,subAtiva2,subAtiva3]).
relacao(doenca2,temMedicacao,[subAtiva2,subAtiva4,subAtiva5]).
relacao(doenca3,temMedicacao,[subAtiva5]).
relacao(documento1,menciona,[doenca1,doenca2,doenca3,contraA2]).
relacao(documento2,menciona,[doenca2,doenca3,contraA3,contraA1]).
relacao(documento3,menciona,[doenca2,medicamentoK]).
relacao(subAtiva1,estaPresenteEm,[medicamentoX,medicamentoY,medicamentoZ]).
relacao(subAtiva2,estaPresenteEm,[medicamentoK]).
relacao(subAtiva3,estaPresenteEm,[medicamentoY,medicamentoK]).
relacao(subAtiva4,estaPresenteEm,[medicamentoA,medicamentoB]).
relacao(subAtiva5,estaPresenteEm,[medicamentoH]).
relacao(medicamentoX,temContraIndicacao,[contraA1]).
relacao(medicamentoY,temContraIndicacao,[contraA1,contraA2]).
relacao(medicamentoH,temContraIndicacao,[contraA3,contraA1]).
relacao(medicamentoK,temContraIndicacao,[contraA3]).

% 1 

ligacaoRecursos(Orig, Orig, [Orig], 0):-!.
ligacaoRecursos(Orig, Dest, [Orig, Relacao|Ligacao], Qtd):-relacao(Orig, Relacao, ListaRecursos), ligacaoListaRecursos(ListaRecursos, Dest, Ligacao, Qtd1), Qtd is Qtd1 + 1.

ligacaoListaRecursos([], _, _, _):-fail, !.
ligacaoListaRecursos([Recurso|_], Dest, Ligacao, Qtd):-ligacaoRecursos(Recurso, Dest, Ligacao, Qtd).
ligacaoListaRecursos([_|ListaRecursos], Dest, Ligacao, Qtd):-ligacaoListaRecursos(ListaRecursos, Dest, Ligacao, Qtd).

% 2

/* 2 Listas
eliminaRepetidos([], []):-!.
eliminaRepetidos([Recurso|ListaRecursos], [Recurso|ListaRecursosSemRepetidos]):-eliminaRepetidos(ListaRecursos, ListaRecursosSemRepetidos), not(member(Recurso, ListaRecursosSemRepetidos)).
eliminaRepetidos([_|ListaRecursos], ListaRecursosSemRepetidos):-eliminaRepetidos(ListaRecursos, ListaRecursosSemRepetidos).
*/

% Com lista temporária, de mais fácil interpretação.
eliminaRepetidos(ListaRecursos, ListaRecursosSemRepetidos):-eliminaRepetidos(ListaRecursos, [], ListaRecursosSemRepetidos).

eliminaRepetidos([], ListaTemporaria, ListaTemporaria):-!.
eliminaRepetidos([Recurso|ListaRecursos], ListaTemporaria, ListaRecursosSemRepetidos):-
	not(member(Recurso, ListaTemporaria)), !, eliminaRepetidos(ListaRecursos, [Recurso|ListaTemporaria], ListaRecursosSemRepetidos).
eliminaRepetidos([_|ListaRecursos], ListaTemporaria, ListaRecursosSemRepetidos):-eliminaRepetidos(ListaRecursos, ListaTemporaria, ListaRecursosSemRepetidos).

% 3

documentos(ContraInd, ListaDocumentos):-
	recursos(documento, Documentos),
	findall(Doc, (member(Doc, Documentos), ligacaoRecursos(Doc, ContraInd, _, _)), ListaDoc),
	eliminaRepetidos(ListaDoc, ListaDocumentosInv),
	reverse(ListaDocumentosInv, ListaDocumentos).











