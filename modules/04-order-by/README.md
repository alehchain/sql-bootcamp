# Módulo 04 — ORDER BY

> **Nível:** Iniciante  
> **Tempo estimado:** 2 horas

## Objetivo

Ordenar resultados por uma ou várias colunas, em ordem crescente ou decrescente, incluindo controle de valores nulos.

## Conteúdo

- `ASC` e `DESC`.
- Múltiplas colunas.
- Alias e posição.
- `NULLS FIRST` e `NULLS LAST`.
- Ordenação determinística.

## Exemplo

```sql
SELECT produto_id, nome, preco
FROM produtos
ORDER BY preco DESC;
```

## Checklist

- [ ] Ordenar crescente e decrescente.
- [ ] Usar múltiplas colunas.
- [ ] Ordenar por alias.
- [ ] Controlar valores nulos.
- [ ] Explicar por que não há ordem garantida sem `ORDER BY`.

## Próximo módulo

➡️ [Módulo 05 — DISTINCT](../05-distinct)
