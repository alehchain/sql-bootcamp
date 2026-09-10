# 02 — Funções e Agregações

Aqui ficam reunidas funções de texto, numéricas e de data, `CASE`, funções de agregação, `GROUP BY` e `HAVING`.

## 1. Funções de texto

Algumas funções Oracle muito usadas:

```sql
SELECT
    UPPER(nome) AS nome_maiusculo,
    LOWER(email) AS email_minusculo,
    LENGTH(nome) AS tamanho_nome,
    SUBSTR(nome, 1, 10) AS nome_reduzido,
    TRIM(nome) AS nome_sem_espacos
FROM clientes;
```

Concatenação:

```sql
SELECT nome || ' - ' || email AS cliente
FROM clientes;
```

## 2. Funções numéricas

```sql
SELECT
    preco,
    ROUND(preco, 2) AS arredondado,
    TRUNC(preco, 0) AS sem_decimais,
    ABS(preco - custo) AS diferenca
FROM produtos;
```

## 3. Datas

No Oracle, `SYSDATE` devolve data e hora do servidor.

```sql
SELECT
    nome,
    data_cadastro,
    SYSDATE - data_cadastro AS dias_cadastrado,
    ADD_MONTHS(data_cadastro, 1) AS mais_um_mes
FROM clientes;
```

Formatação:

```sql
SELECT TO_CHAR(data_pedido, 'DD/MM/YYYY') AS data_formatada
FROM pedidos;
```

Conversão segura de texto conhecido:

```sql
SELECT TO_DATE('10/09/2026', 'DD/MM/YYYY')
FROM dual;
```

## 4. CASE

`CASE` cria regras condicionais no resultado.

```sql
SELECT
    nome,
    preco,
    CASE
        WHEN preco < 100 THEN 'BAIXO'
        WHEN preco < 500 THEN 'MEDIO'
        ELSE 'ALTO'
    END AS faixa_preco
FROM produtos;
```

## 5. Agregações

Funções mais comuns: `COUNT`, `SUM`, `AVG`, `MIN` e `MAX`.

```sql
SELECT
    COUNT(*) AS quantidade,
    SUM(valor_total) AS total,
    AVG(valor_total) AS media,
    MIN(valor_total) AS menor,
    MAX(valor_total) AS maior
FROM pedidos;
```

`COUNT(*)` conta linhas. `COUNT(coluna)` ignora valores `NULL`.

## 6. GROUP BY e HAVING

Agrupe quando quiser uma métrica por categoria:

```sql
SELECT
    status,
    COUNT(*) AS quantidade,
    SUM(valor_total) AS total
FROM pedidos
GROUP BY status
ORDER BY total DESC;
```

`WHERE` filtra linhas **antes** do agrupamento. `HAVING` filtra grupos **depois**:

```sql
SELECT
    cliente_id,
    COUNT(*) AS qtd_pedidos,
    SUM(valor_total) AS total_compras
FROM pedidos
WHERE valor_total > 0
GROUP BY cliente_id
HAVING COUNT(*) >= 2;
```

## Boas práticas e erros comuns

- Toda coluna do `SELECT` que não estiver em uma função de agregação deve aparecer no `GROUP BY`.
- Use `WHERE` para reduzir as linhas antes de agrupar.
- Use `HAVING` para condições sobre `COUNT`, `SUM`, `AVG` etc.
- Não formate datas apenas para depois compará-las; compare valores `DATE` quando possível.
- Use máscara explícita em `TO_DATE`.

## Exercícios

1. Mostre nome dos clientes em maiúsculas e quantidade de caracteres.
2. Classifique produtos como `BAIXO`, `MEDIO` ou `ALTO` usando os limites do exemplo.
3. Calcule quantidade, total e ticket médio dos pedidos.
4. Mostre quantidade de pedidos por status.
5. Mostre clientes com pelo menos 2 pedidos.
6. Mostre o total vendido por mês no formato `YYYY-MM`.
7. Mostre categorias com preço médio de produto acima de 100.

<details>
<summary>Ver soluções</summary>

```sql
-- 1
SELECT UPPER(nome) AS nome, LENGTH(nome) AS caracteres
FROM clientes;

-- 2
SELECT nome,
       CASE
           WHEN preco < 100 THEN 'BAIXO'
           WHEN preco < 500 THEN 'MEDIO'
           ELSE 'ALTO'
       END AS faixa
FROM produtos;

-- 3
SELECT COUNT(*) AS quantidade,
       SUM(valor_total) AS total,
       ROUND(AVG(valor_total), 2) AS ticket_medio
FROM pedidos;

-- 4
SELECT status, COUNT(*) AS quantidade
FROM pedidos
GROUP BY status
ORDER BY quantidade DESC;

-- 5
SELECT cliente_id, COUNT(*) AS qtd_pedidos
FROM pedidos
GROUP BY cliente_id
HAVING COUNT(*) >= 2;

-- 6
SELECT TO_CHAR(data_pedido, 'YYYY-MM') AS mes,
       SUM(valor_total) AS total
FROM pedidos
GROUP BY TO_CHAR(data_pedido, 'YYYY-MM')
ORDER BY mes;

-- 7
SELECT categoria_id, ROUND(AVG(preco), 2) AS preco_medio
FROM produtos
GROUP BY categoria_id
HAVING AVG(preco) > 100;
```

</details>

## Próximo módulo

Siga para [03 — Joins e Operações de Conjunto](../03-joins-conjuntos).
