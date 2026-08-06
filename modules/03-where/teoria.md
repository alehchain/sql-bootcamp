# Teoria — WHERE

## O que é WHERE?

A cláusula `WHERE` restringe as linhas retornadas. O Oracle avalia a condição para cada linha e retorna apenas aquelas cujo resultado é verdadeiro.

```sql
SELECT cliente_id, nome, status
FROM clientes
WHERE status = 'ATIVO';
```

## Sintaxe

```sql
SELECT coluna1, coluna2
FROM tabela
WHERE condicao;
```

## Operadores de comparação

| Operador | Significado |
|---|---|
| `=` | igual |
| `<>` ou `!=` | diferente |
| `>` | maior que |
| `<` | menor que |
| `>=` | maior ou igual |
| `<=` | menor ou igual |

## Operadores lógicos

### AND

Todas as condições precisam ser verdadeiras.

```sql
SELECT produto_id, nome, preco
FROM produtos
WHERE ativo = 'S'
  AND preco >= 500;
```

### OR

Pelo menos uma condição precisa ser verdadeira.

```sql
SELECT pedido_id, status
FROM pedidos
WHERE status = 'ABERTO'
   OR status = 'ENVIADO';
```

### NOT

Inverte a condição.

```sql
SELECT pedido_id, status
FROM pedidos
WHERE NOT status = 'CANCELADO';
```

## Precedência

`AND` é avaliado antes de `OR`. Para regras mistas, use parênteses:

```sql
WHERE (categoria_id = 1 OR categoria_id = 2)
  AND ativo = 'S'
```

## Datas

Prefira literal ANSI:

```sql
WHERE data_pedido >= DATE '2025-06-01'
```

Isso evita dependência do formato regional da sessão.

## Expressões

```sql
SELECT nome, preco, custo, preco - custo AS margem
FROM produtos
WHERE preco - custo >= 100;
```

## NULL

Não use `= NULL`. O correto é `IS NULL`, assunto aprofundado no módulo 09.

## Ordem lógica simplificada

```text
FROM → WHERE → SELECT → ORDER BY
```

## Compatibilidade

A sintaxe básica funciona em Oracle, PostgreSQL, SQL Server e MySQL. Atenção especial a datas, conversões implícitas e regras textuais.
