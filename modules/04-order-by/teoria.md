# Teoria — ORDER BY

Sem `ORDER BY`, o banco não garante a ordem das linhas.

## Sintaxe

```sql
SELECT coluna1, coluna2
FROM tabela
ORDER BY coluna1 ASC;
```

`ASC` é padrão. Para ordem decrescente, use `DESC`.

## Múltiplas colunas

```sql
SELECT status, valor_total
FROM pedidos
ORDER BY status ASC, valor_total DESC;
```

A segunda coluna desempata a primeira.

## Alias

```sql
SELECT nome, preco - custo AS margem
FROM produtos
ORDER BY margem DESC;
```

## Posição

`ORDER BY 2` funciona, mas é menos legível e mais frágil que usar o nome.

## Valores nulos

```sql
ORDER BY telefone ASC NULLS LAST
```

## Determinismo

Para paginação, use desempate:

```sql
ORDER BY data_pedido DESC, pedido_id DESC
```

## Compatibilidade

`ASC` e `DESC` são universais. `NULLS FIRST/LAST` é direto no Oracle e PostgreSQL; outros bancos podem exigir alternativas.
