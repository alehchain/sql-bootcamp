# Quiz — ORDER BY

1. Qual é a ordem padrão?
2. Sem `ORDER BY`, a ordem é garantida?
3. Como mostrar maior preço primeiro?
4. Como desempatar valores iguais?
5. É possível ordenar por alias?
6. Por que evitar posição numérica?
7. Para que servem `NULLS FIRST/LAST`?
8. Por que paginação exige ordem determinística?
9. Como ordenar status e nome?
10. Qual palavra indica ordem decrescente?

## Gabarito

1. `ASC`. 2. Não. 3. `ORDER BY preco DESC`. 4. Adicionar outra coluna. 5. Sim. 6. Fragilidade e baixa legibilidade. 7. Controlar nulos. 8. Evitar repetição ou salto. 9. `ORDER BY status, nome`. 10. `DESC`.
