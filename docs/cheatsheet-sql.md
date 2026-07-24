# Cheatsheet SQL

```sql
-- Seleção
SELECT coluna1, coluna2
FROM tabela
WHERE condicao
ORDER BY coluna1;

-- Agrupamento
SELECT categoria, COUNT(*) quantidade, SUM(valor) total
FROM tabela
GROUP BY categoria
HAVING SUM(valor) > 1000;

-- Join
SELECT a.id, b.descricao
FROM tabela_a a
JOIN tabela_b b ON b.id = a.tabela_b_id;

-- CTE
WITH dados AS (
    SELECT * FROM tabela
)
SELECT * FROM dados;

-- Window function
SELECT
    nome,
    valor,
    ROW_NUMBER() OVER (ORDER BY valor DESC) posicao
FROM tabela;
```
