# Teoria — DISTINCT

`DISTINCT` elimina linhas duplicadas do resultado, sem alterar a tabela.

## Uma coluna

```sql
SELECT DISTINCT status
FROM pedidos;
```

## Várias colunas

```sql
SELECT DISTINCT status, forma_pagamento
FROM pagamentos;
```

A combinação inteira define a duplicidade.

## Expressões

```sql
SELECT DISTINCT preco - custo AS margem
FROM produtos;
```

## NULL

Múltiplos valores nulos na mesma combinação aparecem uma única vez no resultado distinto.

## ORDER BY

`DISTINCT` não ordena. Use `ORDER BY` explicitamente.

## DISTINCT versus GROUP BY

Podem produzir o mesmo conjunto simples, mas a intenção é diferente: `DISTINCT` elimina repetição; `GROUP BY` forma grupos para agregação.

## Cuidado em joins

Adicionar `DISTINCT` pode esconder uma condição de relacionamento incorreta. Primeiro revise cardinalidade e chaves.

## Performance

A eliminação de duplicidade pode exigir sort, hash, memória e espaço temporário.
