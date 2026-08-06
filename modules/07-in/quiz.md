# Quiz — IN

1. Para que serve `IN`?
2. A que `status IN ('A','B')` equivale?
3. Qual risco existe em `NOT IN`?
4. Pode haver subquery em `IN`?
5. Quantas colunas ela deve retornar neste uso?
6. Como proteger `NOT IN` contra `NULL`?
7. Qual alternativa é comum para verificar existência?
8. Quando evitar listas literais muito grandes?

## Gabarito

1. Verificar pertencimento.
2. Dois `OR` de igualdade.
3. `NULL`.
4. Sim.
5. Uma.
6. Filtrando `IS NOT NULL`.
7. `EXISTS`/`NOT EXISTS`.
8. Quando forem grandes ou dinâmicas.
