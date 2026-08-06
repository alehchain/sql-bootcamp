# Módulo 03 — WHERE

> **Nível:** Iniciante  
> **Tempo estimado:** 3 horas  
> **Ambiente:** Oracle Live SQL

## Objetivo

Aprender a filtrar registros com `WHERE`, operadores de comparação e operadores lógicos usando o banco Loja Virtual.

## Pré-requisitos

- Módulos 01 e 02 concluídos.
- Banco preparado com [`database/setup.sql`](../../database/setup.sql).

## Conteúdo

- Comparações com `=`, `<>`, `!=`, `>`, `<`, `>=` e `<=`.
- Operadores `AND`, `OR` e `NOT`.
- Precedência e uso de parênteses.
- Filtros com textos, números, datas e expressões.
- Cuidados com `NULL` e conversões implícitas.

## Roteiro

1. Leia [`teoria.md`](teoria.md).
2. Execute [`exemplos.sql`](exemplos.sql).
3. Resolva [`exercicios.md`](exercicios.md).
4. Faça [`desafios.md`](desafios.md).
5. Compare com [`solucoes.sql`](solucoes.sql).
6. Revise boas práticas, erros e quiz.

## Primeira consulta

```sql
SELECT cliente_id, nome, status
FROM clientes
WHERE status = 'ATIVO';
```

## Checklist

- [ ] Filtrar texto, número e data.
- [ ] Combinar condições com `AND` e `OR`.
- [ ] Usar parênteses corretamente.
- [ ] Reconhecer comparações incorretas com `NULL`.

## Próximo módulo

➡️ [Módulo 04 — ORDER BY](../04-order-by)
