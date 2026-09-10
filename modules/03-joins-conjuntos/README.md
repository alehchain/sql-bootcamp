# 03 — Joins e Operações de Conjunto

Este módulo concentra `INNER`, `LEFT`, `RIGHT`, `FULL` e `SELF JOIN`, além de `UNION`, `UNION ALL`, `INTERSECT` e `MINUS`.

## 1. INNER JOIN

Retorna apenas registros que possuem correspondência.

```sql
SELECT
    p.pedido_id,
    c.nome AS cliente,
    p.valor_total
FROM pedidos p
INNER JOIN clientes c
    ON c.cliente_id = p.cliente_id;
```

## 2. LEFT, RIGHT e FULL JOIN

`LEFT JOIN` preserva todas as linhas da tabela da esquerda:

```sql
SELECT
    c.nome,
    p.pedido_id
FROM clientes c
LEFT JOIN pedidos p
    ON p.cliente_id = c.cliente_id;
```

Isso é útil, por exemplo, para encontrar clientes sem pedidos:

```sql
SELECT c.cliente_id, c.nome
FROM clientes c
LEFT JOIN pedidos p
    ON p.cliente_id = c.cliente_id
WHERE p.pedido_id IS NULL;
```

`RIGHT JOIN` faz o equivalente preservando a tabela da direita. Na prática, muitas equipes preferem reorganizar a consulta e usar `LEFT JOIN` para manter um padrão.

`FULL JOIN` preserva ambos os lados, mesmo sem correspondência.

## 3. SELF JOIN

Uma tabela pode ser associada a ela mesma quando existe uma relação hierárquica, como funcionário e gestor:

```sql
SELECT
    f.nome AS funcionario,
    g.nome AS gestor
FROM funcionarios f
LEFT JOIN funcionarios g
    ON g.funcionario_id = f.gestor_id;
```

## 4. Múltiplos joins

```sql
SELECT
    p.pedido_id,
    c.nome AS cliente,
    pr.nome AS produto,
    i.quantidade,
    i.preco_unitario
FROM pedidos p
JOIN clientes c
    ON c.cliente_id = p.cliente_id
JOIN itens_pedido i
    ON i.pedido_id = p.pedido_id
JOIN produtos pr
    ON pr.produto_id = i.produto_id;
```

Sempre confira a cardinalidade para evitar multiplicação inesperada de linhas.

## 5. Operações de conjunto

As consultas combinadas precisam devolver a mesma quantidade de colunas e tipos compatíveis.

### UNION

Une resultados e remove duplicidades.

```sql
SELECT email FROM clientes
UNION
SELECT email FROM fornecedores;
```

### UNION ALL

Mantém duplicidades e costuma ser preferível quando a remoção delas não é necessária.

```sql
SELECT email FROM clientes
UNION ALL
SELECT email FROM fornecedores;
```

### INTERSECT

Retorna valores presentes nos dois resultados.

```sql
SELECT produto_id FROM itens_pedido
INTERSECT
SELECT produto_id FROM estoque;
```

### MINUS

Retorna linhas do primeiro resultado ausentes no segundo.

```sql
SELECT produto_id FROM produtos
MINUS
SELECT produto_id FROM itens_pedido;
```

## Boas práticas e erros comuns

- Use aliases curtos e significativos.
- Qualifique colunas ambíguas (`c.nome`, `p.status`).
- Não coloque no `WHERE` um filtro da tabela opcional se isso transformar sem intenção um `LEFT JOIN` em comportamento de `INNER JOIN`.
- Prefira `UNION ALL` quando duplicidades são válidas.
- Antes de juntar muitas tabelas, valide cada relacionamento individualmente.

## Exercícios

1. Liste pedidos com nome do cliente.
2. Liste todos os clientes e seus pedidos, incluindo clientes sem pedido.
3. Encontre clientes sem pedido.
4. Liste cada item de pedido com cliente, produto, quantidade e subtotal.
5. Liste IDs de produtos que nunca foram vendidos usando `MINUS`.
6. Una os e-mails de clientes e fornecedores sem repetir valores.
7. Mostre total comprado por cliente, incluindo clientes sem compras.

<details>
<summary>Ver soluções</summary>

```sql
-- 1
SELECT p.pedido_id, c.nome, p.valor_total
FROM pedidos p
JOIN clientes c ON c.cliente_id = p.cliente_id;

-- 2
SELECT c.cliente_id, c.nome, p.pedido_id
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.cliente_id
ORDER BY c.nome, p.pedido_id;

-- 3
SELECT c.cliente_id, c.nome
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.cliente_id
WHERE p.pedido_id IS NULL;

-- 4
SELECT p.pedido_id,
       c.nome AS cliente,
       pr.nome AS produto,
       i.quantidade,
       i.quantidade * i.preco_unitario AS subtotal
FROM pedidos p
JOIN clientes c ON c.cliente_id = p.cliente_id
JOIN itens_pedido i ON i.pedido_id = p.pedido_id
JOIN produtos pr ON pr.produto_id = i.produto_id;

-- 5
SELECT produto_id FROM produtos
MINUS
SELECT produto_id FROM itens_pedido;

-- 6
SELECT email FROM clientes
UNION
SELECT email FROM fornecedores;

-- 7
SELECT c.cliente_id,
       c.nome,
       NVL(SUM(p.valor_total), 0) AS total_compras
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.cliente_id
GROUP BY c.cliente_id, c.nome
ORDER BY total_compras DESC;
```

</details>

## Próximo módulo

Siga para [04 — Consultas Avançadas](../04-consultas-avancadas).
