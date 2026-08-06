# Boas práticas — WHERE

- Compare valores usando tipos compatíveis.
- Use literal ANSI para datas: `DATE '2025-06-01'`.
- Use parênteses em regras com `AND` e `OR`.
- Escreva uma condição por linha.
- Evite funções desnecessárias sobre colunas filtradas.
- Antes de `UPDATE` ou `DELETE`, valide o mesmo filtro com `SELECT`.
- Não compare `NULL` com `=`.
