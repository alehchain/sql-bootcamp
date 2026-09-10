# 04 — Consultas Avançadas

Este módulo reúne subqueries, `EXISTS`, `ANY`, `ALL`, CTEs e window functions.

## 1. Subqueries

Uma subquery é uma consulta usada dentro de outra.

Produto acima da média:

```sql
SELECT produto_id, nome, preco
FROM produtos
WHERE preco > (
    SELECT AVG(preco)
    FROM produtos
);
```

Subquery correlacionada:

```sql
SELECT c.cliente_id, c.nome
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.cliente_id
);
```

## 2. EXISTS e NOT EXISTS

Use `EXISTS` quando a pergunta for “existe ao menos um registro relacionado?”.

```sql
SELECT c.cliente_id, c.nome
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.cliente_id
);
```

## 3. ANY e ALL

`ANY` compara com pelo menos um valor retornado:

```sql
SELECT nome, preco
FROM produtos
WHERE preco > ANY (
    SELECT preco
    FROM produtos
    WHERE categoria_id = 1
);
```

`ALL` exige que a condição seja verdadeira para todos os valores:

```sql
SELECT nome, preco
FROM produtos
WHERE preco > ALL (
    SELECT preco
    FROM produtos
    WHERE categoria_id = 1
);
```

Embora válidos, em consultas de negócio muitas vezes `MIN`, `MAX` ou `EXISTS` deixam a intenção mais clara.

## 4. CTE — WITH

CTEs ajudam a quebrar uma consulta complexa em partes legíveis.

```sql
WITH vendas_cliente AS (
    SELECT
        cliente_id,
        COUNT(*) AS qtd_pedidos,
        SUM(valor_total) AS total
    FROM pedidos
    GROUP BY cliente_id
)
SELECT
    c.nome,
    v.qtd_pedidos,
    v.total
FROM vendas_cliente v
JOIN clientes c
    ON c.cliente_id = v.cliente_id
ORDER BY v.total DESC;
```

## 5. Window functions

Funções analíticas calculam valores sobre um conjunto sem reduzir as linhas como `GROUP BY`.

### ROW_NUMBER

```sql
SELECT
    pedido_id,
    cliente_id,
    valor_total,
    ROW_NUMBER() OVER (
        PARTITION BY cliente_id
        ORDER BY valor_total DESC
    ) AS posicao
FROM pedidos;
```

### RANK e DENSE_RANK

```sql
SELECT
    produto_id,
    nome,
    preco,
    DENSE_RANK() OVER (ORDER BY preco DESC) AS ranking
FROM produtos;
```

### SUM OVER

```sql
SELECT
    pedido_id,
    data_pedido,
    valor_total,
    SUM(valor_total) OVER (
        ORDER BY data_pedido, pedido_id
    ) AS acumulado
FROM pedidos;
```

### LAG e LEAD

```sql
SELECT
    pedido_id,
    data_pedido,
    valor_total,
    LAG(valor_total) OVER (ORDER BY data_pedido, pedido_id) AS valor_anterior
FROM pedidos;
```

## Boas práticas e erros comuns

- Use `EXISTS` quando só importa a existência.
- Prefira CTEs quando elas tornam a intenção mais clara; não use apenas para “encurtar” a consulta.
- Diferencie `GROUP BY` de funções analíticas: o primeiro reduz linhas; as segundas mantêm detalhes.
- Defina ordenação determinística em rankings quando empates precisarem de desempate.
- Teste subqueries isoladamente antes de encaixá-las em consultas maiores.

## Exercícios

1. Liste produtos com preço acima da média geral.
2. Encontre clientes que nunca fizeram pedido com `NOT EXISTS`.
3. Crie uma CTE com total e quantidade de pedidos por cliente.
4. Faça ranking dos 10 pedidos de maior valor.
5. Numere os pedidos de cada cliente do mais recente para o mais antigo.
6. Calcule total acumulado de pedidos por data.
7. Mostre o pedido atual e o valor do pedido anterior de cada cliente.

<details>
<summary>Ver soluções</summary>

```sql
-- 1
SELECT produto_id, nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- 2
SELECT c.cliente_id, c.nome
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.cliente_id
);

-- 3
WITH resumo AS (
    SELECT cliente_id,
           COUNT(*) AS quantidade,
           SUM(valor_total) AS total
    FROM pedidos
    GROUP BY cliente_id
)
SELECT c.nome, r.quantidade, r.total
FROM resumo r
JOIN clientes c ON c.cliente_id = r.cliente_id
ORDER BY r.total DESC;

-- 4
SELECT *
FROM (
    SELECT p.*,
           DENSE_RANK() OVER (ORDER BY valor_total DESC) AS ranking
    FROM pedidos p
)
WHERE ranking <= 10;

-- 5
SELECT pedido_id,
       cliente_id,
       data_pedido,
       ROW_NUMBER() OVER (
           PARTITION BY cliente_id
           ORDER BY data_pedido DESC, pedido_id DESC
       ) AS numero
FROM pedidos;

-- 6
SELECT pedido_id,
       data_pedido,
       valor_total,
       SUM(valor_total) OVER (
           ORDER BY data_pedido, pedido_id
       ) AS total_acumulado
FROM pedidos;

-- 7
SELECT pedido_id,
       cliente_id,
       valor_total,
       LAG(valor_total) OVER (
           PARTITION BY cliente_id
           ORDER BY data_pedido, pedido_id
       ) AS valor_anterior
FROM pedidos;
```

</details>

## Próximo módulo

Siga para [05 — Manipulação de Dados](../05-manipulacao-dados).
