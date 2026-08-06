# Quiz — DISTINCT

1. `DISTINCT` remove dados da tabela?
2. Sobre quais colunas avalia duplicidade?
3. Garante ordenação?
4. Como listar status únicos?
5. Como trata nulos repetidos?
6. Tem o mesmo propósito de `GROUP BY`?
7. Por que pode ser custoso?
8. Qual risco após join incorreto?
9. Como obter combinações únicas?
10. Qual cláusula ordena o resultado?

## Gabarito

1. Não. 2. Toda a combinação selecionada. 3. Não. 4. `SELECT DISTINCT status`. 5. Uma ocorrência por combinação. 6. Não. 7. Sort/hash/memória. 8. Esconder erro lógico. 9. Selecionar todas após `DISTINCT`. 10. `ORDER BY`.
