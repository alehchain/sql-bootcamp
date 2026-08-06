# Boas práticas — ORDER BY

- Nunca dependa da ordem física da tabela.
- Use desempate determinístico.
- Prefira nomes de colunas a posições numéricas.
- Ordene somente quando necessário.
- Declare explicitamente `NULLS FIRST/LAST` quando fizer parte da regra.
- Em grandes volumes, avalie o custo da ordenação.
