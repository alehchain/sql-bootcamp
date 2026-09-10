# 07 — Projeto Final: Loja Virtual

O projeto final integra os seis módulos anteriores. A ideia é construir consultas e objetos úteis sobre o banco de dados já preparado em [`database/setup.sql`](../../database/setup.sql).

## Cenário

A equipe da Loja Virtual precisa de um pequeno conjunto de relatórios e rotinas SQL para acompanhar clientes, vendas, produtos e estoque.

Você deverá entregar um único arquivo chamado `projeto-final.sql`.

## Parte 1 — Consultas operacionais

Crie consultas para:

1. Listar clientes cadastrados nos últimos 90 dias.
2. Listar produtos ativos entre duas faixas de preço.
3. Exibir pedidos com nome do cliente, data, status e valor.
4. Encontrar clientes sem pedidos.
5. Encontrar produtos que nunca foram vendidos.

## Parte 2 — Indicadores

Crie consultas para:

1. Quantidade e valor total de pedidos por status.
2. Total comprado por cliente.
3. Ticket médio por cliente.
4. Faturamento mensal.
5. Top 5 produtos por quantidade vendida.

## Parte 3 — SQL avançado

Crie:

1. Uma CTE com resumo de vendas por cliente.
2. Um ranking de clientes por valor comprado.
3. Um ranking de produtos dentro de cada categoria.
4. Uma consulta que mostre cada pedido e o valor do pedido anterior do mesmo cliente.

## Parte 4 — Estrutura e PL/SQL

Crie:

1. Uma view `vw_resumo_vendas` com pedido, cliente, data, status e valor.
2. Uma function `fn_total_cliente` que retorne o total de compras.
3. Uma procedure `pr_desativar_produtos_sem_venda` que marque produtos nunca vendidos como inativos.
4. Opcionalmente, organize function e procedure em um package.

## Requisitos

- Use aliases legíveis.
- Evite `SELECT *`.
- Formate o SQL de modo consistente.
- Use `JOIN` explícito.
- Em consultas analíticas, defina `ORDER BY` coerente.
- Antes de qualquer `UPDATE` ou `DELETE`, escreva a consulta equivalente para validar as linhas afetadas.
- Não é necessário incluir transações, planos de execução, tuning ou administração Oracle.

## Solução de referência

Tente concluir antes de abrir esta seção.

<details>
<summary>Ver uma solução possível</summary>

```sql
/* =========================================================
   PARTE 1 — CONSULTAS OPERACIONAIS
   ========================================================= */

-- 1. Clientes cadastrados nos últimos 90 dias
SELECT cliente_id, nome, email, data_cadastro
FROM clientes
WHERE data_cadastro >= SYSDATE - 90
ORDER BY data_cadastro DESC;

-- 2. Produtos ativos em uma faixa de preço
SELECT produto_id, nome, preco
FROM produtos
WHERE ativo = 'S'
  AND preco BETWEEN 50 AND 500
ORDER BY preco;

-- 3. Pedidos com cliente
SELECT p.pedido_id,
       c.nome AS cliente,
       p.data_pedido,
       p.status,
       p.valor_total
FROM pedidos p
JOIN clientes c
  ON c.cliente_id = p.cliente_id
ORDER BY p.data_pedido DESC;

-- 4. Clientes sem pedidos
SELECT c.cliente_id, c.nome
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.cliente_id
);

-- 5. Produtos nunca vendidos
SELECT p.produto_id, p.nome
FROM produtos p
WHERE NOT EXISTS (
    SELECT 1
    FROM itens_pedido i
    WHERE i.produto_id = p.produto_id
);

/* =========================================================
   PARTE 2 — INDICADORES
   ========================================================= */

-- 1. Pedidos por status
SELECT status,
       COUNT(*) AS quantidade,
       SUM(valor_total) AS total
FROM pedidos
GROUP BY status
ORDER BY total DESC;

-- 2 e 3. Total e ticket médio por cliente
SELECT c.cliente_id,
       c.nome,
       COUNT(p.pedido_id) AS qtd_pedidos,
       NVL(SUM(p.valor_total), 0) AS total_compras,
       NVL(ROUND(AVG(p.valor_total), 2), 0) AS ticket_medio
FROM clientes c
LEFT JOIN pedidos p
  ON p.cliente_id = c.cliente_id
GROUP BY c.cliente_id, c.nome
ORDER BY total_compras DESC;

-- 4. Faturamento mensal
SELECT TO_CHAR(data_pedido, 'YYYY-MM') AS mes,
       SUM(valor_total) AS faturamento
FROM pedidos
GROUP BY TO_CHAR(data_pedido, 'YYYY-MM')
ORDER BY mes;

-- 5. Top 5 produtos
SELECT *
FROM (
    SELECT pr.produto_id,
           pr.nome,
           SUM(i.quantidade) AS quantidade_vendida
    FROM produtos pr
    JOIN itens_pedido i
      ON i.produto_id = pr.produto_id
    GROUP BY pr.produto_id, pr.nome
    ORDER BY quantidade_vendida DESC
)
WHERE ROWNUM <= 5;

/* =========================================================
   PARTE 3 — SQL AVANÇADO
   ========================================================= */

-- 1. CTE de vendas por cliente
WITH vendas_cliente AS (
    SELECT cliente_id,
           COUNT(*) AS qtd_pedidos,
           SUM(valor_total) AS total
    FROM pedidos
    GROUP BY cliente_id
)
SELECT c.nome, v.qtd_pedidos, v.total
FROM vendas_cliente v
JOIN clientes c
  ON c.cliente_id = v.cliente_id
ORDER BY v.total DESC;

-- 2. Ranking de clientes
SELECT c.cliente_id,
       c.nome,
       SUM(p.valor_total) AS total,
       DENSE_RANK() OVER (
           ORDER BY SUM(p.valor_total) DESC
       ) AS ranking
FROM clientes c
JOIN pedidos p
  ON p.cliente_id = c.cliente_id
GROUP BY c.cliente_id, c.nome;

-- 3. Ranking de produtos por categoria
SELECT produto_id,
       categoria_id,
       nome,
       preco,
       DENSE_RANK() OVER (
           PARTITION BY categoria_id
           ORDER BY preco DESC
       ) AS ranking_categoria
FROM produtos;

-- 4. Pedido anterior do cliente
SELECT pedido_id,
       cliente_id,
       data_pedido,
       valor_total,
       LAG(valor_total) OVER (
           PARTITION BY cliente_id
           ORDER BY data_pedido, pedido_id
       ) AS valor_anterior
FROM pedidos;

/* =========================================================
   PARTE 4 — ESTRUTURA E PL/SQL
   ========================================================= */

CREATE OR REPLACE VIEW vw_resumo_vendas AS
SELECT p.pedido_id,
       c.cliente_id,
       c.nome AS cliente,
       p.data_pedido,
       p.status,
       p.valor_total
FROM pedidos p
JOIN clientes c
  ON c.cliente_id = p.cliente_id;

CREATE OR REPLACE FUNCTION fn_total_cliente (
    p_cliente_id NUMBER
) RETURN NUMBER AS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(valor_total), 0)
    INTO v_total
    FROM pedidos
    WHERE cliente_id = p_cliente_id;

    RETURN v_total;
END;
/

CREATE OR REPLACE PROCEDURE pr_desativar_produtos_sem_venda AS
BEGIN
    UPDATE produtos p
    SET ativo = 'N'
    WHERE NOT EXISTS (
        SELECT 1
        FROM itens_pedido i
        WHERE i.produto_id = p.produto_id
    );
END;
/
```

</details>

## Checklist de conclusão

- [ ] Fundamentos e filtros.
- [ ] Funções e agregações.
- [ ] Joins e conjuntos.
- [ ] Subqueries, CTE e window functions.
- [ ] DML.
- [ ] DDL, objetos Oracle e PL/SQL.
- [ ] Projeto final concluído.

Ao finalizar, você terá passado pelos principais recursos de SQL usados por analistas e desenvolvedores, sem transformar o bootcamp em um curso de DBA.
