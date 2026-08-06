# Teoria — LIKE

`LIKE` compara textos com padrões.

```sql
SELECT cliente_id, nome
FROM clientes
WHERE nome LIKE 'A%';
```

## Curingas

| Curinga | Significado | Exemplo |
|---|---|---|
| `%` | zero ou mais caracteres | `'A%'` |
| `_` | exatamente um caractere | `'A___'` |

## Padrões comuns

```sql
-- Começa com Oracle
WHERE nome LIKE 'Oracle%'

-- Termina com 001
WHERE sku LIKE '%001'

-- Contém SQL
WHERE nome LIKE '%SQL%'
```

## NOT LIKE

```sql
WHERE nome NOT LIKE 'A%'
```

## Maiúsculas e minúsculas

No Oracle, a comparação normalmente respeita a capitalização:

```sql
WHERE UPPER(nome) LIKE 'ANA%'
```

## ESCAPE

Use `ESCAPE` para pesquisar `%` ou `_` literalmente:

```sql
WHERE texto LIKE '%10\%%' ESCAPE '\'
```

## Performance

`LIKE 'Oracle%'` pode aproveitar melhor um índice do que `LIKE '%Oracle%'`.
Para igualdade exata, prefira `=`.
