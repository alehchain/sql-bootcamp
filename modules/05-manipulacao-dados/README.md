# 05 — Manipulação de Dados

Este módulo reúne `INSERT`, `UPDATE`, `DELETE` e `MERGE`. O foco é aprender DML; gerenciamento de transações (`COMMIT`, `ROLLBACK` e `SAVEPOINT`) não faz parte deste bootcamp simplificado.

> Execute os exemplos em um ambiente de estudo. Os comandos alteram dados.

## 1. INSERT

Informe as colunas explicitamente:

```sql
INSERT INTO categorias (
    categoria_id,
    nome,
    descricao,
    ativo
) VALUES (
    100,
    'Cursos',
    'Materiais educacionais',
    'S'
);
```

Inserção baseada em consulta:

```sql
INSERT INTO categorias_inativas (categoria_id, nome)
SELECT categoria_id, nome
FROM categorias
WHERE ativo = 'N';
```

## 2. UPDATE

```sql
UPDATE produtos
SET preco = preco * 1.05
WHERE categoria_id = 1;
```

Sempre confira primeiro o filtro:

```sql
SELECT *
FROM produtos
WHERE categoria_id = 1;
```

Uma atualização sem `WHERE` afeta todas as linhas.

## 3. DELETE

```sql
DELETE FROM categorias
WHERE categoria_id = 100;
```

A exclusão pode falhar se uma constraint de chave estrangeira impedir a remoção de um registro referenciado.

## 4. MERGE

`MERGE` permite atualizar quando existe e inserir quando não existe.

```sql
MERGE INTO estoque e
USING (
    SELECT 10 AS produto_id, 25 AS quantidade
    FROM dual
) origem
ON (origem.produto_id = e.produto_id)
WHEN MATCHED THEN
    UPDATE SET e.quantidade = origem.quantidade
WHEN NOT MATCHED THEN
    INSERT (produto_id, quantidade)
    VALUES (origem.produto_id, origem.quantidade);
```

É comum em integrações, sincronizações e cargas.

## 5. DML com subqueries

```sql
UPDATE produtos
SET ativo = 'N'
WHERE produto_id NOT IN (
    SELECT produto_id
    FROM itens_pedido
);
```

Quando houver possibilidade de `NULL`, `NOT EXISTS` costuma ser mais seguro que `NOT IN`.

```sql
UPDATE produtos p
SET ativo = 'N'
WHERE NOT EXISTS (
    SELECT 1
    FROM itens_pedido i
    WHERE i.produto_id = p.produto_id
);
```

## Boas práticas e erros comuns

- Faça um `SELECT` com o mesmo `WHERE` antes de `UPDATE` ou `DELETE`.
- Liste colunas no `INSERT`.
- Respeite PKs, FKs, `NOT NULL`, `UNIQUE` e `CHECK`.
- Não use DML destrutivo em produção sem processo de validação da equipe.
- Prefira `MERGE` quando a regra for claramente “atualizar ou inserir”.

## Exercícios

1. Insira uma nova categoria.
2. Aumente em 10% o preço dos produtos de uma categoria.
3. Marque como inativos produtos que nunca foram vendidos.
4. Exclua a categoria criada no exercício 1, desde que não tenha produtos.
5. Faça `MERGE` no estoque para um produto existente.
6. Escreva um `INSERT ... SELECT` que copie produtos inativos para uma tabela de histórico hipotética.

<details>
<summary>Ver soluções</summary>

```sql
-- 1
INSERT INTO categorias (categoria_id, nome, descricao, ativo)
VALUES (900, 'Temporaria', 'Categoria de exercicio', 'S');

-- 2
UPDATE produtos
SET preco = preco * 1.10
WHERE categoria_id = 1;

-- 3
UPDATE produtos p
SET ativo = 'N'
WHERE NOT EXISTS (
    SELECT 1
    FROM itens_pedido i
    WHERE i.produto_id = p.produto_id
);

-- 4
DELETE FROM categorias c
WHERE c.categoria_id = 900
  AND NOT EXISTS (
      SELECT 1
      FROM produtos p
      WHERE p.categoria_id = c.categoria_id
  );

-- 5
MERGE INTO estoque e
USING (
    SELECT 1 AS produto_id, 50 AS quantidade
    FROM dual
) o
ON (o.produto_id = e.produto_id)
WHEN MATCHED THEN
    UPDATE SET e.quantidade = o.quantidade
WHEN NOT MATCHED THEN
    INSERT (produto_id, quantidade)
    VALUES (o.produto_id, o.quantidade);

-- 6
INSERT INTO produtos_historico (produto_id, nome, preco)
SELECT produto_id, nome, preco
FROM produtos
WHERE ativo = 'N';
```

> O exercício 6 pressupõe uma tabela `produtos_historico` criada pelo aluno.

</details>

## Próximo módulo

Siga para [06 — Estrutura do Banco e PL/SQL](../06-estrutura-banco-plsql).
