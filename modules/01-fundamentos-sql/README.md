# 01 — Fundamentos de SQL

Este módulo reúne os fundamentos que antes estavam distribuídos entre Introdução, `SELECT`, `WHERE`, `ORDER BY`, `DISTINCT`, `LIKE`, `IN`, `BETWEEN` e `IS NULL`.

## Objetivos

Ao concluir, você será capaz de consultar tabelas, escolher colunas, criar aliases, eliminar duplicidades, filtrar registros e ordenar resultados.

## 1. SQL e o modelo relacional

SQL é a linguagem usada para consultar e manipular dados em bancos relacionais. Neste bootcamp usamos Oracle e o banco fictício **Loja Virtual**.

Uma consulta básica segue esta ordem:

```sql
SELECT colunas
FROM tabela
WHERE condicao
ORDER BY coluna;
```

## 2. SELECT, aliases e expressões

```sql
SELECT cliente_id, nome, email
FROM clientes;
```

Use alias para melhorar a leitura:

```sql
SELECT
    nome AS cliente,
    data_cadastro AS cadastrado_em
FROM clientes;
```

Também é possível calcular valores:

```sql
SELECT
    nome,
    preco,
    preco * 1.10 AS preco_reajustado
FROM produtos;
```

Evite `SELECT *` em consultas de aplicação quando você conhece as colunas necessárias.

## 3. DISTINCT e ORDER BY

`DISTINCT` remove linhas duplicadas do resultado:

```sql
SELECT DISTINCT status
FROM pedidos;
```

Ordenação crescente é padrão; `DESC` inverte:

```sql
SELECT pedido_id, valor_total
FROM pedidos
ORDER BY valor_total DESC;
```

É possível combinar critérios:

```sql
SELECT nome, data_cadastro
FROM clientes
ORDER BY data_cadastro DESC, nome ASC;
```

## 4. WHERE e operadores

Comparações comuns: `=`, `<>`, `>`, `<`, `>=`, `<=`.

```sql
SELECT nome, preco
FROM produtos
WHERE preco >= 100;
```

Combine condições com `AND`, `OR` e `NOT`:

```sql
SELECT nome, preco, ativo
FROM produtos
WHERE ativo = 'S'
  AND preco BETWEEN 50 AND 300;
```

Use parênteses quando houver `AND` e `OR` na mesma condição.

## 5. LIKE, IN, BETWEEN e NULL

### LIKE

`%` representa qualquer quantidade de caracteres e `_` representa um caractere.

```sql
SELECT nome
FROM clientes
WHERE UPPER(nome) LIKE 'MAR%';
```

### IN

```sql
SELECT pedido_id, status
FROM pedidos
WHERE status IN ('NOVO', 'PAGO', 'ENVIADO');
```

### BETWEEN

Os limites são inclusivos:

```sql
SELECT nome, preco
FROM produtos
WHERE preco BETWEEN 100 AND 500;
```

### IS NULL

Nunca compare `NULL` com `=`.

```sql
SELECT pedido_id
FROM pedidos
WHERE transportadora_id IS NULL;
```

Para o contrário:

```sql
WHERE transportadora_id IS NOT NULL
```

## Boas práticas e erros comuns

- Prefira colunas explícitas a `SELECT *`.
- Use nomes claros para aliases.
- Não use `= NULL`; use `IS NULL`.
- Cuidado com precedência entre `AND` e `OR`.
- `BETWEEN` inclui os dois extremos.
- Em textos, considere `UPPER`/`LOWER` quando a comparação precisar ignorar caixa.

## Exercícios

1. Liste `cliente_id`, `nome` e `email` de todos os clientes em ordem alfabética.
2. Liste os produtos ativos com preço entre 50 e 200.
3. Mostre os diferentes status existentes em `pedidos`.
4. Liste clientes cujo nome começa com `A`.
5. Liste pedidos com status `PAGO` ou `ENVIADO`, do maior para o menor `valor_total`.
6. Liste pedidos sem transportadora.
7. Mostre nome, preço e um preço com acréscimo de 15% para os produtos acima de 100.

<details>
<summary>Ver soluções</summary>

```sql
-- 1
SELECT cliente_id, nome, email
FROM clientes
ORDER BY nome;

-- 2
SELECT produto_id, nome, preco
FROM produtos
WHERE ativo = 'S'
  AND preco BETWEEN 50 AND 200
ORDER BY preco;

-- 3
SELECT DISTINCT status
FROM pedidos
ORDER BY status;

-- 4
SELECT cliente_id, nome
FROM clientes
WHERE UPPER(nome) LIKE 'A%';

-- 5
SELECT pedido_id, status, valor_total
FROM pedidos
WHERE status IN ('PAGO', 'ENVIADO')
ORDER BY valor_total DESC;

-- 6
SELECT pedido_id, cliente_id
FROM pedidos
WHERE transportadora_id IS NULL;

-- 7
SELECT nome, preco, preco * 1.15 AS preco_com_acrescimo
FROM produtos
WHERE preco > 100;
```

</details>

## Próximo módulo

Siga para [02 — Funções e Agregações](../02-funcoes-agregacoes).
