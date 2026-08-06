# Módulo 05 — DISTINCT

> **Nível:** Iniciante  
> **Tempo estimado:** 2 horas

## Objetivo

Remover linhas duplicadas do resultado e compreender que `DISTINCT` atua sobre a combinação completa das colunas selecionadas.

## Exemplo

```sql
SELECT DISTINCT status
FROM pedidos
ORDER BY status;
```

## Conteúdo

- Uma ou várias colunas.
- Expressões.
- Relação com `NULL` e `ORDER BY`.
- Diferença para `GROUP BY`.
- Impacto de performance.
- Risco de esconder joins incorretos.

## Checklist

- [ ] Listar valores únicos.
- [ ] Explicar múltiplas colunas.
- [ ] Saber que não altera a tabela.
- [ ] Não usar para esconder join incorreto.
- [ ] Ordenar explicitamente.

## Próximo módulo

➡️ [Módulo 06 — LIKE](../06-like)
