# Teoria — IN

`IN` verifica se um valor pertence a uma lista.

```sql
SELECT pedido_id, status
FROM pedidos
WHERE status IN ('ABERTO', 'PAGO', 'ENVIADO');
```

É equivalente a vários `OR` de igualdade.

## Números

```sql
WHERE categoria_id IN (1, 2, 4)
```

## Textos

```sql
WHERE status IN ('ATIVO', 'BLOQUEADO')
```

## Datas

```sql
WHERE data_pedido IN (DATE '2025-05-02', DATE '2025-06-01')
```

## NOT IN

```sql
WHERE status NOT IN ('CANCELADO', 'BLOQUEADO')
```

## Subquery

```sql
SELECT cliente_id, nome
FROM clientes
WHERE cliente_id IN (
    SELECT cliente_id
    FROM pedidos
);
```

## Atenção a NULL

`NOT IN` com uma lista ou subquery que contenha `NULL` pode não retornar o esperado.

```sql
WHERE produto_id NOT IN (
    SELECT produto_id
    FROM itens_pedido
    WHERE produto_id IS NOT NULL
)
```

Em regras de ausência, `NOT EXISTS` costuma ser uma alternativa mais segura.
